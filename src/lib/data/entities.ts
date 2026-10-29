import type { DB, EntityKind, EntityRow } from '@/lib/types';
import { friendlyError } from './errors';

export async function fetchEntityBySlug(db: DB, slug: string): Promise<EntityRow | null> {
  const { data, error } = await db.from('entities').select('*').eq('slug', slug).maybeSingle();
  if (error) throw new Error(friendlyError(error, 'No se pudo cargar el perfil'));
  return data;
}

export async function fetchEntityById(db: DB, id: string): Promise<EntityRow | null> {
  const { data, error } = await db.from('entities').select('*').eq('id', id).maybeSingle();
  if (error) throw new Error(friendlyError(error, 'No se pudo cargar el perfil'));
  return data;
}

export async function fetchFollowerCount(db: DB, entityId: string): Promise<number> {
  const { data, error } = await db.rpc('follower_count', { p_entity: entityId });
  if (error) return 0;
  return Number(data ?? 0);
}

export async function isEntityAdmin(db: DB, entityId: string): Promise<boolean> {
  const { data } = await db.rpc('is_entity_admin', { p_entity: entityId });
  return Boolean(data);
}

export type EntityPatch = Partial<
  Pick<
    EntityRow,
    | 'name' | 'tagline' | 'bio' | 'genres' | 'area' | 'municipality' | 'province' | 'address' | 'lat' | 'lng'
    | 'photo_path' | 'cover_path' | 'color' | 'accent' | 'profile_font' | 'profile_layout' | 'links' | 'contact_email' | 'contact_phone'
  >
>;

export async function updateEntity(db: DB, id: string, patch: EntityPatch) {
  const { data, error } = await db.from('entities').update(patch).eq('id', id).select('id');
  if (error) throw new Error(friendlyError(error, 'No se pudo guardar el perfil'));
  if (!data?.length) throw new Error('No tienes permisos para editar este perfil.');
}

export async function createOrganization(
  db: DB,
  input: { kind: Extract<EntityKind, 'venue' | 'collective'>; name: string; bio?: string; municipality?: string; address?: string; lat?: number | null; lng?: number | null; genres?: string[] },
) {
  const { data, error } = await db.rpc('create_organization', {
    p_kind: input.kind,
    p_name: input.name,
    p_bio: input.bio,
    p_municipality: input.municipality,
    p_address: input.address,
    p_lat: input.lat ?? undefined,
    p_lng: input.lng ?? undefined,
    p_genres: input.genres,
  });
  if (error) throw new Error(friendlyError(error, 'No se pudo crear el perfil'));
  return data as string;
}

export async function fetchTeam(db: DB, entityId: string) {
  const { data, error } = await db.rpc('entity_team', { p_entity: entityId });
  if (error) throw new Error(friendlyError(error));
  return data ?? [];
}

export async function addAdmin(db: DB, entityId: string, email: string) {
  const { error } = await db.rpc('add_entity_admin', { p_entity: entityId, p_email: email });
  if (error) throw new Error(friendlyError(error));
}

export async function removeAdmin(db: DB, entityId: string, userId: string) {
  const { error } = await db.rpc('remove_entity_admin', { p_entity: entityId, p_user: userId });
  if (error) throw new Error(friendlyError(error));
}

export async function fetchDashboard(db: DB, entityId: string) {
  const { data, error } = await db.rpc('entity_dashboard', { p_entity: entityId });
  if (error) throw new Error(friendlyError(error));
  return data as Record<string, number | string | null>;
}
