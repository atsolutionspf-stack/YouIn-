import type { DB, MessageChannel, MessageRow } from '@/lib/types';
import { friendlyError } from './errors';

export const MESSAGE_PAGE_SIZE = 30;

export async function fetchCommunities(db: DB) {
  const { data, error } = await db
    .from('communities')
    .select('id, slug, name, description, genres, free_benefits, is_demo, entity_id, entities(id, kind, name, slug, initials, color, photo_path, image_url, data_origin)')
    .order('name');
  if (error) throw new Error(friendlyError(error, 'No se pudieron cargar las comunidades'));
  return data ?? [];
}

export async function fetchCommunityBySlug(db: DB, slug: string) {
  const { data, error } = await db
    .from('communities')
    .select('*, entities(*), clubs(*)')
    .eq('slug', slug)
    .maybeSingle();
  if (error) throw new Error(friendlyError(error, 'No se pudo cargar la comunidad'));
  return data;
}

export async function fetchCommunityByEntity(db: DB, entityId: string) {
  const { data } = await db.from('communities').select('id, slug, name').eq('entity_id', entityId).maybeSingle();
  return data;
}

export async function fetchMemberCount(db: DB, communityId: string) {
  const { data } = await db.rpc('community_member_count', { p_community: communityId });
  return Number(data ?? 0);
}

/** Estado de acceso de la persona: miembro, admin o vetada. */
export async function fetchMembership(db: DB, communityId: string, userId: string | null) {
  if (!userId) return { member: false, admin: false, banned: false };
  const [member, admin, ban] = await Promise.all([
    db.from('community_members').select('user_id').eq('community_id', communityId).eq('user_id', userId).maybeSingle(),
    db.rpc('is_community_admin', { p_community: communityId }),
    db.from('community_bans').select('reason').eq('community_id', communityId).eq('user_id', userId).maybeSingle(),
  ]);
  return { member: Boolean(member.data), admin: Boolean(admin.data), banned: Boolean(ban.data) };
}

export async function joinCommunity(db: DB, communityId: string) {
  const { error } = await db.rpc('join_community', { p_community: communityId });
  if (error) throw new Error(friendlyError(error, 'No se pudo entrar en la comunidad'));
}

export async function leaveCommunity(db: DB, communityId: string) {
  const { error } = await db.rpc('leave_community', { p_community: communityId });
  if (error) throw new Error(friendlyError(error, 'No se pudo salir de la comunidad'));
}

export async function fetchMyCommunities(db: DB) {
  const { data, error } = await db.rpc('my_communities');
  if (error) throw new Error(friendlyError(error));
  return data ?? [];
}

/** Página de mensajes, del más reciente hacia atrás. */
export async function fetchMessages(db: DB, communityId: string, channel: MessageChannel, beforeId?: number) {
  let q = db
    .from('messages')
    .select('id, community_id, channel, author_id, body, created_at, deleted_at, client_id')
    .eq('community_id', communityId)
    .eq('channel', channel)
    .order('id', { ascending: false })
    .limit(MESSAGE_PAGE_SIZE);
  if (beforeId) q = q.lt('id', beforeId);
  const { data, error } = await q;
  if (error) throw new Error(friendlyError(error, 'No se pudieron cargar los mensajes'));
  const rows = (data ?? []) as MessageRow[];
  return { messages: rows.reverse(), hasMore: rows.length === MESSAGE_PAGE_SIZE };
}

export async function sendMessage(db: DB, communityId: string, channel: MessageChannel, body: string, clientId: string) {
  const { data, error } = await db
    .from('messages')
    .insert({ community_id: communityId, channel, body, client_id: clientId })
    .select('id, community_id, channel, author_id, body, created_at, deleted_at, client_id')
    .single();
  if (error) throw new Error(friendlyError(error, 'No se pudo enviar el mensaje'));
  return data as MessageRow;
}

export async function deleteMessage(db: DB, messageId: number) {
  const { error } = await db.rpc('delete_message', { p_message: messageId });
  if (error) throw new Error(friendlyError(error, 'No se pudo retirar el mensaje'));
}

export async function markRead(db: DB, communityId: string, channel: MessageChannel, lastId: number) {
  await db.rpc('mark_read', { p_community: communityId, p_channel: channel, p_last_id: lastId });
}

export async function fetchAuthorNames(db: DB, ids: string[]) {
  if (!ids.length) return {} as Record<string, string>;
  const { data } = await db.from('profiles').select('id, display_name').in('id', ids);
  return Object.fromEntries((data ?? []).map((p) => [p.id, p.display_name])) as Record<string, string>;
}

export async function fetchMembersAdmin(db: DB, communityId: string) {
  const { data, error } = await db.rpc('community_members_admin', { p_community: communityId });
  if (error) throw new Error(friendlyError(error));
  return data ?? [];
}

export async function kickMember(db: DB, communityId: string, userId: string, reason: string) {
  const { error } = await db.rpc('kick_member', { p_community: communityId, p_user: userId, p_reason: reason || undefined });
  if (error) throw new Error(friendlyError(error, 'No se pudo expulsar'));
}

export async function unbanMember(db: DB, communityId: string, userId: string) {
  const { error } = await db.rpc('unban_member', { p_community: communityId, p_user: userId });
  if (error) throw new Error(friendlyError(error));
}

export async function createCommunity(db: DB, entityId: string, name: string, description: string, genres: string[], benefits: string[]) {
  const { data, error } = await db.rpc('create_community', {
    p_entity: entityId, p_name: name, p_description: description, p_genres: genres, p_benefits: benefits,
  });
  if (error) throw new Error(friendlyError(error, 'No se pudo crear la comunidad'));
  return data as string;
}

export async function updateCommunity(
  db: DB,
  id: string,
  patch: { name?: string; description?: string | null; genres?: string[]; rules?: string | null; free_benefits?: string[]; welcome_message?: string | null },
) {
  const { data, error } = await db.from('communities').update(patch).eq('id', id).select('id');
  if (error) throw new Error(friendlyError(error, 'No se pudo guardar la comunidad'));
  if (!data?.length) throw new Error('No tienes permisos para editar esta comunidad.');
}

export async function upsertClub(
  db: DB,
  communityId: string,
  existingId: string | null,
  input: { name: string; description: string | null; price_cents: number; billing_interval: 'month' | 'year'; benefits: string[] },
) {
  if (existingId) {
    const { error } = await db.from('clubs').update(input).eq('id', existingId);
    if (error) throw new Error(friendlyError(error, 'No se pudo guardar el club'));
  } else {
    const { error } = await db.from('clubs').insert({ ...input, community_id: communityId, status: 'preview' });
    if (error) throw new Error(friendlyError(error, 'No se pudo crear el club'));
  }
}
