import type { DB, DiscoveryEvent, EntitySummary } from '@/lib/types';
import { friendlyError } from './errors';

export const EVENT_COLUMNS =
  'id,title,description,starts_at,ends_at,until_late,time_warning,venue_entity_id,venue_name,room,address,area,municipality,province,lat,lng,location_precision,genre,source_genres,price,price_kind,price_note,ticket_url,ticket_provider_id,poster_path,poster_url,poster_style,video_path,age,organizer_entity_id,status,data_origin,import_batch_id,sources,verified_at,event_artists(entity_id,position,hidden_by_artist)';

export const ENTITY_SUMMARY_COLUMNS =
  'id,kind,slug,name,initials,color,photo_path,image_url,genres,area,municipality,data_origin,tagline';

/** Eventos publicados que aún no han terminado (incluye los importados y los demo). */
export async function fetchUpcomingEvents(db: DB): Promise<DiscoveryEvent[]> {
  const { data, error } = await db
    .from('events')
    .select(EVENT_COLUMNS)
    .eq('status', 'published')
    .gt('ends_at', new Date().toISOString())
    .order('starts_at')
    .limit(2000);
  if (error) throw new Error(friendlyError(error, 'No se pudieron cargar los eventos'));
  return (data ?? []) as unknown as DiscoveryEvent[];
}

export async function fetchEvent(db: DB, id: string): Promise<DiscoveryEvent | null> {
  const { data, error } = await db.from('events').select(EVENT_COLUMNS).eq('id', id).maybeSingle();
  if (error) throw new Error(friendlyError(error, 'No se pudo cargar el evento'));
  return data as unknown as DiscoveryEvent | null;
}

/** Eventos de una entidad: organizados, en su sala o con mención (respetando lo que el DJ oculta). */
export async function fetchEntityEvents(db: DB, entityId: string, opts: { includePast?: boolean; includeHidden?: boolean } = {}) {
  const now = new Date().toISOString();
  const base = () => {
    let q = db.from('events').select(EVENT_COLUMNS).neq('status', 'draft');
    if (!opts.includePast) q = q.gt('ends_at', now);
    return q;
  };
  const [own, venue, mentions] = await Promise.all([
    base().eq('organizer_entity_id', entityId),
    base().eq('venue_entity_id', entityId),
    db.from('event_artists').select('event_id, hidden_by_artist').eq('entity_id', entityId),
  ]);
  const error = own.error || venue.error || mentions.error;
  if (error) throw new Error(friendlyError(error, 'No se pudieron cargar los eventos'));
  const visibleMentionIds = (mentions.data ?? []).filter((m) => opts.includeHidden || !m.hidden_by_artist).map((m) => m.event_id);
  let mentioned: DiscoveryEvent[] = [];
  if (visibleMentionIds.length) {
    const { data, error: e2 } = await base().in('id', visibleMentionIds);
    if (e2) throw new Error(friendlyError(e2));
    mentioned = (data ?? []) as unknown as DiscoveryEvent[];
  }
  const map = new Map<string, DiscoveryEvent>();
  for (const e of [...((own.data ?? []) as unknown as DiscoveryEvent[]), ...((venue.data ?? []) as unknown as DiscoveryEvent[]), ...mentioned]) {
    map.set(e.id, e);
  }
  return [...map.values()].sort((a, b) => +new Date(a.starts_at) - +new Date(b.starts_at));
}

export async function fetchEntitySummaries(db: DB): Promise<EntitySummary[]> {
  const { data, error } = await db.from('entities').select(ENTITY_SUMMARY_COLUMNS).order('name').limit(5000);
  if (error) throw new Error(friendlyError(error, 'No se pudieron cargar los perfiles'));
  return (data ?? []) as EntitySummary[];
}

export async function fetchImportBatches(db: DB) {
  const { data, error } = await db.from('import_batches').select('*').order('retrieved_at', { ascending: false });
  if (error) throw new Error(friendlyError(error));
  return data ?? [];
}

export type EventInput = {
  title: string;
  description: string | null;
  starts_at: string;
  ends_at: string;
  venue_entity_id: string | null;
  venue_name: string;
  address: string;
  area: string | null;
  municipality: string;
  province: string;
  lat: number;
  lng: number;
  genre: string;
  price: number | null;
  price_kind: 'fixed' | 'from' | 'conditional-free' | 'unknown';
  price_note: string | null;
  ticket_url: string | null;
  poster_path: string | null;
  poster_style: string;
  video_path: string | null;
  age: string | null;
  status: 'draft' | 'published' | 'cancelled';
};

export async function createEvent(db: DB, organizerId: string, userId: string, input: EventInput, djIds: string[]) {
  const { data, error } = await db
    .from('events')
    .insert({ ...input, organizer_entity_id: organizerId, created_by: userId, data_origin: 'user', location_precision: 'organizer-pin' })
    .select('id')
    .single();
  if (error) throw new Error(friendlyError(error, 'No se pudo publicar el evento'));
  await setEventArtists(db, data.id, djIds, []);
  return data.id;
}

export async function updateEvent(db: DB, id: string, input: EventInput, djIds: string[], previousDjIds: string[]) {
  const { data, error } = await db.from('events').update(input).eq('id', id).select('id');
  if (error) throw new Error(friendlyError(error, 'No se pudo guardar el evento'));
  if (!data?.length) throw new Error('No tienes permisos para editar este evento.');
  await setEventArtists(db, id, djIds, previousDjIds);
}

async function setEventArtists(db: DB, eventId: string, next: string[], previous: string[]) {
  const toAdd = next.filter((id) => !previous.includes(id));
  const toRemove = previous.filter((id) => !next.includes(id));
  if (toRemove.length) {
    const { error } = await db.from('event_artists').delete().eq('event_id', eventId).in('entity_id', toRemove);
    if (error) throw new Error(friendlyError(error, 'No se pudieron retirar menciones'));
  }
  if (toAdd.length) {
    const { error } = await db
      .from('event_artists')
      .insert(toAdd.map((entity_id) => ({ event_id: eventId, entity_id, position: next.indexOf(entity_id) })));
    if (error) throw new Error(friendlyError(error, 'No se pudieron añadir menciones'));
  }
}

export async function deleteEvent(db: DB, id: string) {
  const { error } = await db.from('events').delete().eq('id', id);
  if (error) throw new Error(friendlyError(error, 'No se pudo borrar el evento'));
}

/** El DJ decide si una mención se ve en su perfil. No toca el evento original. */
export async function setMentionHidden(db: DB, eventId: string, djEntityId: string, hidden: boolean) {
  const { data, error } = await db
    .from('event_artists')
    .update({ hidden_by_artist: hidden })
    .eq('event_id', eventId)
    .eq('entity_id', djEntityId)
    .select('event_id');
  if (error) throw new Error(friendlyError(error));
  if (!data?.length) throw new Error('No tienes permisos para cambiar esta mención.');
}
