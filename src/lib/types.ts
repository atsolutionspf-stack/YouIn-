import type { SupabaseClient } from '@supabase/supabase-js';
import type { Database } from '@/lib/database.types';

export type DB = SupabaseClient<Database>;
type Tables = Database['public']['Tables'];
export type EntityKind = Database['public']['Enums']['entity_kind'];
export type DataOrigin = Database['public']['Enums']['data_origin'];
export type MessageChannel = Database['public']['Enums']['message_channel'];

export type EventRow = Tables['events']['Row'];
export type EntityRow = Tables['entities']['Row'];
export type CommunityRow = Tables['communities']['Row'];
export type ClubRow = Tables['clubs']['Row'];
export type CampaignRow = Tables['referral_campaigns']['Row'];
export type CampaignRuleRow = Tables['campaign_rules']['Row'];
export type RewardRow = Tables['rewards']['Row'];
export type RewardEventRow = Tables['reward_events']['Row'];
export type TicketOrderRow = Tables['ticket_orders']['Row'];
export type TicketItemRow = Tables['ticket_items']['Row'];
export type ImportBatchRow = Tables['import_batches']['Row'];

export type EventArtist = { entity_id: string; position: number; hidden_by_artist: boolean };
export type DiscoveryEvent = Omit<EventRow, 'created_by' | 'created_at' | 'updated_at' | 'source_event_key'> & {
  event_artists: EventArtist[];
};

/** Datos ligeros de una entidad para tarjetas, búsqueda y nombres. */
export type EntitySummary = Pick<
  EntityRow,
  'id' | 'kind' | 'slug' | 'name' | 'initials' | 'color' | 'photo_path' | 'image_url' | 'genres' | 'area' | 'municipality' | 'data_origin' | 'tagline'
>;

export type SourceLink = { label: string; url: string };

export type MessageRow = {
  id: number;
  community_id: string;
  channel: MessageChannel;
  author_id: string;
  body: string;
  created_at: string;
  deleted_at: string | null;
  client_id?: string | null;
};

export type MyCommunity = Database['public']['Functions']['my_communities']['Returns'][number];
export type MyEntity = Database['public']['Functions']['my_entities']['Returns'][number];

export type Result<T> = { data: T; error: null } | { data: null; error: string };
