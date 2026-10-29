// Calendario mensual de favoritos (portado del piloto): lunes primero, cada
// fuente (evento guardado o perfil seguido) con su color editable.
import type { DiscoveryEvent } from '@/lib/types';
import { addDaysKey, eventCalendarKeys, isoWeekday } from './time';

export const FAVORITE_PALETTE = ['#765466', '#AF4529', '#386B68', '#596597', '#84652D', '#97517E', '#4F704C', '#9A4F50', '#446E88', '#79613C'];

export function sourceColor(key: string, custom: Record<string, string> = {}): string {
  if (/^#[0-9a-f]{6}$/i.test(custom[key] ?? '')) return custom[key];
  let h = 0;
  for (const c of key) h = (h * 31 + c.charCodeAt(0)) >>> 0;
  return FAVORITE_PALETTE[h % FAVORITE_PALETTE.length];
}

export type MonthCell = { key: string; day: number; inMonth: boolean };

/** Celdas de un mes (6 semanas como máximo), empezando en lunes. */
export function monthCells(year: number, month: number): MonthCell[] {
  const first = `${year}-${String(month + 1).padStart(2, '0')}-01`;
  const start = addDaysKey(first, -(isoWeekday(first) - 1));
  const cells: MonthCell[] = [];
  for (let i = 0; i < 42; i++) {
    const key = addDaysKey(start, i);
    const inMonth = Number(key.slice(5, 7)) === month + 1;
    if (i >= 35 && !inMonth && cells[34] && !cells[34].inMonth) break;
    cells.push({ key, day: Number(key.slice(8, 10)), inMonth });
  }
  // Recorta la última semana si queda entera fuera del mes.
  while (cells.length > 28 && cells.slice(-7).every((c) => !c.inMonth)) cells.splice(-7);
  return cells;
}

/** Claves de fuente de un evento para el usuario: perfiles seguidos implicados o "guardado". */
export function favoriteSourceKeys(e: DiscoveryEvent, follows: Set<string>): string[] {
  const keys = [e.organizer_entity_id, e.venue_entity_id, ...e.event_artists.filter((a) => !a.hidden_by_artist).map((a) => a.entity_id)]
    .filter((id): id is string => Boolean(id && follows.has(id)));
  return keys.length ? [...new Set(keys)] : ['saved:' + e.id];
}

/** Eventos de la agenda personal: guardados + de perfiles seguidos, sin duplicados. */
export function agendaEvents(events: DiscoveryEvent[], favorites: Set<string>, follows: Set<string>, now = new Date()): DiscoveryEvent[] {
  return events
    .filter((e) => +new Date(e.ends_at) > +now)
    .filter((e) => favorites.has(e.id) || favoriteSourceKeys(e, follows)[0] !== 'saved:' + e.id)
    .sort((a, b) => +new Date(a.starts_at) - +new Date(b.starts_at));
}

export function eventsOnDay(events: DiscoveryEvent[], key: string) {
  return events.filter((e) => eventCalendarKeys(e).includes(key));
}
