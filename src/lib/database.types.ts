
export type Json = string | number | boolean | null | { [key: string]: Json | undefined } | Json[]

export type Database = {
  
  "graphql_public": {
          Tables: {
            [_ in never]: never
          }
          Views: {
            [_ in never]: never
          }
          Functions: {
            "graphql":
{ Args: { "extensions"?: Json,"operationName"?: string,"query"?: string,"variables"?: Json }; Returns: Json
                           }
          }
          Enums: {
            [_ in never]: never
          }
          CompositeTypes: {
            [_ in never]: never
          }
        },"public": {
          Tables: {
            "campaign_rules": {
                  Row: {
                    "base_threshold": number,"campaign_id": string,"conditions": string | null,"created_at": string,"created_by": string | null,"id": string,"max_extra": number | null,"step_size": number,"version": number
                  }
                  ComputedFields: never
                  Insert: {
                    "base_threshold": number,"campaign_id": string,"conditions"?: string | null,"created_at"?: string,"created_by"?: string | null,"id"?: string,"max_extra"?: number | null,"step_size": number,"version": number
                  }
                  Update: {
                    "base_threshold"?: number,"campaign_id"?: string,"conditions"?: string | null,"created_at"?: string,"created_by"?: string | null,"id"?: string,"max_extra"?: number | null,"step_size"?: number,"version"?: number
                  }
                  Relationships: [
                    {
      foreignKeyName: "campaign_rules_campaign_id_fkey"
      columns: ["campaign_id"]
isOneToOne: false
      referencedRelation: "referral_campaigns"
      referencedColumns: ["id"]
    }
                  ]
                },"club_memberships": {
                  Row: {
                    "club_id": string,"created_at": string,"current_period_end": string,"provider": string,"provider_subscription_id": string,"status": string,"user_id": string
                  }
                  ComputedFields: never
                  Insert: {
                    "club_id": string,"created_at"?: string,"current_period_end": string,"provider": string,"provider_subscription_id": string,"status": string,"user_id": string
                  }
                  Update: {
                    "club_id"?: string,"created_at"?: string,"current_period_end"?: string,"provider"?: string,"provider_subscription_id"?: string,"status"?: string,"user_id"?: string
                  }
                  Relationships: [
                    {
      foreignKeyName: "club_memberships_club_id_fkey"
      columns: ["club_id"]
isOneToOne: false
      referencedRelation: "clubs"
      referencedColumns: ["id"]
    }
                  ]
                },"clubs": {
                  Row: {
                    "benefits": (string)[],"billing_interval": string,"community_id": string,"created_at": string,"currency": string,"description": string | null,"id": string,"name": string,"platform_fee_bps": number,"price_cents": number,"status": string,"updated_at": string
                  }
                  ComputedFields: never
                  Insert: {
                    "benefits"?: (string)[],"billing_interval"?: string,"community_id": string,"created_at"?: string,"currency"?: string,"description"?: string | null,"id"?: string,"name": string,"platform_fee_bps"?: number,"price_cents"?: number,"status"?: string,"updated_at"?: string
                  }
                  Update: {
                    "benefits"?: (string)[],"billing_interval"?: string,"community_id"?: string,"created_at"?: string,"currency"?: string,"description"?: string | null,"id"?: string,"name"?: string,"platform_fee_bps"?: number,"price_cents"?: number,"status"?: string,"updated_at"?: string
                  }
                  Relationships: [
                    {
      foreignKeyName: "clubs_community_id_fkey"
      columns: ["community_id"]
isOneToOne: true
      referencedRelation: "communities"
      referencedColumns: ["id"]
    }
                  ]
                },"communities": {
                  Row: {
                    "created_at": string,"description": string | null,"entity_id": string,"free_benefits": (string)[],"genres": (string)[],"id": string,"is_demo": boolean,"name": string,"rules": string | null,"slug": string,"updated_at": string,"welcome_message": string | null
                  }
                  ComputedFields: never
                  Insert: {
                    "created_at"?: string,"description"?: string | null,"entity_id": string,"free_benefits"?: (string)[],"genres"?: (string)[],"id"?: string,"is_demo"?: boolean,"name": string,"rules"?: string | null,"slug": string,"updated_at"?: string,"welcome_message"?: string | null
                  }
                  Update: {
                    "created_at"?: string,"description"?: string | null,"entity_id"?: string,"free_benefits"?: (string)[],"genres"?: (string)[],"id"?: string,"is_demo"?: boolean,"name"?: string,"rules"?: string | null,"slug"?: string,"updated_at"?: string,"welcome_message"?: string | null
                  }
                  Relationships: [
                    {
      foreignKeyName: "communities_entity_id_fkey"
      columns: ["entity_id"]
isOneToOne: true
      referencedRelation: "entities"
      referencedColumns: ["id"]
    }
                  ]
                },"community_bans": {
                  Row: {
                    "banned_by": string | null,"community_id": string,"created_at": string,"reason": string | null,"user_id": string
                  }
                  ComputedFields: never
                  Insert: {
                    "banned_by"?: string | null,"community_id": string,"created_at"?: string,"reason"?: string | null,"user_id": string
                  }
                  Update: {
                    "banned_by"?: string | null,"community_id"?: string,"created_at"?: string,"reason"?: string | null,"user_id"?: string
                  }
                  Relationships: [
                    {
      foreignKeyName: "community_bans_community_id_fkey"
      columns: ["community_id"]
isOneToOne: false
      referencedRelation: "communities"
      referencedColumns: ["id"]
    }
                  ]
                },"community_members": {
                  Row: {
                    "community_id": string,"joined_at": string,"user_id": string
                  }
                  ComputedFields: never
                  Insert: {
                    "community_id": string,"joined_at"?: string,"user_id": string
                  }
                  Update: {
                    "community_id"?: string,"joined_at"?: string,"user_id"?: string
                  }
                  Relationships: [
                    {
      foreignKeyName: "community_members_community_id_fkey"
      columns: ["community_id"]
isOneToOne: false
      referencedRelation: "communities"
      referencedColumns: ["id"]
    }
                  ]
                },"community_reads": {
                  Row: {
                    "channel": Database["public"]['Enums']["message_channel"],"community_id": string,"last_read_id": number,"updated_at": string,"user_id": string
                  }
                  ComputedFields: never
                  Insert: {
                    "channel": Database["public"]['Enums']["message_channel"],"community_id": string,"last_read_id"?: number,"updated_at"?: string,"user_id": string
                  }
                  Update: {
                    "channel"?: Database["public"]['Enums']["message_channel"],"community_id"?: string,"last_read_id"?: number,"updated_at"?: string,"user_id"?: string
                  }
                  Relationships: [
                    {
      foreignKeyName: "community_reads_community_id_fkey"
      columns: ["community_id"]
isOneToOne: false
      referencedRelation: "communities"
      referencedColumns: ["id"]
    }
                  ]
                },"entities": {
                  Row: {
                    "accent": string,"address": string | null,"area": string | null,"bio": string | null,"color": string,"contact_email": string | null,"contact_phone": string | null,"cover_path": string | null,"created_at": string,"created_by": string | null,"data_origin": Database["public"]['Enums']["data_origin"],"genres": (string)[],"id": string,"image_url": string | null,"initials": string | null,"kind": Database["public"]['Enums']["entity_kind"],"lat": number | null,"links": NonNullable<Json>,"lng": number | null,"municipality": string | null,"name": string,"photo_path": string | null,"profile_font": string,"profile_layout": string,"province": string | null,"slug": string,"source_key": string | null,"source_url": string | null,"tagline": string | null,"updated_at": string,"user_id": string | null
                  }
                  ComputedFields: never
                  Insert: {
                    "accent"?: string,"address"?: string | null,"area"?: string | null,"bio"?: string | null,"color"?: string,"contact_email"?: string | null,"contact_phone"?: string | null,"cover_path"?: string | null,"created_at"?: string,"created_by"?: string | null,"data_origin"?: Database["public"]['Enums']["data_origin"],"genres"?: (string)[],"id"?: string,"image_url"?: string | null,"initials"?: string | null,"kind": Database["public"]['Enums']["entity_kind"],"lat"?: number | null,"links"?: NonNullable<Json>,"lng"?: number | null,"municipality"?: string | null,"name": string,"photo_path"?: string | null,"profile_font"?: string,"profile_layout"?: string,"province"?: string | null,"slug": string,"source_key"?: string | null,"source_url"?: string | null,"tagline"?: string | null,"updated_at"?: string,"user_id"?: string | null
                  }
                  Update: {
                    "accent"?: string,"address"?: string | null,"area"?: string | null,"bio"?: string | null,"color"?: string,"contact_email"?: string | null,"contact_phone"?: string | null,"cover_path"?: string | null,"created_at"?: string,"created_by"?: string | null,"data_origin"?: Database["public"]['Enums']["data_origin"],"genres"?: (string)[],"id"?: string,"image_url"?: string | null,"initials"?: string | null,"kind"?: Database["public"]['Enums']["entity_kind"],"lat"?: number | null,"links"?: NonNullable<Json>,"lng"?: number | null,"municipality"?: string | null,"name"?: string,"photo_path"?: string | null,"profile_font"?: string,"profile_layout"?: string,"province"?: string | null,"slug"?: string,"source_key"?: string | null,"source_url"?: string | null,"tagline"?: string | null,"updated_at"?: string,"user_id"?: string | null
                  }
                  Relationships: [
                    
                  ]
                },"entity_admins": {
                  Row: {
                    "created_at": string,"entity_id": string,"role": Database["public"]['Enums']["entity_admin_role"],"user_id": string
                  }
                  ComputedFields: never
                  Insert: {
                    "created_at"?: string,"entity_id": string,"role"?: Database["public"]['Enums']["entity_admin_role"],"user_id": string
                  }
                  Update: {
                    "created_at"?: string,"entity_id"?: string,"role"?: Database["public"]['Enums']["entity_admin_role"],"user_id"?: string
                  }
                  Relationships: [
                    {
      foreignKeyName: "entity_admins_entity_id_fkey"
      columns: ["entity_id"]
isOneToOne: false
      referencedRelation: "entities"
      referencedColumns: ["id"]
    }
                  ]
                },"event_artists": {
                  Row: {
                    "created_at": string,"entity_id": string,"event_id": string,"hidden_by_artist": boolean,"position": number
                  }
                  ComputedFields: never
                  Insert: {
                    "created_at"?: string,"entity_id": string,"event_id": string,"hidden_by_artist"?: boolean,"position"?: number
                  }
                  Update: {
                    "created_at"?: string,"entity_id"?: string,"event_id"?: string,"hidden_by_artist"?: boolean,"position"?: number
                  }
                  Relationships: [
                    {
      foreignKeyName: "event_artists_entity_id_fkey"
      columns: ["entity_id"]
isOneToOne: false
      referencedRelation: "entities"
      referencedColumns: ["id"]
    },{
      foreignKeyName: "event_artists_event_id_fkey"
      columns: ["event_id"]
isOneToOne: false
      referencedRelation: "events"
      referencedColumns: ["id"]
    }
                  ]
                },"events": {
                  Row: {
                    "address": string,"age": string | null,"area": string | null,"created_at": string,"created_by": string | null,"data_origin": Database["public"]['Enums']["data_origin"],"description": string | null,"ends_at": string,"genre": string,"id": string,"import_batch_id": string | null,"lat": number | null,"lng": number | null,"location_precision": string,"municipality": string,"organizer_entity_id": string | null,"poster_path": string | null,"poster_style": string,"poster_url": string | null,"price": number | null,"price_kind": Database["public"]['Enums']["price_kind"],"price_note": string | null,"province": string,"room": string | null,"source_event_key": string | null,"source_genres": (string)[],"sources": NonNullable<Json>,"starts_at": string,"status": Database["public"]['Enums']["event_status"],"ticket_provider_id": string | null,"ticket_url": string | null,"time_warning": string | null,"title": string,"until_late": boolean,"updated_at": string,"venue_entity_id": string | null,"venue_name": string,"verified_at": string | null,"video_path": string | null
                  }
                  ComputedFields: never
                  Insert: {
                    "address": string,"age"?: string | null,"area"?: string | null,"created_at"?: string,"created_by"?: string | null,"data_origin"?: Database["public"]['Enums']["data_origin"],"description"?: string | null,"ends_at": string,"genre"?: string,"id"?: string,"import_batch_id"?: string | null,"lat"?: number | null,"lng"?: number | null,"location_precision"?: string,"municipality"?: string,"organizer_entity_id"?: string | null,"poster_path"?: string | null,"poster_style"?: string,"poster_url"?: string | null,"price"?: number | null,"price_kind"?: Database["public"]['Enums']["price_kind"],"price_note"?: string | null,"province"?: string,"room"?: string | null,"source_event_key"?: string | null,"source_genres"?: (string)[],"sources"?: NonNullable<Json>,"starts_at": string,"status"?: Database["public"]['Enums']["event_status"],"ticket_provider_id"?: string | null,"ticket_url"?: string | null,"time_warning"?: string | null,"title": string,"until_late"?: boolean,"updated_at"?: string,"venue_entity_id"?: string | null,"venue_name": string,"verified_at"?: string | null,"video_path"?: string | null
                  }
                  Update: {
                    "address"?: string,"age"?: string | null,"area"?: string | null,"created_at"?: string,"created_by"?: string | null,"data_origin"?: Database["public"]['Enums']["data_origin"],"description"?: string | null,"ends_at"?: string,"genre"?: string,"id"?: string,"import_batch_id"?: string | null,"lat"?: number | null,"lng"?: number | null,"location_precision"?: string,"municipality"?: string,"organizer_entity_id"?: string | null,"poster_path"?: string | null,"poster_style"?: string,"poster_url"?: string | null,"price"?: number | null,"price_kind"?: Database["public"]['Enums']["price_kind"],"price_note"?: string | null,"province"?: string,"room"?: string | null,"source_event_key"?: string | null,"source_genres"?: (string)[],"sources"?: NonNullable<Json>,"starts_at"?: string,"status"?: Database["public"]['Enums']["event_status"],"ticket_provider_id"?: string | null,"ticket_url"?: string | null,"time_warning"?: string | null,"title"?: string,"until_late"?: boolean,"updated_at"?: string,"venue_entity_id"?: string | null,"venue_name"?: string,"verified_at"?: string | null,"video_path"?: string | null
                  }
                  Relationships: [
                    {
      foreignKeyName: "events_import_batch_id_fkey"
      columns: ["import_batch_id"]
isOneToOne: false
      referencedRelation: "import_batches"
      referencedColumns: ["id"]
    },{
      foreignKeyName: "events_organizer_entity_id_fkey"
      columns: ["organizer_entity_id"]
isOneToOne: false
      referencedRelation: "entities"
      referencedColumns: ["id"]
    },{
      foreignKeyName: "events_ticket_provider_id_fkey"
      columns: ["ticket_provider_id"]
isOneToOne: false
      referencedRelation: "ticketing_providers"
      referencedColumns: ["id"]
    },{
      foreignKeyName: "events_venue_entity_id_fkey"
      columns: ["venue_entity_id"]
isOneToOne: false
      referencedRelation: "entities"
      referencedColumns: ["id"]
    }
                  ]
                },"favorites": {
                  Row: {
                    "created_at": string,"event_id": string,"user_id": string
                  }
                  ComputedFields: never
                  Insert: {
                    "created_at"?: string,"event_id": string,"user_id": string
                  }
                  Update: {
                    "created_at"?: string,"event_id"?: string,"user_id"?: string
                  }
                  Relationships: [
                    {
      foreignKeyName: "favorites_event_id_fkey"
      columns: ["event_id"]
isOneToOne: false
      referencedRelation: "events"
      referencedColumns: ["id"]
    }
                  ]
                },"follows": {
                  Row: {
                    "created_at": string,"entity_id": string,"user_id": string
                  }
                  ComputedFields: never
                  Insert: {
                    "created_at"?: string,"entity_id": string,"user_id": string
                  }
                  Update: {
                    "created_at"?: string,"entity_id"?: string,"user_id"?: string
                  }
                  Relationships: [
                    {
      foreignKeyName: "follows_entity_id_fkey"
      columns: ["entity_id"]
isOneToOne: false
      referencedRelation: "entities"
      referencedColumns: ["id"]
    }
                  ]
                },"import_batches": {
                  Row: {
                    "automatic_sync": boolean,"coverage": string,"created_at": string,"id": string,"label": string,"retrieved_at": string,"revision": string,"stats": NonNullable<Json>,"window_info": NonNullable<Json>
                  }
                  ComputedFields: never
                  Insert: {
                    "automatic_sync"?: boolean,"coverage": string,"created_at"?: string,"id"?: string,"label": string,"retrieved_at": string,"revision": string,"stats"?: NonNullable<Json>,"window_info"?: NonNullable<Json>
                  }
                  Update: {
                    "automatic_sync"?: boolean,"coverage"?: string,"created_at"?: string,"id"?: string,"label"?: string,"retrieved_at"?: string,"revision"?: string,"stats"?: NonNullable<Json>,"window_info"?: NonNullable<Json>
                  }
                  Relationships: [
                    
                  ]
                },"messages": {
                  Row: {
                    "author_id": string,"body": string,"channel": Database["public"]['Enums']["message_channel"],"client_id": string | null,"community_id": string,"created_at": string,"deleted_at": string | null,"deleted_by": string | null,"id": number
                  }
                  ComputedFields: never
                  Insert: {
                    "author_id"?: string,"body"?: string,"channel"?: Database["public"]['Enums']["message_channel"],"client_id"?: string | null,"community_id": string,"created_at"?: string,"deleted_at"?: string | null,"deleted_by"?: string | null,"id"?: never
                  }
                  Update: {
                    "author_id"?: string,"body"?: string,"channel"?: Database["public"]['Enums']["message_channel"],"client_id"?: string | null,"community_id"?: string,"created_at"?: string,"deleted_at"?: string | null,"deleted_by"?: string | null,"id"?: never
                  }
                  Relationships: [
                    {
      foreignKeyName: "messages_community_id_fkey"
      columns: ["community_id"]
isOneToOne: false
      referencedRelation: "communities"
      referencedColumns: ["id"]
    }
                  ]
                },"profiles": {
                  Row: {
                    "avatar_path": string | null,"bio": string | null,"created_at": string,"display_name": string,"favorite_colors": NonNullable<Json>,"id": string,"is_demo": boolean,"updated_at": string
                  }
                  ComputedFields: never
                  Insert: {
                    "avatar_path"?: string | null,"bio"?: string | null,"created_at"?: string,"display_name": string,"favorite_colors"?: NonNullable<Json>,"id": string,"is_demo"?: boolean,"updated_at"?: string
                  }
                  Update: {
                    "avatar_path"?: string | null,"bio"?: string | null,"created_at"?: string,"display_name"?: string,"favorite_colors"?: NonNullable<Json>,"id"?: string,"is_demo"?: boolean,"updated_at"?: string
                  }
                  Relationships: [
                    
                  ]
                },"referral_campaigns": {
                  Row: {
                    "community_id": string,"created_at": string,"created_by": string | null,"current_rule_version": number,"description": string | null,"ends_at": string | null,"event_id": string | null,"id": string,"is_demo": boolean,"mode": string,"name": string,"starts_at": string,"status": string
                  }
                  ComputedFields: never
                  Insert: {
                    "community_id": string,"created_at"?: string,"created_by"?: string | null,"current_rule_version"?: number,"description"?: string | null,"ends_at"?: string | null,"event_id"?: string | null,"id"?: string,"is_demo"?: boolean,"mode"?: string,"name": string,"starts_at"?: string,"status"?: string
                  }
                  Update: {
                    "community_id"?: string,"created_at"?: string,"created_by"?: string | null,"current_rule_version"?: number,"description"?: string | null,"ends_at"?: string | null,"event_id"?: string | null,"id"?: string,"is_demo"?: boolean,"mode"?: string,"name"?: string,"starts_at"?: string,"status"?: string
                  }
                  Relationships: [
                    {
      foreignKeyName: "referral_campaigns_community_id_fkey"
      columns: ["community_id"]
isOneToOne: false
      referencedRelation: "communities"
      referencedColumns: ["id"]
    },{
      foreignKeyName: "referral_campaigns_event_id_fkey"
      columns: ["event_id"]
isOneToOne: false
      referencedRelation: "events"
      referencedColumns: ["id"]
    }
                  ]
                },"referral_links": {
                  Row: {
                    "campaign_id": string,"code": string,"created_at": string,"id": string,"user_id": string
                  }
                  ComputedFields: never
                  Insert: {
                    "campaign_id": string,"code": string,"created_at"?: string,"id"?: string,"user_id": string
                  }
                  Update: {
                    "campaign_id"?: string,"code"?: string,"created_at"?: string,"id"?: string,"user_id"?: string
                  }
                  Relationships: [
                    {
      foreignKeyName: "referral_links_campaign_id_fkey"
      columns: ["campaign_id"]
isOneToOne: false
      referencedRelation: "referral_campaigns"
      referencedColumns: ["id"]
    }
                  ]
                },"reward_events": {
                  Row: {
                    "campaign_id": string,"created_at": string,"detail": string | null,"id": number,"is_simulated": boolean,"operation_key": string | null,"referral_link_id": string | null,"reward_id": string | null,"ticket_delta": number,"type": string,"user_id": string | null,"valid_tickets_after": number | null
                  }
                  ComputedFields: never
                  Insert: {
                    "campaign_id": string,"created_at"?: string,"detail"?: string | null,"id"?: never,"is_simulated"?: boolean,"operation_key"?: string | null,"referral_link_id"?: string | null,"reward_id"?: string | null,"ticket_delta"?: number,"type": string,"user_id"?: string | null,"valid_tickets_after"?: number | null
                  }
                  Update: {
                    "campaign_id"?: string,"created_at"?: string,"detail"?: string | null,"id"?: never,"is_simulated"?: boolean,"operation_key"?: string | null,"referral_link_id"?: string | null,"reward_id"?: string | null,"ticket_delta"?: number,"type"?: string,"user_id"?: string | null,"valid_tickets_after"?: number | null
                  }
                  Relationships: [
                    {
      foreignKeyName: "reward_events_campaign_id_fkey"
      columns: ["campaign_id"]
isOneToOne: false
      referencedRelation: "referral_campaigns"
      referencedColumns: ["id"]
    },{
      foreignKeyName: "reward_events_referral_link_id_fkey"
      columns: ["referral_link_id"]
isOneToOne: false
      referencedRelation: "referral_links"
      referencedColumns: ["id"]
    },{
      foreignKeyName: "reward_events_reward_id_fkey"
      columns: ["reward_id"]
isOneToOne: false
      referencedRelation: "rewards"
      referencedColumns: ["id"]
    }
                  ]
                },"rewards": {
                  Row: {
                    "campaign_id": string,"code": string,"granted_at": string,"id": string,"is_simulated": boolean,"kind": string,"redeemed_at": string | null,"redeemed_by": string | null,"referral_link_id": string,"revoke_reason": string | null,"revoked_at": string | null,"rule_version": number,"sequence": number,"status": string,"user_id": string
                  }
                  ComputedFields: never
                  Insert: {
                    "campaign_id": string,"code": string,"granted_at"?: string,"id"?: string,"is_simulated": boolean,"kind": string,"redeemed_at"?: string | null,"redeemed_by"?: string | null,"referral_link_id": string,"revoke_reason"?: string | null,"revoked_at"?: string | null,"rule_version": number,"sequence": number,"status"?: string,"user_id": string
                  }
                  Update: {
                    "campaign_id"?: string,"code"?: string,"granted_at"?: string,"id"?: string,"is_simulated"?: boolean,"kind"?: string,"redeemed_at"?: string | null,"redeemed_by"?: string | null,"referral_link_id"?: string,"revoke_reason"?: string | null,"revoked_at"?: string | null,"rule_version"?: number,"sequence"?: number,"status"?: string,"user_id"?: string
                  }
                  Relationships: [
                    {
      foreignKeyName: "rewards_campaign_id_fkey"
      columns: ["campaign_id"]
isOneToOne: false
      referencedRelation: "referral_campaigns"
      referencedColumns: ["id"]
    },{
      foreignKeyName: "rewards_referral_link_id_fkey"
      columns: ["referral_link_id"]
isOneToOne: false
      referencedRelation: "referral_links"
      referencedColumns: ["id"]
    }
                  ]
                },"ticket_items": {
                  Row: {
                    "external_ticket_id": string,"id": string,"order_id": string,"status": string,"status_changed_at": string
                  }
                  ComputedFields: never
                  Insert: {
                    "external_ticket_id": string,"id"?: string,"order_id": string,"status"?: string,"status_changed_at"?: string
                  }
                  Update: {
                    "external_ticket_id"?: string,"id"?: string,"order_id"?: string,"status"?: string,"status_changed_at"?: string
                  }
                  Relationships: [
                    {
      foreignKeyName: "ticket_items_order_id_fkey"
      columns: ["order_id"]
isOneToOne: false
      referencedRelation: "ticket_orders"
      referencedColumns: ["id"]
    }
                  ]
                },"ticket_operations": {
                  Row: {
                    "campaign_id": string,"created_at": string,"created_by": string | null,"idempotency_key": string,"kind": string,"result": Json | null
                  }
                  ComputedFields: never
                  Insert: {
                    "campaign_id": string,"created_at"?: string,"created_by"?: string | null,"idempotency_key": string,"kind": string,"result"?: Json | null
                  }
                  Update: {
                    "campaign_id"?: string,"created_at"?: string,"created_by"?: string | null,"idempotency_key"?: string,"kind"?: string,"result"?: Json | null
                  }
                  Relationships: [
                    {
      foreignKeyName: "ticket_operations_campaign_id_fkey"
      columns: ["campaign_id"]
isOneToOne: false
      referencedRelation: "referral_campaigns"
      referencedColumns: ["id"]
    }
                  ]
                },"ticket_orders": {
                  Row: {
                    "campaign_id": string,"created_at": string,"external_order_id": string,"id": string,"is_simulated": boolean,"provider": string,"purchased_at": string,"referral_link_id": string
                  }
                  ComputedFields: never
                  Insert: {
                    "campaign_id": string,"created_at"?: string,"external_order_id": string,"id"?: string,"is_simulated": boolean,"provider": string,"purchased_at"?: string,"referral_link_id": string
                  }
                  Update: {
                    "campaign_id"?: string,"created_at"?: string,"external_order_id"?: string,"id"?: string,"is_simulated"?: boolean,"provider"?: string,"purchased_at"?: string,"referral_link_id"?: string
                  }
                  Relationships: [
                    {
      foreignKeyName: "ticket_orders_campaign_id_fkey"
      columns: ["campaign_id"]
isOneToOne: false
      referencedRelation: "referral_campaigns"
      referencedColumns: ["id"]
    },{
      foreignKeyName: "ticket_orders_referral_link_id_fkey"
      columns: ["referral_link_id"]
isOneToOne: false
      referencedRelation: "referral_links"
      referencedColumns: ["id"]
    }
                  ]
                },"ticketing_providers": {
                  Row: {
                    "id": string,"integration_status": string,"name": string,"notes": string | null,"website": string | null
                  }
                  ComputedFields: never
                  Insert: {
                    "id": string,"integration_status"?: string,"name": string,"notes"?: string | null,"website"?: string | null
                  }
                  Update: {
                    "id"?: string,"integration_status"?: string,"name"?: string,"notes"?: string | null,"website"?: string | null
                  }
                  Relationships: [
                    
                  ]
                }
          }
          Views: {
            [_ in never]: never
          }
          Functions: {
            "_apply_rewards":
{ Args: { "p_link": string,"p_operation": string,"p_reason": string,"p_valid_before": number }; Returns: Json
                           },
"activate_dj_profile":
{ Args: { "p_artist_name"?: string }; Returns: string
                           },
"add_entity_admin":
{ Args: { "p_email": string,"p_entity": string }; Returns: undefined
                           },
"campaign_results":
{ Args: { "p_campaign": string }; Returns: {
              "code": string,"display_name": string,"orders": number,"referral_link_id": string,"reversed_tickets": number,"rewards_available": number,"rewards_redeemed": number,"rewards_revoked": number,"valid_tickets": number
            }[]
                           },
"can_manage_event":
{ Args: { "p_event": string }; Returns: boolean
                           },
"community_admin_ids":
{ Args: { "p_community": string }; Returns: string[]
                           },
"community_member_count":
{ Args: { "p_community": string }; Returns: number
                           },
"community_members_admin":
{ Args: { "p_community": string }; Returns: {
              "banned": boolean,"display_name": string,"joined_at": string,"message_count": number,"user_id": string
            }[]
                           },
"create_campaign":
{ Args: { "p_base"?: number,"p_community": string,"p_conditions"?: string,"p_description"?: string,"p_ends_at"?: string,"p_event"?: string,"p_max_extra"?: number,"p_name": string,"p_step"?: number }; Returns: string
                           },
"create_community":
{ Args: { "p_benefits"?: (string)[],"p_description"?: string,"p_entity": string,"p_genres"?: (string)[],"p_name": string }; Returns: string
                           },
"create_organization":
{ Args: { "p_address"?: string,"p_bio"?: string,"p_genres"?: (string)[],"p_kind": Database["public"]['Enums']["entity_kind"],"p_lat"?: number,"p_lng"?: number,"p_municipality"?: string,"p_name": string,"p_province"?: string }; Returns: string
                           },
"delete_message":
{ Args: { "p_message": number }; Returns: undefined
                           },
"entity_dashboard":
{ Args: { "p_entity": string }; Returns: Json
                           },
"entity_team":
{ Args: { "p_entity": string }; Returns: {
              "display_name": string,"email": string,"role": Database["public"]['Enums']["entity_admin_role"],"user_id": string
            }[]
                           },
"follower_count":
{ Args: { "p_entity": string }; Returns: number
                           },
"get_or_create_referral_link":
{ Args: { "p_campaign": string }; Returns: {
              "campaign_id": string,
"code": string,
"created_at": string,
"id": string,
"user_id": string
            }
                          SetofOptions: {
        from: "*"
        to: "referral_links"
        isOneToOne: true
        isSetofReturn: false
      } },
"has_club_access":
{ Args: { "p_community": string }; Returns: boolean
                           },
"is_campaign_admin":
{ Args: { "p_campaign": string }; Returns: boolean
                           },
"is_community_admin":
{ Args: { "p_community": string }; Returns: boolean
                           },
"is_community_member":
{ Args: { "p_community": string }; Returns: boolean
                           },
"is_entity_admin":
{ Args: { "p_entity": string }; Returns: boolean
                           },
"is_entity_owner":
{ Args: { "p_entity": string }; Returns: boolean
                           },
"join_community":
{ Args: { "p_community": string }; Returns: boolean
                           },
"kick_member":
{ Args: { "p_community": string,"p_reason"?: string,"p_user": string }; Returns: undefined
                           },
"leave_community":
{ Args: { "p_community": string }; Returns: undefined
                           },
"link_valid_tickets":
{ Args: { "p_link": string }; Returns: number
                           },
"mark_read":
{ Args: { "p_channel": Database["public"]['Enums']["message_channel"],"p_community": string,"p_last_id": number }; Returns: undefined
                           },
"my_communities":
{ Args: Record<PropertyKey, never>; Returns: {
              "community_id": string,"entity_id": string,"entity_kind": Database["public"]['Enums']["entity_kind"],"entity_name": string,"is_admin": boolean,"is_member": boolean,"last_message_at": string,"name": string,"slug": string,"unread_announcements": number,"unread_chat": number
            }[]
                           },
"my_entities":
{ Args: Record<PropertyKey, never>; Returns: {
              "community_id": string,"id": string,"kind": Database["public"]['Enums']["entity_kind"],"name": string,"role": Database["public"]['Enums']["entity_admin_role"],"slug": string
            }[]
                           },
"my_profile":
{ Args: Record<PropertyKey, never>; Returns: {
              "avatar_path": string,"bio": string,"display_name": string,"email": string,"favorite_colors": Json,"id": string,"is_demo": boolean
            }[]
                           },
"process_ticket_purchase":
{ Args: { "p_campaign": string,"p_external_order_id": string,"p_idempotency_key": string,"p_link_code": string,"p_provider": string,"p_ticket_ids": (string)[] }; Returns: Json
                           },
"process_ticket_reversal":
{ Args: { "p_external_order_id": string,"p_idempotency_key": string,"p_kind": string,"p_provider": string,"p_ticket_ids": (string)[] }; Returns: Json
                           },
"random_code":
{ Args: { "p_len": number }; Returns: string
                           },
"redeem_reward":
{ Args: { "p_code": string }; Returns: Json
                           },
"refresh_demo_event_dates":
{ Args: Record<PropertyKey, never>; Returns: number
                           },
"remove_entity_admin":
{ Args: { "p_entity": string,"p_user": string }; Returns: undefined
                           },
"resolve_referral_code":
{ Args: { "p_code": string }; Returns: {
              "campaign_id": string,"campaign_name": string,"community_name": string,"community_slug": string,"event_id": string,"event_title": string,"mode": string,"ticket_url": string
            }[]
                           },
"reward_entitlement":
{ Args: { "p_base": number,"p_max_extra"?: number,"p_step": number,"p_valid": number }; Returns: number
                           },
"simulate_purchase":
{ Args: { "p_campaign": string,"p_idempotency_key": string,"p_link_code": string,"p_quantity": number }; Returns: Json
                           },
"simulate_reversal":
{ Args: { "p_idempotency_key": string,"p_kind": string,"p_order": string,"p_quantity": number }; Returns: Json
                           },
"slugify":
{ Args: { "p_text": string }; Returns: string
                           },
"unban_member":
{ Args: { "p_community": string,"p_user": string }; Returns: undefined
                           },
"unique_entity_slug":
{ Args: { "p_name": string }; Returns: string
                           },
"update_campaign_rules":
{ Args: { "p_base": number,"p_campaign": string,"p_conditions"?: string,"p_max_extra"?: number,"p_step": number }; Returns: number
                           }
          }
          Enums: {
            "data_origin": "demo"|"imported"|"user","entity_admin_role": "owner"|"admin","entity_kind": "dj"|"venue"|"collective","event_status": "draft"|"published"|"cancelled","message_channel": "announcements"|"chat"|"club","price_kind": "fixed"|"from"|"conditional-free"|"unknown"
          }
          CompositeTypes: {
            [_ in never]: never
          }
        }
}

type DatabaseWithoutInternals = Omit<Database, '__InternalSupabase'>

type DefaultSchema = DatabaseWithoutInternals[Extract<keyof Database, "public">]

export type Tables<
  DefaultSchemaTableNameOrOptions extends
    | keyof (DefaultSchema["Tables"] & DefaultSchema["Views"])
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
        DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])
    : never = never
> = DefaultSchemaTableNameOrOptions extends { schema: keyof DatabaseWithoutInternals }
  ? (DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"] &
      DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Views"])[TableName] extends {
      Row: infer R
    }
    ? R
    : never
  : DefaultSchemaTableNameOrOptions extends keyof (DefaultSchema["Tables"] & DefaultSchema["Views"])
  ? (DefaultSchema["Tables"] & DefaultSchema["Views"])[DefaultSchemaTableNameOrOptions] extends {
      Row: infer R
    }
    ? R
    : never
  : never

export type TablesInsert<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never
> = DefaultSchemaTableNameOrOptions extends { schema: keyof DatabaseWithoutInternals }
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Insert: infer I
    }
    ? I
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
  ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
      Insert: infer I
    }
    ? I
    : never
  : never

export type TablesUpdate<
  DefaultSchemaTableNameOrOptions extends
    | keyof DefaultSchema["Tables"]
    | { schema: keyof DatabaseWithoutInternals },
  TableName extends DefaultSchemaTableNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"]
    : never = never
> = DefaultSchemaTableNameOrOptions extends { schema: keyof DatabaseWithoutInternals }
  ? DatabaseWithoutInternals[DefaultSchemaTableNameOrOptions["schema"]]["Tables"][TableName] extends {
      Update: infer U
    }
    ? U
    : never
  : DefaultSchemaTableNameOrOptions extends keyof DefaultSchema["Tables"]
  ? DefaultSchema["Tables"][DefaultSchemaTableNameOrOptions] extends {
      Update: infer U
    }
    ? U
    : never
  : never

export type Enums<
  DefaultSchemaEnumNameOrOptions extends
    | keyof DefaultSchema["Enums"]
    | { schema: keyof DatabaseWithoutInternals },
  EnumName extends DefaultSchemaEnumNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"]
    : never = never
> = DefaultSchemaEnumNameOrOptions extends { schema: keyof DatabaseWithoutInternals }
  ? DatabaseWithoutInternals[DefaultSchemaEnumNameOrOptions["schema"]]["Enums"][EnumName]
  : DefaultSchemaEnumNameOrOptions extends keyof DefaultSchema["Enums"]
  ? DefaultSchema["Enums"][DefaultSchemaEnumNameOrOptions]
  : never

export type CompositeTypes<
  PublicCompositeTypeNameOrOptions extends
    | keyof DefaultSchema["CompositeTypes"]
    | { schema: keyof DatabaseWithoutInternals },
  CompositeTypeName extends PublicCompositeTypeNameOrOptions extends {
    schema: keyof DatabaseWithoutInternals
  }
    ? keyof DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"]
    : never = never
> = PublicCompositeTypeNameOrOptions extends { schema: keyof DatabaseWithoutInternals }
  ? DatabaseWithoutInternals[PublicCompositeTypeNameOrOptions["schema"]]["CompositeTypes"][CompositeTypeName]
  : PublicCompositeTypeNameOrOptions extends keyof DefaultSchema["CompositeTypes"]
  ? DefaultSchema["CompositeTypes"][PublicCompositeTypeNameOrOptions]
  : never

export const Constants = {
  "graphql_public": {
          Enums: {
            
          }
        },"public": {
          Enums: {
            "data_origin": ["demo", "imported", "user"],"entity_admin_role": ["owner", "admin"],"entity_kind": ["dj", "venue", "collective"],"event_status": ["draft", "published", "cancelled"],"message_channel": ["announcements", "chat", "club"],"price_kind": ["fixed", "from", "conditional-free", "unknown"]
          }
        }
} as const
