// Referidos e invitaciones de House Arena (campaña de simulación) contra Supabase local.
import { describe, expect, it, beforeAll } from 'vitest';
import type { SupabaseClient } from '@supabase/supabase-js';
import { anon, communityBySlug, demoUser, freshUser, opKey } from './helpers';

type Reward = { id: string; status: string; sequence: number; kind: string; code: string };

describe('referidos e invitaciones', () => {
  let campaignId: string;
  let communityId: string;

  beforeAll(async () => {
    const c = await communityBySlug(anon(), 'house-arena');
    communityId = c.id;
    const { data } = await anon().from('referral_campaigns').select('id').eq('community_id', c.id).eq('is_demo', true).single();
    campaignId = data!.id;
  });

  async function newReferrer() {
    const u = await freshUser('Referidora');
    await u.client.rpc('join_community', { p_community: communityId });
    const link = await u.client.rpc('get_or_create_referral_link', { p_campaign: campaignId });
    expect(link.error).toBeNull();
    return { ...u, code: link.data.code as string };
  }
  const buy = (c: SupabaseClient, code: string, qty: number, key = opKey()) =>
    c.rpc('simulate_purchase', { p_campaign: campaignId, p_link_code: code, p_quantity: qty, p_idempotency_key: key });
  const live = async (c: SupabaseClient) => {
    const { data } = await c.from('rewards').select('id, status, sequence, kind, code').eq('campaign_id', campaignId).order('sequence');
    return (data ?? []) as Reward[];
  };
  const countLive = async (c: SupabaseClient) => (await live(c)).filter((r) => r.status !== 'revoked').length;

  it('recompensas correctas en los límites 4, 5, 9, 10, 19, 20 y 30', async () => {
    const u = await newReferrer();
    const steps: [number, number][] = [[4, 0], [1, 1], [4, 1], [1, 2], [9, 2], [1, 3], [10, 4]];
    let total = 0;
    for (const [qty, expected] of steps) {
      const r = await buy(u.client, u.code, qty);
      expect(r.error).toBeNull();
      total += qty;
      expect(r.data.valid_tickets).toBe(total);
      expect(await countLive(u.client)).toBe(expected);
    }
    expect(total).toBe(30);
    const rewards = await live(u.client);
    expect(rewards[0].kind).toBe('own');
    expect(rewards.slice(1).every((r) => r.kind === 'extra')).toBe(true);
    // El enlace se mantiene: pedirlo otra vez devuelve el mismo código.
    const again = await u.client.rpc('get_or_create_referral_link', { p_campaign: campaignId });
    expect(again.data.code).toBe(u.code);
  });

  it('un pedido cuenta todas sus entradas, no como una sola', async () => {
    const u = await newReferrer();
    const r = await buy(u.client, u.code, 5);
    expect(r.data.valid_tickets).toBe(5);
    expect(await countLive(u.client)).toBe(1);
  });

  it('procesar dos veces la misma operación no duplica compras ni recompensas', async () => {
    const u = await newReferrer();
    const key = opKey();
    const first = await buy(u.client, u.code, 5, key);
    const second = await buy(u.client, u.code, 5, key);
    expect(first.data.valid_tickets).toBe(5);
    expect(second.data.replayed).toBe(true);
    expect(second.data.valid_tickets).toBe(5);
    expect(await countLive(u.client)).toBe(1);
    const { data: orders } = await u.client.from('ticket_orders').select('id');
    expect(orders).toHaveLength(1);
    // Reembolso repetido tampoco resta dos veces.
    const rkey = opKey();
    await u.client.rpc('simulate_reversal', { p_order: orders![0].id, p_quantity: 1, p_kind: 'refunded', p_idempotency_key: rkey });
    const rep = await u.client.rpc('simulate_reversal', { p_order: orders![0].id, p_quantity: 1, p_kind: 'refunded', p_idempotency_key: rkey });
    expect(rep.data.replayed).toBe(true);
    const { data: items } = await u.client.from('ticket_items').select('status');
    expect(items!.filter((i) => i.status === 'valid')).toHaveLength(4);
  });

  it('una invitación no se puede canjear dos veces y solo la canjea la administración', async () => {
    const u = await newReferrer();
    await buy(u.client, u.code, 5);
    const [reward] = await live(u.client);
    const self = await u.client.rpc('redeem_reward', { p_code: reward.code });
    expect(self.error).not.toBeNull();
    const admin = await demoUser('arena');
    const ok = await admin.client.rpc('redeem_reward', { p_code: reward.code });
    expect(ok.error).toBeNull();
    const twice = await admin.client.rpc('redeem_reward', { p_code: reward.code });
    expect(twice.error?.message).toMatch(/ya se canjeó/);
    // Concurrencia: dos canjes simultáneos de otra invitación, solo uno gana.
    const v = await newReferrer();
    await buy(v.client, v.code, 5);
    const [r2] = await live(v.client);
    const results = await Promise.all([admin.client.rpc('redeem_reward', { p_code: r2.code }), admin.client.rpc('redeem_reward', { p_code: r2.code })]);
    expect(results.filter((r) => !r.error)).toHaveLength(1);
  });

  it('reembolsos: retiran invitaciones disponibles; si ya se canjeó, queda déficit sin nuevas invitaciones', async () => {
    const admin = await demoUser('arena');
    const u = await newReferrer();
    await buy(u.client, u.code, 5);
    const { data: orders } = await u.client.from('ticket_orders').select('id');
    // Reembolso con invitación disponible -> se retira.
    await u.client.rpc('simulate_reversal', { p_order: orders![0].id, p_quantity: 1, p_kind: 'refunded', p_idempotency_key: opKey() });
    expect((await live(u.client)).map((r) => r.status)).toEqual(['revoked']);
    // Vuelve a 5 -> nueva invitación; se canjea; luego se cancela una entrada.
    await buy(u.client, u.code, 1);
    const current = (await live(u.client)).find((r) => r.status === 'available')!;
    await admin.client.rpc('redeem_reward', { p_code: current.code });
    const { data: orders2 } = await u.client.from('ticket_orders').select('id, purchased_at').order('purchased_at');
    await u.client.rpc('simulate_reversal', { p_order: orders2![0].id, p_quantity: 1, p_kind: 'cancelled', p_idempotency_key: opKey() });
    const afterCancel = await live(u.client);
    expect(afterCancel.filter((r) => r.status === 'redeemed')).toHaveLength(1);
    const { data: events } = await u.client.from('reward_events').select('type').eq('type', 'reward_deficit');
    expect(events!.length).toBe(1);
    // 4 válidas: comprar 1 más (5) no genera otra invitación, la canjeada ya la cubre.
    await buy(u.client, u.code, 1);
    expect((await live(u.client)).filter((r) => r.status !== 'revoked')).toHaveLength(1);
  });

  it('cambiar las reglas no retira recompensas ya concedidas', async () => {
    const admin = await demoUser('arena');
    const created = await admin.client.rpc('create_campaign', { p_community: communityId, p_name: `Campaña reglas ${Date.now()}`, p_base: 5, p_step: 10 });
    expect(created.error).toBeNull();
    const camp = created.data as string;
    const u = await freshUser('Reglas');
    await u.client.rpc('join_community', { p_community: communityId });
    const link = await u.client.rpc('get_or_create_referral_link', { p_campaign: camp });
    await u.client.rpc('simulate_purchase', { p_campaign: camp, p_link_code: link.data.code, p_quantity: 10, p_idempotency_key: opKey() });
    const count = async () => (await u.client.from('rewards').select('status').eq('campaign_id', camp)).data!.filter((r) => r.status !== 'revoked').length;
    expect(await count()).toBe(2);
    // Regla más estricta: se mantienen las 2.
    expect((await admin.client.rpc('update_campaign_rules', { p_campaign: camp, p_base: 8, p_step: 20 })).error).toBeNull();
    expect(await count()).toBe(2);
    // Regla más generosa: concede las que faltan (10 entradas, bloque 3 -> 1 + 3 = 4).
    await admin.client.rpc('update_campaign_rules', { p_campaign: camp, p_base: 2, p_step: 3 });
    expect(await count()).toBe(4);
    const { data: rules } = await anon().from('campaign_rules').select('version').eq('campaign_id', camp);
    expect(rules).toHaveLength(3);
    // Un miembro no puede cambiar reglas.
    expect((await u.client.rpc('update_campaign_rules', { p_campaign: camp, p_base: 1, p_step: 1 })).error).not.toBeNull();
  });

  it('no se mezclan compras entre campañas ni se usan enlaces ajenos', async () => {
    const admin = await demoUser('arena');
    const other = await admin.client.rpc('create_campaign', { p_community: communityId, p_name: `Otra campaña ${Date.now()}` });
    const u = await newReferrer();
    const cross = await u.client.rpc('simulate_purchase', { p_campaign: other.data, p_link_code: u.code, p_quantity: 1, p_idempotency_key: opKey() });
    expect(cross.error?.message).toMatch(/no pertenece a esta campaña/);
    const stranger = await freshUser('Ajeno');
    const steal = await buy(stranger.client, u.code, 5);
    expect(steal.error).not.toBeNull();
    // Nadie ve las recompensas de otra persona.
    const spy = await stranger.client.from('rewards').select('id').eq('campaign_id', campaignId);
    expect(spy.data).toHaveLength(0);
  });

  it('las funciones internas de proceso no son accesibles desde la API pública', async () => {
    const u = await newReferrer();
    const direct = await u.client.rpc('process_ticket_purchase', {
      p_campaign: campaignId, p_link_code: u.code, p_provider: 'xceed', p_external_order_id: 'X1', p_ticket_ids: ['a'], p_idempotency_key: opKey(),
    });
    expect(direct.error).not.toBeNull();
  });
});
