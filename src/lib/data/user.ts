import type { DB } from '@/lib/types';
import { friendlyError } from './errors';

export type MyProfile = {
  id: string;
  display_name: string;
  bio: string | null;
  avatar_path: string | null;
  favorite_colors: Record<string, string>;
  is_demo: boolean;
  email: string;
};

export async function fetchMyProfile(db: DB): Promise<MyProfile | null> {
  const { data, error } = await db.rpc('my_profile');
  if (error) throw new Error(friendlyError(error));
  const row = data?.[0];
  return row ? ({ ...row, favorite_colors: (row.favorite_colors ?? {}) as Record<string, string> } as MyProfile) : null;
}

export async function updateMyProfile(db: DB, userId: string, patch: Partial<Pick<MyProfile, 'display_name' | 'bio' | 'avatar_path' | 'favorite_colors'>>) {
  const { error } = await db.from('profiles').update(patch).eq('id', userId);
  if (error) throw new Error(friendlyError(error, 'No se pudo guardar tu perfil'));
}

export async function fetchMyFavorites(db: DB): Promise<string[]> {
  const { data, error } = await db.from('favorites').select('event_id');
  if (error) throw new Error(friendlyError(error));
  return (data ?? []).map((r) => r.event_id);
}

export async function fetchMyFollows(db: DB): Promise<string[]> {
  const { data, error } = await db.from('follows').select('entity_id');
  if (error) throw new Error(friendlyError(error));
  return (data ?? []).map((r) => r.entity_id);
}

export async function setFavorite(db: DB, userId: string, eventId: string, on: boolean) {
  const { error } = on
    ? await db.from('favorites').upsert({ user_id: userId, event_id: eventId }, { onConflict: 'user_id,event_id', ignoreDuplicates: true })
    : await db.from('favorites').delete().eq('user_id', userId).eq('event_id', eventId);
  if (error) throw new Error(friendlyError(error, 'No se pudo actualizar favoritos'));
}

export async function setFollow(db: DB, userId: string, entityId: string, on: boolean) {
  const { error } = on
    ? await db.from('follows').upsert({ user_id: userId, entity_id: entityId }, { onConflict: 'user_id,entity_id', ignoreDuplicates: true })
    : await db.from('follows').delete().eq('user_id', userId).eq('entity_id', entityId);
  if (error) throw new Error(friendlyError(error, 'No se pudo actualizar a quién sigues'));
}

export async function fetchMyEntities(db: DB) {
  const { data, error } = await db.rpc('my_entities');
  if (error) throw new Error(friendlyError(error));
  return data ?? [];
}

export async function activateDj(db: DB, artistName?: string) {
  const { data, error } = await db.rpc('activate_dj_profile', { p_artist_name: artistName ?? undefined });
  if (error) throw new Error(friendlyError(error, 'No se pudo activar el perfil de DJ'));
  return data as string;
}

/** Exporta los datos propios (portabilidad, como en el piloto). */
export async function exportMyData(db: DB) {
  const [profile, favorites, follows, communities, entities, links, rewards] = await Promise.all([
    db.rpc('my_profile'),
    db.from('favorites').select('event_id, created_at'),
    db.from('follows').select('entity_id, created_at'),
    db.rpc('my_communities'),
    db.rpc('my_entities'),
    db.from('referral_links').select('campaign_id, code, created_at'),
    db.from('rewards').select('campaign_id, kind, sequence, status, code, granted_at, redeemed_at, is_simulated'),
  ]);
  return {
    exported_at: new Date().toISOString(),
    profile: profile.data?.[0] ?? null,
    favorites: favorites.data ?? [],
    follows: follows.data ?? [],
    communities: communities.data ?? [],
    managed_profiles: entities.data ?? [],
    referral_links: links.data ?? [],
    rewards: rewards.data ?? [],
  };
}
