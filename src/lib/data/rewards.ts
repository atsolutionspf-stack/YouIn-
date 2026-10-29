import type { CampaignRuleRow, DB } from '@/lib/types';
import type { RewardRule } from '@/lib/domain/rewards';
import { friendlyError } from './errors';

export function toRule(row: CampaignRuleRow): RewardRule {
  return { version: row.version, baseThreshold: row.base_threshold, stepSize: row.step_size, maxExtra: row.max_extra, conditions: row.conditions };
}

export async function fetchCampaign(db: DB, id: string) {
  const { data, error } = await db
    .from('referral_campaigns')
    .select('*, communities(id, slug, name, entity_id), events(id, title, starts_at, ends_at, ticket_url), campaign_rules(*)')
    .eq('id', id)
    .maybeSingle();
  if (error) throw new Error(friendlyError(error, 'No se pudo cargar la campaña'));
  return data;
}

export async function fetchCommunityCampaigns(db: DB, communityId: string) {
  const { data, error } = await db
    .from('referral_campaigns')
    .select('*, campaign_rules(*)')
    .eq('community_id', communityId)
    .order('created_at', { ascending: false });
  if (error) throw new Error(friendlyError(error));
  return data ?? [];
}

export async function getOrCreateLink(db: DB, campaignId: string) {
  const { data, error } = await db.rpc('get_or_create_referral_link', { p_campaign: campaignId });
  if (error) throw new Error(friendlyError(error, 'No se pudo obtener tu enlace'));
  return data;
}

export async function fetchMyLink(db: DB, campaignId: string, userId: string) {
  const { data } = await db.from('referral_links').select('*').eq('campaign_id', campaignId).eq('user_id', userId).maybeSingle();
  return data;
}

/** Estado completo de un enlace: pedidos, entradas, invitaciones e historial. */
export async function fetchLinkStatus(db: DB, linkId: string) {
  const [orders, rewards, events] = await Promise.all([
    db.from('ticket_orders').select('id, external_order_id, provider, is_simulated, purchased_at, ticket_items(id, external_ticket_id, status, status_changed_at)')
      .eq('referral_link_id', linkId).order('purchased_at', { ascending: false }),
    db.from('rewards').select('*').eq('referral_link_id', linkId).order('sequence').order('granted_at'),
    db.from('reward_events').select('*').eq('referral_link_id', linkId).order('id', { ascending: false }).limit(100),
  ]);
  const error = orders.error || rewards.error || events.error;
  if (error) throw new Error(friendlyError(error, 'No se pudo cargar tu progreso'));
  const allItems = (orders.data ?? []).flatMap((o) => o.ticket_items ?? []);
  return {
    orders: orders.data ?? [],
    rewards: rewards.data ?? [],
    history: events.data ?? [],
    validTickets: allItems.filter((i) => i.status === 'valid').length,
    reversedTickets: allItems.filter((i) => i.status !== 'valid').length,
  };
}

export async function simulatePurchase(db: DB, campaignId: string, code: string, quantity: number, idempotencyKey: string) {
  const { data, error } = await db.rpc('simulate_purchase', {
    p_campaign: campaignId, p_link_code: code, p_quantity: quantity, p_idempotency_key: idempotencyKey,
  });
  if (error) throw new Error(friendlyError(error, 'No se pudo simular la compra'));
  return data as Record<string, unknown>;
}

export async function simulateReversal(db: DB, orderId: string, quantity: number, kind: 'refunded' | 'cancelled', idempotencyKey: string) {
  const { data, error } = await db.rpc('simulate_reversal', {
    p_order: orderId, p_quantity: quantity, p_kind: kind, p_idempotency_key: idempotencyKey,
  });
  if (error) throw new Error(friendlyError(error, 'No se pudo simular la operación'));
  return data as Record<string, unknown>;
}

export async function redeemReward(db: DB, code: string) {
  const { data, error } = await db.rpc('redeem_reward', { p_code: code });
  if (error) throw new Error(friendlyError(error, 'No se pudo canjear'));
  return data as Record<string, unknown>;
}

export async function createCampaign(
  db: DB,
  input: { communityId: string; name: string; description: string; base: number; step: number; maxExtra: number | null; conditions: string; eventId: string | null; endsAt: string | null },
) {
  const { data, error } = await db.rpc('create_campaign', {
    p_community: input.communityId, p_name: input.name, p_description: input.description, p_base: input.base, p_step: input.step,
    p_max_extra: input.maxExtra ?? undefined, p_conditions: input.conditions, p_event: input.eventId ?? undefined, p_ends_at: input.endsAt ?? undefined,
  });
  if (error) throw new Error(friendlyError(error, 'No se pudo crear la campaña'));
  return data as string;
}

export async function updateRules(db: DB, campaignId: string, base: number, step: number, maxExtra: number | null, conditions: string) {
  const { data, error } = await db.rpc('update_campaign_rules', {
    p_campaign: campaignId, p_base: base, p_step: step, p_max_extra: maxExtra ?? undefined, p_conditions: conditions,
  });
  if (error) throw new Error(friendlyError(error, 'No se pudieron guardar las reglas'));
  return data as number;
}

export async function setCampaignStatus(db: DB, campaignId: string, status: 'draft' | 'active' | 'closed') {
  const { error } = await db.from('referral_campaigns').update({ status }).eq('id', campaignId);
  if (error) throw new Error(friendlyError(error));
}

export async function fetchCampaignResults(db: DB, campaignId: string) {
  const { data, error } = await db.rpc('campaign_results', { p_campaign: campaignId });
  if (error) throw new Error(friendlyError(error));
  return data ?? [];
}

export async function fetchCampaignHistory(db: DB, campaignId: string) {
  const { data, error } = await db.from('reward_events').select('*').eq('campaign_id', campaignId).order('id', { ascending: false }).limit(200);
  if (error) throw new Error(friendlyError(error));
  return data ?? [];
}

export async function fetchCampaignRewards(db: DB, campaignId: string) {
  const { data, error } = await db.from('rewards').select('*').eq('campaign_id', campaignId).order('granted_at', { ascending: false });
  if (error) throw new Error(friendlyError(error));
  return data ?? [];
}

export async function resolveReferralCode(db: DB, code: string) {
  const { data, error } = await db.rpc('resolve_referral_code', { p_code: code });
  if (error) throw new Error(friendlyError(error));
  return data?.[0] ?? null;
}

export async function fetchMyCampaigns(db: DB, userId: string) {
  const { data } = await db.from('referral_links').select('id, code, campaign_id, referral_campaigns(id, name, mode, status, communities(slug, name))').eq('user_id', userId);
  return data ?? [];
}
