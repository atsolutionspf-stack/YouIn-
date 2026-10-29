import { describe, expect, it } from 'vitest';
import { validateEventForm, type EventFormValues } from './eventForm';

const base: EventFormValues = {
  title: 'Noche', description: '', venueEntityId: '', venueName: 'Sala', address: 'Calle 1', municipality: 'València',
  province: 'Valencia', area: '', lat: 39.47, lng: -0.37, startDate: '2026-11-06', startTime: '23:00', endDate: '2026-11-07',
  endTime: '06:00', genre: 'House', priceKind: 'fixed', price: '12', priceNote: '', ticketUrl: '', posterStyle: 'groove', age: '', status: 'published',
};
const now = new Date('2026-10-29T12:00:00Z');

describe('validateEventForm', () => {
  it('acepta un evento nocturno que termina al día siguiente y convierte a UTC con hora de Madrid', () => {
    const r = validateEventForm(base, now);
    expect(r.ok).toBe(true);
    if (r.ok) {
      expect(r.input.starts_at).toBe('2026-11-06T22:00:00.000Z');
      expect(r.input.ends_at).toBe('2026-11-07T05:00:00.000Z');
    }
  });
  it('rechaza un final anterior al inicio (olvidar el día siguiente)', () => {
    const r = validateEventForm({ ...base, endDate: '2026-11-06' }, now);
    expect(r.ok).toBe(false);
    if (!r.ok) expect(r.errors.end).toMatch(/día siguiente/);
  });
  it('no inventa coordenadas: exige ambas o ninguna, y dentro de la Comunitat', () => {
    expect(validateEventForm({ ...base, lng: null }, now).ok).toBe(false);
    expect(validateEventForm({ ...base, lat: 41.4, lng: 2.17 }, now).ok).toBe(false);
  });
  it('precio desconocido se guarda como null; enlaces de compra solo https', () => {
    const r = validateEventForm({ ...base, priceKind: 'unknown', price: '' }, now);
    expect(r.ok && r.input.price).toBe(null);
    expect(validateEventForm({ ...base, ticketUrl: 'http://x.com' }, now).ok).toBe(false);
  });
  it('un borrador puede estar en el pasado; publicado no', () => {
    const past = { ...base, startDate: '2026-10-01', endDate: '2026-10-02' };
    expect(validateEventForm(past, now).ok).toBe(false);
    expect(validateEventForm({ ...past, status: 'draft' }, now).ok).toBe(true);
  });
});
