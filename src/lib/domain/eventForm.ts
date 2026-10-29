// Validación del formulario de eventos (la base de datos vuelve a comprobarlo
// con restricciones CHECK y políticas RLS).
import type { EventInput } from '@/lib/data/events';
import { inRegion, safeHttpsUrl } from './events';
import { madridToUtcIso } from './time';

export type EventFormValues = {
  title: string;
  description: string;
  venueEntityId: string;
  venueName: string;
  address: string;
  municipality: string;
  province: string;
  area: string;
  lat: number | null;
  lng: number | null;
  startDate: string;
  startTime: string;
  endDate: string;
  endTime: string;
  untilLate?: boolean;
  genre: string;
  priceKind: EventInput['price_kind'];
  price: string;
  priceNote: string;
  ticketUrl: string;
  posterStyle: string;
  age: string;
  status: EventInput['status'];
};

export type EventFormResult = { ok: true; input: Omit<EventInput, 'poster_path' | 'video_path'> } | { ok: false; errors: Record<string, string> };

export function validateEventForm(v: EventFormValues, now: Date = new Date()): EventFormResult {
  const errors: Record<string, string> = {};
  if (!v.title.trim()) errors.title = 'Ponle nombre al evento.';
  if (v.title.length > 120) errors.title = 'Máximo 120 caracteres.';
  if (!v.venueName.trim()) errors.venueName = 'Indica la sala o el espacio.';
  if (!v.address.trim()) errors.address = 'Indica la dirección.';
  if (!v.municipality.trim()) errors.municipality = 'Indica el municipio.';
  if (!['Valencia', 'Alicante', 'Castellón'].includes(v.province)) errors.province = 'Provincia no válida.';

  let starts = '';
  let ends = '';
  try { starts = madridToUtcIso(`${v.startDate}T${v.startTime}`); } catch (e) { errors.start = (e as Error).message; }
  try { ends = madridToUtcIso(`${v.endDate}T${v.endTime}`); } catch (e) { errors.end = (e as Error).message; }
  if (starts && ends && +new Date(ends) <= +new Date(starts)) errors.end = 'El final debe ser posterior al inicio (si termina de madrugada, elige el día siguiente).';
  if (starts && ends && +new Date(ends) - +new Date(starts) > 7 * 24 * 3600_000) errors.end = 'Un evento no puede durar más de 7 días.';
  if (ends && +new Date(ends) <= +now && v.status === 'published') errors.end = 'Un evento publicado debe terminar en el futuro.';

  if ((v.lat === null) !== (v.lng === null)) errors.location = 'Completa latitud y longitud, o deja ambas vacías.';
  else if (v.lat !== null && v.lng !== null && !inRegion(v.lat, v.lng)) errors.location = 'La ubicación debe estar dentro de la Comunitat Valenciana.';

  let price: number | null = null;
  if (v.priceKind === 'unknown') price = null;
  else if (v.priceKind === 'conditional-free') price = 0;
  else {
    price = Number(v.price.replace(',', '.'));
    if (v.price.trim() === '' || !Number.isFinite(price) || price < 0 || price > 10000) errors.price = 'Introduce un precio entre 0 y 10.000 €.';
  }
  if (v.ticketUrl.trim() && !safeHttpsUrl(v.ticketUrl.trim())) errors.ticketUrl = 'El enlace de entradas debe empezar por https://';

  if (Object.keys(errors).length) return { ok: false, errors };
  return {
    ok: true,
    input: {
      title: v.title.trim(),
      description: v.description.trim() || null,
      starts_at: starts,
      ends_at: ends,
      venue_entity_id: v.venueEntityId || null,
      venue_name: v.venueName.trim(),
      address: v.address.trim(),
      area: v.area.trim() || null,
      municipality: v.municipality.trim(),
      province: v.province,
      lat: v.lat as number,
      lng: v.lng as number,
      genre: v.genre || 'Sin clasificar',
      price,
      price_kind: v.priceKind,
      price_note: v.priceNote.trim() || null,
      ticket_url: safeHttpsUrl(v.ticketUrl.trim()) || null,
      poster_style: ['groove', 'orbita', 'sol', 'onda'].includes(v.posterStyle) ? v.posterStyle : 'groove',
      age: v.age.trim() || null,
      status: v.status,
    },
  };
}
