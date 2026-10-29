// Comunidades y chat contra Supabase local: autenticación real, RLS y Realtime.
import { describe, expect, it, beforeAll } from 'vitest';
import { anon, communityBySlug, demoUser, freshUser, sleep } from './helpers';

describe('comunidades y chat', () => {
  let community: { id: string; entity_id: string };

  beforeAll(async () => {
    community = await communityBySlug(anon(), 'la-casa-del-groove');
    // Calentamiento: tras `supabase db reset` el inquilino de Realtime arranca en frío.
    const warm = anon().channel('warmup').on('postgres_changes', { event: 'INSERT', schema: 'public', table: 'messages' }, () => {});
    await new Promise<void>((resolve) => warm.subscribe((s) => { if (s === 'SUBSCRIBED') resolve(); }));
    await sleep(3000);
    await warm.unsubscribe();
  });

  it('dos usuarios distintos entran en una comunidad y ven sus mensajes (también en tiempo real)', async () => {
    const a = await freshUser('Alba');
    const b = await freshUser('Bruno');
    expect((await a.client.rpc('join_community', { p_community: community.id })).error).toBeNull();
    expect((await b.client.rpc('join_community', { p_community: community.id })).error).toBeNull();

    // B se suscribe al canal antes de que A escriba.
    const received: { body: string; author_id: string }[] = [];
    const channel = b.client
      .channel(`test-${community.id}-${Date.now()}`)
      .on('postgres_changes', { event: 'INSERT', schema: 'public', table: 'messages', filter: `community_id=eq.${community.id}` },
        (payload) => received.push(payload.new as { body: string; author_id: string }))
    await new Promise<void>((resolve, reject) => {
      channel.subscribe((status) => {
        if (status === 'SUBSCRIBED') resolve();
        if (status === 'CHANNEL_ERROR' || status === 'TIMED_OUT') reject(new Error(status));
      });
    });
    await sleep(500);

    const body = `Hola desde Alba ${Date.now()}`;
    const sent = await a.client.from('messages').insert({ community_id: community.id, channel: 'chat', body }).select('id, author_id, created_at').single();
    expect(sent.error).toBeNull();
    expect(sent.data!.author_id).toBe(a.user.id);

    // Persistente: B lo lee por consulta, con autor y fecha.
    const list = await b.client.from('messages').select('id, body, author_id, created_at').eq('community_id', community.id).eq('channel', 'chat').order('id', { ascending: false }).limit(5);
    expect(list.error).toBeNull();
    expect(list.data!.some((m) => m.body === body && m.author_id === a.user.id && m.created_at)).toBe(true);

    // Y en tiempo real.
    for (let i = 0; i < 50 && !received.some((m) => m.body === body); i++) await sleep(200);
    expect(received.some((m) => m.body === body)).toBe(true);
    await b.client.removeChannel(channel);

    // Indicador de no leídos para B, y se limpia al marcar como leído.
    const before = await b.client.rpc('my_communities');
    const row = before.data!.find((r: { community_id: string }) => r.community_id === community.id);
    expect(Number(row.unread_chat)).toBeGreaterThanOrEqual(1);
    await b.client.rpc('mark_read', { p_community: community.id, p_channel: 'chat', p_last_id: sent.data!.id });
    const after = await b.client.rpc('my_communities');
    expect(Number(after.data!.find((r: { community_id: string }) => r.community_id === community.id).unread_chat)).toBe(0);
  });

  it('un usuario ajeno no puede leer ni escribir en el chat restringido', async () => {
    const outsider = await freshUser('Ajena');
    const read = await outsider.client.from('messages').select('id').eq('community_id', community.id);
    expect(read.error).toBeNull();
    expect(read.data).toHaveLength(0);
    const write = await outsider.client.from('messages').insert({ community_id: community.id, channel: 'chat', body: 'intrusión' });
    expect(write.error).not.toBeNull();
    // Sin sesión, tampoco.
    const anonRead = await anon().from('messages').select('id').eq('community_id', community.id);
    expect(anonRead.data ?? []).toHaveLength(0);
  });

  it('solo la administración publica anuncios', async () => {
    const member = await freshUser('Miembro');
    await member.client.rpc('join_community', { p_community: community.id });
    const fail = await member.client.from('messages').insert({ community_id: community.id, channel: 'announcements', body: 'falso anuncio' });
    expect(fail.error).not.toBeNull();
    const admin = await demoUser('casagroove');
    const ok = await admin.client.from('messages').insert({ community_id: community.id, channel: 'announcements', body: `Anuncio ${Date.now()}` });
    expect(ok.error).toBeNull();
  });

  it('una persona expulsada deja de acceder al chat y no puede volver a unirse', async () => {
    const admin = await demoUser('casagroove');
    const victim = await freshUser('Expulsada');
    await victim.client.rpc('join_community', { p_community: community.id });
    const visible = await victim.client.from('messages').select('id').eq('community_id', community.id).limit(1);
    expect(visible.data!.length).toBeGreaterThan(0);

    const kick = await admin.client.rpc('kick_member', { p_community: community.id, p_user: victim.user.id, p_reason: 'spam' });
    expect(kick.error).toBeNull();

    const read = await victim.client.from('messages').select('id').eq('community_id', community.id);
    expect(read.data).toHaveLength(0);
    const write = await victim.client.from('messages').insert({ community_id: community.id, channel: 'chat', body: 'sigo aquí' });
    expect(write.error).not.toBeNull();
    const rejoin = await victim.client.rpc('join_community', { p_community: community.id });
    expect(rejoin.error?.message).toMatch(/expulsado/);

    // Un miembro normal no puede expulsar.
    const other = await freshUser('Otro');
    await other.client.rpc('join_community', { p_community: community.id });
    const notAllowed = await other.client.rpc('kick_member', { p_community: community.id, p_user: victim.user.id });
    expect(notAllowed.error).not.toBeNull();
  });

  it('moderación: la administración retira mensajes; un miembro no puede retirar los de otros', async () => {
    const admin = await demoUser('casagroove');
    const a = await freshUser('Autor');
    const b = await freshUser('Vecino');
    await a.client.rpc('join_community', { p_community: community.id });
    await b.client.rpc('join_community', { p_community: community.id });
    const msg = await a.client.from('messages').insert({ community_id: community.id, channel: 'chat', body: 'mensaje a moderar' }).select('id').single();
    const denied = await b.client.rpc('delete_message', { p_message: msg.data!.id });
    expect(denied.error).not.toBeNull();
    const ok = await admin.client.rpc('delete_message', { p_message: msg.data!.id });
    expect(ok.error).toBeNull();
    const after = await b.client.from('messages').select('body, deleted_at').eq('id', msg.data!.id).single();
    expect(after.data!.body).toBe('');
    expect(after.data!.deleted_at).not.toBeNull();
  });

  it('protección básica frente a spam: ráfagas y duplicados', async () => {
    const s = await freshUser('Rápida');
    await s.client.rpc('join_community', { p_community: community.id });
    const first = await s.client.from('messages').insert({ community_id: community.id, channel: 'chat', body: 'repetido' });
    expect(first.error).toBeNull();
    const dup = await s.client.from('messages').insert({ community_id: community.id, channel: 'chat', body: 'Repetido' });
    expect(dup.error?.message).toMatch(/ya está enviado/);
    let blocked = false;
    for (let i = 0; i < 8; i++) {
      const r = await s.client.from('messages').insert({ community_id: community.id, channel: 'chat', body: `ráfaga ${i}` });
      if (r.error) { blocked = /demasiado rápido/.test(r.error.message); break; }
    }
    expect(blocked).toBe(true);
  });

  it('seguir un perfil no da acceso a su comunidad', async () => {
    const u = await freshUser('Seguidora');
    await u.client.from('follows').insert({ user_id: u.user.id, entity_id: community.entity_id });
    const read = await u.client.from('messages').select('id').eq('community_id', community.id);
    expect(read.data).toHaveLength(0);
  });

  it('salir de la comunidad corta el acceso', async () => {
    const u = await freshUser('Se va');
    await u.client.rpc('join_community', { p_community: community.id });
    await u.client.rpc('leave_community', { p_community: community.id });
    const read = await u.client.from('messages').select('id').eq('community_id', community.id);
    expect(read.data).toHaveLength(0);
  });

  it('el club de pago es un espacio separado: ser miembro gratuito no da acceso', async () => {
    const u = await freshUser('Gratis');
    await u.client.rpc('join_community', { p_community: community.id });
    const club = await u.client.from('messages').insert({ community_id: community.id, channel: 'club', body: 'hola club' });
    expect(club.error).not.toBeNull();
    const membership = await u.client.from('club_memberships').select('*');
    expect(membership.data).toHaveLength(0);
  });
});
