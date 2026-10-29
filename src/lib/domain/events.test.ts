import { describe, expect, it } from 'vitest';
import type { DiscoveryEvent, EntitySummary } from '@/lib/types';
import { DEFAULT_FILTERS, filterEvents, formatPrice, groupByLocation, matchesPrice, provenance } from './events';

const now = new Date('2026-10-29T11:00:00Z');
let n = 0;
function ev(p: Partial<DiscoveryEvent>): DiscoveryEvent {
  n++;
  return {
    id: `e${n}`, title: `Evento ${n}`, description: null, starts_at: '2026-10-29T21:00:00Z', ends_at: '2026-10-30T04:00:00Z',
    until_late: false, time_warning: null, venue_entity_id: null, venue_name: 'Sala', room: null, address: 'x', area: 'RUSSAFA',
    municipality: 'València', province: 'Valencia', lat: 39.46, lng: -0.37, location_precision: 'source-coordinates', genre: 'House',
    source_genres: [], price: 10, price_kind: 'fixed', price_note: null, ticket_url: null, ticket_provider_id: null, poster_path: null,
    poster_url: null, poster_style: 'groove', video_path: null, age: null, organizer_entity_id: null, status: 'published',
    data_origin: 'imported', import_batch_id: null, sources: [], verified_at: '2026-10-19T08:31:12Z', event_artists: [], ...p,
  } as DiscoveryEvent;
}
const dj: EntitySummary = { id: 'dj1', kind: 'dj', slug: 'luna', name: 'Luna Serra', initials: 'LS', color: 'peach', photo_path: null, image_url: null, genres: [], area: null, municipality: null, data_origin: 'demo', tagline: null };
const entities = new Map([[dj.id, dj]]);

describe('filterEvents', () => {
  it('separa datos demo de publicados/importados', () => {
    const list = [ev({ data_origin: 'demo' }), ev({ data_origin: 'imported' }), ev({ data_origin: 'user' })];
    expect(filterEvents(list, DEFAULT_FILTERS, entities, now)).toHaveLength(2);
    expect(filterEvents(list, { ...DEFAULT_FILTERS, origin: 'demo' }, entities, now)).toHaveLength(1);
  });
  it('busca por nombre de DJ mencionado', () => {
    const list = [ev({ event_artists: [{ entity_id: 'dj1', position: 0, hidden_by_artist: false }] }), ev({})];
    expect(filterEvents(list, { ...DEFAULT_FILTERS, query: 'luna' }, entities, now)).toHaveLength(1);
  });
  it('excluye eventos terminados', () => {
    expect(filterEvents([ev({ starts_at: '2026-10-28T21:00:00Z', ends_at: '2026-10-29T04:00:00Z' })], DEFAULT_FILTERS, entities, now)).toHaveLength(0);
  });
  it('filtra por hoy/mañana con la jornada nocturna', () => {
    const tonight = ev({ starts_at: '2026-10-29T23:30:00Z', ends_at: '2026-10-30T05:00:00Z' }); // 00:30 del viernes => noche del jueves
    const tomorrow = ev({ starts_at: '2026-10-30T21:00:00Z', ends_at: '2026-10-31T04:00:00Z' });
    expect(filterEvents([tonight, tomorrow], { ...DEFAULT_FILTERS, date: 'today' }, entities, now).map((e) => e.id)).toEqual([tonight.id]);
    expect(filterEvents([tonight, tomorrow], { ...DEFAULT_FILTERS, date: 'tomorrow' }, entities, now).map((e) => e.id)).toEqual([tomorrow.id]);
  });
  it('cerca de mí usa la distancia real y excluye eventos sin coordenadas', () => {
    const near = ev({ lat: 39.47, lng: -0.376 });
    const far = ev({ lat: 38.34, lng: -0.49 });
    const noCoords = ev({ lat: null, lng: null });
    const r = filterEvents([near, far, noCoords], { ...DEFAULT_FILTERS, near: { lat: 39.47, lng: -0.37, radiusKm: 5 } }, entities, now);
    expect(r.map((e) => e.id)).toEqual([near.id]);
  });
});

describe('precio', () => {
  it('precio desconocido se muestra como Consultar y respeta el filtro', () => {
    const e = ev({ price: null, price_kind: 'unknown' });
    expect(formatPrice(e)).toBe('Consultar');
    expect(matchesPrice(e, '10', false)).toBe(false);
    expect(matchesPrice(e, '10', true)).toBe(true);
  });
  it('desde y lista gratis', () => {
    expect(formatPrice(ev({ price: 12, price_kind: 'from' }))).toMatch(/^Desde 12/);
    expect(formatPrice(ev({ price: 0, price_kind: 'conditional-free' }))).toBe('Lista gratis*');
    expect(formatPrice(ev({ price: 0, price_kind: 'fixed' }))).toBe('Gratis');
  });
});

describe('agrupación y procedencia', () => {
  it('agrupa varios eventos en el mismo lugar y omite los que no tienen coordenadas', () => {
    const groups = groupByLocation([ev({ lat: 39.1, lng: -0.3 }), ev({ lat: 39.1, lng: -0.3 }), ev({ lat: null, lng: null })]);
    expect(groups).toHaveLength(1);
    expect(groups[0].events).toHaveLength(2);
  });
  it('etiqueta importados con fuente y fecha de consulta', () => {
    const p = provenance(ev({ ticket_provider_id: 'xceed' }));
    expect(p.label).toBe('Xceed');
    expect(p.detail).toMatch(/19\/10\/2026/);
    expect(provenance(ev({ data_origin: 'demo' })).tone).toBe('demo');
  });
});
