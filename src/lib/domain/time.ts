// Fechas y horas en Europe/Madrid.
//
// "Jornada de ocio": un evento pertenece al día en que empieza su noche. Una
// fiesta que empieza el sábado a las 00:30 forma parte de la noche del viernes.
// El corte es a las 06:00 (hora de Madrid). Los filtros "hoy", "mañana" y
// "fin de semana" usan esta jornada y, además, nunca muestran eventos ya
// terminados.

export const TZ = 'Europe/Madrid';
export const NIGHT_CUTOFF_HOURS = 6;

const ymdFormatter = new Intl.DateTimeFormat('en-CA', { timeZone: TZ, year: 'numeric', month: '2-digit', day: '2-digit' });
const partsFormatter = new Intl.DateTimeFormat('sv-SE', {
  timeZone: TZ, year: 'numeric', month: '2-digit', day: '2-digit', hour: '2-digit', minute: '2-digit', hourCycle: 'h23',
});

/** AAAA-MM-DD de un instante en Madrid. */
export function madridDateKey(d: Date | string | number): string {
  return ymdFormatter.format(new Date(d));
}

/** "AAAA-MM-DDTHH:MM" local de Madrid (útil para inputs). */
export function madridLocalInput(d: Date | string | number): string {
  return partsFormatter.format(new Date(d)).replace(' ', 'T');
}

/**
 * Convierte una hora local de Madrid ("AAAA-MM-DDTHH:MM") a instante UTC (ISO).
 * En la hora repetida de octubre elige la primera; rechaza horas inexistentes de marzo.
 */
export function madridToUtcIso(local: string): string {
  if (!/^\d{4}-\d{2}-\d{2}T\d{2}:\d{2}$/.test(local)) throw new Error('Fecha u hora no válida');
  const asUtc = new Date(local + ':00Z');
  if (Number.isNaN(+asUtc)) throw new Error('Fecha u hora no válida');
  for (const offset of [2, 1]) {
    const candidate = new Date(+asUtc - offset * 3600_000);
    if (madridLocalInput(candidate) === local) return candidate.toISOString();
  }
  throw new Error('Esa hora no existe en Madrid por el cambio horario');
}

/** Suma días a una clave AAAA-MM-DD (aritmética de calendario, sin husos). */
export function addDaysKey(key: string, days: number): string {
  const d = new Date(key + 'T12:00:00Z');
  d.setUTCDate(d.getUTCDate() + days);
  return d.toISOString().slice(0, 10);
}

/** Día de la semana (1 = lunes … 7 = domingo) de una clave AAAA-MM-DD. */
export function isoWeekday(key: string): number {
  const d = new Date(key + 'T12:00:00Z').getUTCDay();
  return d === 0 ? 7 : d;
}

/** Jornada de ocio (AAAA-MM-DD) a la que pertenece un instante. */
export function nightDateKey(d: Date | string | number): string {
  return madridDateKey(+new Date(d) - NIGHT_CUTOFF_HOURS * 3600_000);
}

export type DatePreset = 'all' | 'today' | 'tomorrow' | 'weekend' | 'custom';

/** Jornadas (AAAA-MM-DD) incluidas en un filtro rápido. */
export function presetNightKeys(preset: DatePreset, now: Date = new Date(), custom?: { from?: string; to?: string }): string[] | null {
  const today = nightDateKey(now);
  switch (preset) {
    case 'all':
      return null;
    case 'today':
      return [today];
    case 'tomorrow':
      return [addDaysKey(today, 1)];
    case 'weekend': {
      // Viernes, sábado y domingo de esta semana; si ya es fin de semana, lo que queda de él.
      const wd = isoWeekday(today);
      const friday = wd <= 5 ? addDaysKey(today, 5 - wd) : addDaysKey(today, -(wd - 5));
      return [friday, addDaysKey(friday, 1), addDaysKey(friday, 2)].filter((k) => k >= today);
    }
    case 'custom': {
      const from = custom?.from || today;
      const to = custom?.to && custom.to >= from ? custom.to : from;
      const keys: string[] = [];
      for (let k = from; k <= to && keys.length < 120; k = addDaysKey(k, 1)) keys.push(k);
      return keys;
    }
  }
}

type Timed = { starts_at: string; ends_at: string };

/** ¿El evento cae en alguna de las jornadas indicadas y no ha terminado? */
export function matchesNightKeys(e: Timed, keys: string[] | null, now: Date = new Date()): boolean {
  if (+new Date(e.ends_at) <= +now) return false;
  if (!keys) return true;
  const startNight = nightDateKey(e.starts_at);
  if (keys.includes(startNight)) return true;
  // Eventos de varios días (festivales): cuenta cualquier jornada que abarquen.
  const endNight = nightDateKey(+new Date(e.ends_at) - 1);
  return keys.some((k) => k > startNight && k <= endNight);
}

/** ¿Está ocurriendo ahora? */
export function isHappeningNow(e: Timed & { time_warning?: string | null }, now: Date = new Date()): boolean {
  return !e.time_warning && +new Date(e.starts_at) <= +now && +new Date(e.ends_at) > +now;
}

/** Días naturales (Madrid) que toca un evento: para el calendario mensual. */
export function eventCalendarKeys(e: Timed): string[] {
  const first = madridDateKey(e.starts_at);
  const last = madridDateKey(+new Date(e.ends_at) - 1);
  const keys: string[] = [];
  for (let k = first; k <= last && keys.length < 62; k = addDaysKey(k, 1)) keys.push(k);
  return keys;
}

const hourFmt = new Intl.DateTimeFormat('es-ES', { timeZone: TZ, hour: '2-digit', minute: '2-digit', hourCycle: 'h23' });
const dayFmt = new Intl.DateTimeFormat('es-ES', { timeZone: TZ, weekday: 'short', day: 'numeric', month: 'short' });
const longDayFmt = new Intl.DateTimeFormat('es-ES', { timeZone: TZ, weekday: 'long', day: 'numeric', month: 'long' });
const dateTimeFmt = new Intl.DateTimeFormat('es-ES', { timeZone: TZ, day: '2-digit', month: '2-digit', year: 'numeric', hour: '2-digit', minute: '2-digit', hourCycle: 'h23' });
const dateFmt = new Intl.DateTimeFormat('es-ES', { timeZone: TZ, day: '2-digit', month: '2-digit', year: 'numeric' });

export const formatHour = (d: string | Date) => hourFmt.format(new Date(d));
export const formatDay = (d: string | Date) => dayFmt.format(new Date(d));
export const formatLongDay = (d: string | Date) => longDayFmt.format(new Date(d));
export const formatDateTime = (d: string | Date) => dateTimeFmt.format(new Date(d));
export const formatDate = (d: string | Date) => dateFmt.format(new Date(d));

/** "23:00–06:00", "23:00–cierre" o "23:00 · fin a revisar". */
export function formatHours(e: Timed & { until_late?: boolean; time_warning?: string | null }): string {
  if (e.time_warning) return `${formatHour(e.starts_at)} · fin a revisar`;
  if (e.until_late) return `${formatHour(e.starts_at)}–cierre`;
  return `${formatHour(e.starts_at)}–${formatHour(e.ends_at)}`;
}

/** Relativo y compacto para mensajes: "hace 3 min", "ayer 22:10", "12/10/2026 18:00". */
export function formatMessageTime(d: string | Date, now: Date = new Date()): string {
  const t = new Date(d);
  const diff = (+now - +t) / 1000;
  if (diff < 60) return 'ahora';
  if (diff < 3600) return `hace ${Math.floor(diff / 60)} min`;
  const key = madridDateKey(t);
  const today = madridDateKey(now);
  if (key === today) return formatHour(t);
  if (key === addDaysKey(today, -1)) return `ayer ${formatHour(t)}`;
  return formatDateTime(t);
}
