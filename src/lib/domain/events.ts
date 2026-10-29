// Reglas de descubrimiento: filtros, búsqueda, agrupación por ubicación,
// precio y procedencia de los datos. Sin dependencias de interfaz ni de red.
import type { DiscoveryEvent, EntitySummary, SourceLink } from '@/lib/types';
import { formatDate, isHappeningNow, matchesNightKeys, presetNightKeys, type DatePreset } from './time';

export const GENRES = ['House', 'Techno', 'Disco', 'Reggaetón', 'En directo', 'Sin clasificar'] as const;
export const PRICE_OPTIONS = [
  { value: 'any', label: 'Cualquier precio' },
  { value: 'free', label: 'Gratis' },
  { value: '10', label: 'Hasta 10 €' },
  { value: '15', label: 'Hasta 15 €' },
  { value: '20', label: 'Hasta 20 €' },
  { value: '30', label: 'Hasta 30 €' },
] as const;
export type PriceFilter = (typeof PRICE_OPTIONS)[number]['value'];

export type OriginFilter = 'published' | 'demo';

export type EventFilters = {
  origin: OriginFilter;
  date: DatePreset;
  dateFrom?: string;
  dateTo?: string;
  genre: string; // 'Todos' o un género
  query: string;
  price: PriceFilter;
  includeUnknownPrice: boolean;
  municipality: string; // '' = todos
  area: string; // '' = todos
  near?: { lat: number; lng: number; radiusKm: number } | null;
};

export const DEFAULT_FILTERS: EventFilters = {
  origin: 'published',
  date: 'all',
  genre: 'Todos',
  query: '',
  price: 'any',
  includeUnknownPrice: true,
  municipality: '',
  area: '',
  near: null,
};

export const normalize = (v: string | null | undefined) =>
  String(v ?? '').normalize('NFD').replace(/[̀-ͯ]/g, '').toLowerCase().trim();

/** Distancia en km (haversine). */
export function distanceKm(a: { lat: number; lng: number }, b: { lat: number; lng: number }): number {
  const R = 6371;
  const dLat = ((b.lat - a.lat) * Math.PI) / 180;
  const dLng = ((b.lng - a.lng) * Math.PI) / 180;
  const s = Math.sin(dLat / 2) ** 2 + Math.cos((a.lat * Math.PI) / 180) * Math.cos((b.lat * Math.PI) / 180) * Math.sin(dLng / 2) ** 2;
  return 2 * R * Math.asin(Math.sqrt(s));
}

/** "Publicados" agrupa importados y eventos publicados en la app; "Demo", solo ficticios. */
export function matchesOrigin(e: Pick<DiscoveryEvent, 'data_origin'>, origin: OriginFilter) {
  return origin === 'demo' ? e.data_origin === 'demo' : e.data_origin !== 'demo';
}

export function matchesPrice(e: Pick<DiscoveryEvent, 'price' | 'price_kind'>, price: PriceFilter, includeUnknown: boolean) {
  const unknown = e.price === null || e.price_kind === 'unknown';
  if (price === 'any') return includeUnknown || !unknown;
  if (unknown) return includeUnknown;
  if (price === 'free') return Number(e.price) === 0;
  return Number(e.price) <= Number(price);
}

/** Texto de búsqueda: evento, sala, DJs mencionados, organizador y lugar. */
export function searchText(e: DiscoveryEvent, entities: Map<string, EntitySummary>): string {
  const names = [
    ...e.event_artists.map((a) => entities.get(a.entity_id)?.name),
    e.organizer_entity_id ? entities.get(e.organizer_entity_id)?.name : '',
    e.venue_entity_id ? entities.get(e.venue_entity_id)?.name : '',
  ];
  return normalize([e.title, e.venue_name, e.area, e.municipality, e.genre, ...(e.source_genres ?? []), ...names].join(' '));
}

export function filterEvents(
  events: DiscoveryEvent[],
  f: EventFilters,
  entities: Map<string, EntitySummary>,
  now: Date = new Date(),
): DiscoveryEvent[] {
  const keys = presetNightKeys(f.date, now, { from: f.dateFrom, to: f.dateTo });
  const q = normalize(f.query);
  const terms = q ? q.split(/\s+/) : [];
  return events
    .filter((e) => e.status === 'published')
    .filter((e) => matchesOrigin(e, f.origin))
    .filter((e) => matchesNightKeys(e, keys, now))
    // "Ahora": solo eventos en curso con horario fiable (no los marcados para revisar ni "hasta cierre").
    .filter((e) => f.date !== 'now' || (isHappeningNow(e, now) && !e.until_late))
    .filter((e) => f.genre === 'Todos' || e.genre === f.genre)
    .filter((e) => matchesPrice(e, f.price, f.includeUnknownPrice))
    .filter((e) => !f.municipality || normalize(e.municipality) === normalize(f.municipality))
    .filter((e) => !f.area || normalize(e.area) === normalize(f.area))
    .filter((e) => {
      if (!f.near) return true;
      if (e.lat === null || e.lng === null) return false;
      return distanceKm(f.near, { lat: e.lat, lng: e.lng }) <= f.near.radiusKm;
    })
    .filter((e) => {
      if (!terms.length) return true;
      const text = searchText(e, entities);
      return terms.every((t) => text.includes(t));
    })
    .sort((a, b) => +new Date(a.starts_at) - +new Date(b.starts_at));
}

export type LocationGroup = { key: string; lat: number; lng: number; events: DiscoveryEvent[] };

/**
 * Agrupa por ubicación exacta (4 decimales ≈ 11 m). Solo eventos con coordenadas
 * publicadas: si no hay coordenadas, el evento sale en la lista pero no en el mapa.
 */
export function groupByLocation(events: DiscoveryEvent[]): LocationGroup[] {
  const groups = new Map<string, LocationGroup>();
  for (const e of events) {
    if (e.lat === null || e.lng === null || !Number.isFinite(e.lat) || !Number.isFinite(e.lng)) continue;
    const key = `${e.lat.toFixed(4)},${e.lng.toFixed(4)}`;
    const g = groups.get(key) ?? { key, lat: e.lat, lng: e.lng, events: [] };
    g.events.push(e);
    groups.set(key, g);
  }
  return [...groups.values()];
}

const money = (p: number) =>
  new Intl.NumberFormat('es-ES', { style: 'currency', currency: 'EUR', maximumFractionDigits: 2 }).format(p);

/** Precio tal como se publicó: nunca se completa un precio que no existe. */
export function formatPrice(e: Pick<DiscoveryEvent, 'price' | 'price_kind'>): string {
  if (e.price === null || e.price_kind === 'unknown') return 'Consultar';
  if (e.price_kind === 'conditional-free') return 'Lista gratis*';
  if (Number(e.price) === 0) return 'Gratis';
  return (e.price_kind === 'from' ? 'Desde ' : '') + money(Number(e.price));
}

export function providerLabel(e: Pick<DiscoveryEvent, 'ticket_provider_id' | 'sources'>): string {
  const sources = (e.sources ?? []) as SourceLink[];
  if (e.ticket_provider_id === 'xceed') return 'Xceed';
  if (sources.some((s) => s.label === 'Marina Beach Club')) return 'Marina · Fourvenues';
  if (e.ticket_provider_id === 'fourvenues') return 'Fourvenues';
  return 'Enlace externo';
}

/** Etiqueta de procedencia, visible en tarjeta y ficha. */
export function provenance(e: Pick<DiscoveryEvent, 'data_origin' | 'ticket_provider_id' | 'sources' | 'verified_at'>): {
  label: string;
  tone: 'imported' | 'demo' | 'user';
  detail: string;
} {
  if (e.data_origin === 'demo') return { label: 'Demo', tone: 'demo', detail: 'Evento ficticio. No hay entradas a la venta.' };
  if (e.data_origin === 'imported') {
    const consulted = e.verified_at ? formatDate(e.verified_at) : 'fecha desconocida';
    return {
      label: providerLabel(e),
      tone: 'imported',
      detail: `Publicado en ${providerLabel(e)} · consulta del ${consulted}. Importación puntual: precio, horario y disponibilidad pueden haber cambiado.`,
    };
  }
  return { label: 'Publicado en YOU IN?', tone: 'user', detail: 'Datos indicados por el organizador.' };
}

/** Opciones de municipio y barrio presentes en los eventos (para los filtros). */
export function locationOptions(events: DiscoveryEvent[]) {
  const municipalities = new Map<string, Set<string>>();
  for (const e of events) {
    const m = e.municipality || 'València';
    if (!municipalities.has(m)) municipalities.set(m, new Set());
    if (e.area) municipalities.get(m)!.add(e.area);
  }
  return [...municipalities.entries()]
    .map(([name, areas]) => ({ name, areas: [...areas].sort((a, b) => a.localeCompare(b, 'es')) }))
    .sort((a, b) => a.name.localeCompare(b.name, 'es'));
}

export const VALENCIA_CENTER = { lat: 39.47, lng: -0.376 };
export const REGION_BOUNDS = { minLat: 37.75, maxLat: 40.85, minLng: -1.6, maxLng: 0.65 };
export const inRegion = (lat: number, lng: number) =>
  lat >= REGION_BOUNDS.minLat && lat <= REGION_BOUNDS.maxLat && lng >= REGION_BOUNDS.minLng && lng <= REGION_BOUNDS.maxLng;

export function safeHttpsUrl(value: string | null | undefined): string {
  if (!value) return '';
  try {
    const u = new URL(value);
    return u.protocol === 'https:' ? u.href : '';
  } catch {
    return '';
  }
}
