import { describe, expect, it } from 'vitest';
import {
  eventCalendarKeys, isHappeningNow, madridDateKey, madridToUtcIso, matchesNightKeys, nightDateKey, presetNightKeys,
} from './time';

describe('madridToUtcIso', () => {
  it('convierte horario de verano (+02:00)', () => {
    expect(madridToUtcIso('2026-07-10T23:00')).toBe('2026-07-10T21:00:00.000Z');
  });
  it('convierte horario de invierno (+01:00)', () => {
    expect(madridToUtcIso('2026-12-31T23:00')).toBe('2026-12-31T22:00:00.000Z');
  });
  it('rechaza la hora inexistente del cambio de marzo', () => {
    expect(() => madridToUtcIso('2027-03-28T02:30')).toThrow();
  });
  it('en la hora repetida de octubre elige la primera', () => {
    expect(madridToUtcIso('2026-10-25T02:30')).toBe('2026-10-25T00:30:00.000Z');
  });
});

describe('jornada de ocio', () => {
  it('un evento a las 00:30 del sábado pertenece a la noche del viernes', () => {
    // 2026-10-31 es sábado. 00:30 Madrid (CET tras el cambio) = 23:30Z del 30.
    expect(nightDateKey('2026-10-30T23:30:00Z')).toBe('2026-10-30');
  });
  it('un evento a las 22:00 pertenece a su propio día', () => {
    expect(nightDateKey('2026-10-30T21:00:00Z')).toBe('2026-10-30');
  });
  it('madridDateKey usa la fecha local, no la UTC', () => {
    expect(madridDateKey('2026-10-30T23:30:00Z')).toBe('2026-10-31');
  });
});

describe('filtros rápidos', () => {
  const thursdayNoon = new Date('2026-10-29T11:00:00Z');
  it('hoy, mañana y fin de semana desde un jueves', () => {
    expect(presetNightKeys('today', thursdayNoon)).toEqual(['2026-10-29']);
    expect(presetNightKeys('tomorrow', thursdayNoon)).toEqual(['2026-10-30']);
    expect(presetNightKeys('weekend', thursdayNoon)).toEqual(['2026-10-30', '2026-10-31', '2026-11-01']);
  });
  it('a las 03:00 del sábado "hoy" sigue siendo la noche del viernes', () => {
    expect(presetNightKeys('today', new Date('2026-10-31T02:00:00Z'))).toEqual(['2026-10-30']);
  });
  it('el domingo, el fin de semana solo incluye lo que queda', () => {
    expect(presetNightKeys('weekend', new Date('2026-11-01T12:00:00Z'))).toEqual(['2026-11-01']);
  });
  it('un evento que termina al día siguiente cuenta para su noche de inicio y desaparece al terminar', () => {
    const e = { starts_at: '2026-10-29T22:00:00Z', ends_at: '2026-10-30T05:00:00Z' };
    expect(matchesNightKeys(e, ['2026-10-29'], thursdayNoon)).toBe(true);
    expect(matchesNightKeys(e, ['2026-10-30'], thursdayNoon)).toBe(false);
    expect(matchesNightKeys(e, null, new Date('2026-10-30T05:00:00Z'))).toBe(false);
  });
  it('un festival de varios días cuenta en cada jornada', () => {
    const e = { starts_at: '2026-10-30T16:00:00Z', ends_at: '2026-11-01T23:00:00Z' };
    expect(matchesNightKeys(e, ['2026-10-31'], thursdayNoon)).toBe(true);
  });
});

describe('calendario y en curso', () => {
  it('un evento nocturno aparece también el día en que termina', () => {
    expect(eventCalendarKeys({ starts_at: '2026-10-29T21:00:00Z', ends_at: '2026-10-30T04:00:00Z' })).toEqual(['2026-10-29', '2026-10-30']);
  });
  it('un evento que termina justo a medianoche no ocupa el día siguiente', () => {
    expect(eventCalendarKeys({ starts_at: '2026-10-29T18:00:00Z', ends_at: '2026-10-29T23:00:00Z' })).toEqual(['2026-10-29']);
  });
  it('no marca en curso si el horario está pendiente de revisar', () => {
    const e = { starts_at: '2026-10-29T10:00:00Z', ends_at: '2026-10-29T20:00:00Z', time_warning: 'revisar' };
    expect(isHappeningNow(e, new Date('2026-10-29T12:00:00Z'))).toBe(false);
  });
});
