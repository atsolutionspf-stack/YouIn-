// Eventos, perfiles, favoritos, seguimiento y permisos contra Supabase local.
import { describe, expect, it } from 'vitest';
import { anon, demoUser, freshUser } from './helpers';
import { madridToUtcIso, addDaysKey, madridDateKey } from '../../src/lib/domain/time';

async function entityBySlugLike(name: string) {
  const { data } = await anon().from('entities').select('id, kind, data_origin').eq('name', name).single();
  return data!;
}

describe('eventos y perfiles', () => {
  it('un administrador publica un evento que aparece en mapa y lista, y la mención va a la agenda del DJ', async () => {
    const admin = await demoUser('casagroove');
    const casa = await entityBySlugLike('Casa Groove');
    const luna = await entityBySlugLike('Luna Serra');
    const day = addDaysKey(madridDateKey(new Date()), 5);
    const title = `Prueba de publicación ${Date.now()}`;
    const ins = await admin.client.from('events').insert({
      title, venue_name: 'Sala de prueba', address: 'Calle de prueba 1', municipality: 'València', province: 'Valencia',
      lat: 39.47, lng: -0.376, starts_at: madridToUtcIso(`${day}T23:00`), ends_at: madridToUtcIso(`${addDaysKey(day, 1)}T06:00`),
      genre: 'House', price: 10, price_kind: 'fixed', organizer_entity_id: casa.id, created_by: admin.user.id, data_origin: 'user',
    }).select('id').single();
    expect(ins.error).toBeNull();
    const eventId = ins.data!.id;
    expect((await admin.client.from('event_artists').insert({ event_id: eventId, entity_id: luna.id })).error).toBeNull();

    // Visible para cualquiera, con coordenadas para el mapa.
    const pub = await anon().from('events').select('id, lat, lng, status, event_artists(entity_id, hidden_by_artist)').eq('id', eventId).single();
    expect(pub.data).toMatchObject({ status: 'published', lat: 39.47, lng: -0.376 });

    // La DJ lo oculta de su perfil: el evento sigue existiendo.
    const dj = await demoUser('luna');
    const hide = await dj.client.from('event_artists').update({ hidden_by_artist: true }).eq('event_id', eventId).eq('entity_id', luna.id).select();
    expect(hide.error).toBeNull();
    expect(hide.data).toHaveLength(1);
    const still = await anon().from('events').select('id, title, event_artists(hidden_by_artist)').eq('id', eventId).single();
    expect(still.data!.title).toBe(title);
    expect(still.data!.event_artists[0].hidden_by_artist).toBe(true);

    // La DJ no puede editar el evento original.
    const tamper = await dj.client.from('events').update({ title: 'cambiado por la DJ' }).eq('id', eventId).select();
    expect(tamper.data ?? []).toHaveLength(0);
    // Ni borrar la mención.
    await dj.client.from('event_artists').delete().eq('event_id', eventId);
    const mention = await anon().from('event_artists').select('entity_id').eq('event_id', eventId);
    expect(mention.data).toHaveLength(1);

    await admin.client.from('events').delete().eq('id', eventId);
  });

  it('un usuario sin permisos no puede publicar en nombre de otra entidad ni editar perfiles ajenos', async () => {
    const u = await freshUser('Sin permisos');
    const casa = await entityBySlugLike('Casa Groove');
    const ins = await u.client.from('events').insert({
      title: 'Intruso', venue_name: 'x', address: 'x', starts_at: new Date(Date.now() + 86400000).toISOString(),
      ends_at: new Date(Date.now() + 2 * 86400000).toISOString(), organizer_entity_id: casa.id, created_by: u.user.id, price: 0,
    });
    expect(ins.error).not.toBeNull();
    const upd = await u.client.from('entities').update({ bio: 'hackeado' }).eq('id', casa.id).select();
    expect(upd.data ?? []).toHaveLength(0);
    const prof = await u.client.from('profiles').update({ display_name: 'hackeado' }).neq('id', u.user.id).select('id');
    expect(prof.data ?? []).toHaveLength(0);
    // Un DJ tampoco puede publicar eventos (solo salas y colectivos).
    const dj = await demoUser('luna');
    const luna = await entityBySlugLike('Luna Serra');
    const djIns = await dj.client.from('events').insert({
      title: 'DJ publica', venue_name: 'x', address: 'x', starts_at: new Date(Date.now() + 86400000).toISOString(),
      ends_at: new Date(Date.now() + 2 * 86400000).toISOString(), organizer_entity_id: luna.id, created_by: dj.user.id, price: 0,
    });
    expect(djIns.error).not.toBeNull();
  });

  it('los perfiles importados no se pueden editar ni reclamar', async () => {
    const { data: imported } = await anon().from('entities').select('id').eq('data_origin', 'imported').eq('kind', 'venue').limit(1).single();
    const u = await freshUser('Reclamante');
    const upd = await u.client.from('entities').update({ name: 'Mía' }).eq('id', imported!.id).select();
    expect(upd.data ?? []).toHaveLength(0);
    const claim = await u.client.from('entity_admins').insert({ entity_id: imported!.id, user_id: u.user.id, role: 'owner' });
    expect(claim.error).not.toBeNull();
    const createCommunity = await u.client.rpc('create_community', { p_entity: imported!.id, p_name: 'Robada' });
    expect(createCommunity.error).not.toBeNull();
  });

  it('favoritos y seguidos persisten al cerrar sesión y volver a entrar, y son privados', async () => {
    const u = await freshUser('Persistente');
    const { data: ev } = await anon().from('events').select('id').eq('data_origin', 'demo').limit(1).single();
    const casa = await entityBySlugLike('Casa Groove');
    await u.client.from('favorites').insert({ user_id: u.user.id, event_id: ev!.id });
    await u.client.from('follows').insert({ user_id: u.user.id, entity_id: casa.id });
    await u.client.auth.signOut();

    const again = anon();
    await again.auth.signInWithPassword({ email: u.email, password: u.password });
    const favs = await again.from('favorites').select('event_id');
    const fol = await again.from('follows').select('entity_id');
    expect(favs.data!.map((f) => f.event_id)).toContain(ev!.id);
    expect(fol.data!.map((f) => f.entity_id)).toContain(casa.id);

    const other = await freshUser('Curiosa');
    const spy = await other.client.from('favorites').select('event_id').eq('user_id', u.user.id);
    expect(spy.data).toHaveLength(0);
  });

  it('membresías persisten al cerrar sesión y volver a entrar', async () => {
    const u = await freshUser('Miembro fiel');
    const { data: c } = await anon().from('communities').select('id').eq('slug', 'bajo-la-superficie').single();
    await u.client.rpc('join_community', { p_community: c!.id });
    await u.client.auth.signOut();
    const again = anon();
    await again.auth.signInWithPassword({ email: u.email, password: u.password });
    const mine = await again.rpc('my_communities');
    expect(mine.data!.map((r: { community_id: string }) => r.community_id)).toContain(c!.id);
  });

  it('activar el perfil de DJ crea una sola entidad, editable solo por su dueña', async () => {
    const u = await freshUser('Nueva DJ');
    const first = await u.client.rpc('activate_dj_profile', { p_artist_name: 'DJ Prueba' });
    const second = await u.client.rpc('activate_dj_profile', { p_artist_name: 'Otro nombre' });
    expect(first.data).toBe(second.data);
    const upd = await u.client.from('entities').update({ tagline: 'Hola', accent: '#386B68' }).eq('id', first.data).select('tagline');
    expect(upd.data![0].tagline).toBe('Hola');
    // No puede cambiar campos protegidos.
    const protectedField = await u.client.from('entities').update({ data_origin: 'imported' }).eq('id', first.data);
    expect(protectedField.error).not.toBeNull();
  });
});
