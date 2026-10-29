-- YOU IN? · Campañas de referidos e invitaciones por entradas válidas.
--
-- Regla por defecto (configurable por campaña, versionada):
--   entradas válidas < umbral (5)        -> 0 invitaciones
--   entradas válidas >= umbral           -> 1 (la propia) + floor(válidas / bloque (10)) adicionales
--   => 0-4: 0 · 5-9: 1 · 10-19: 2 · 20-29: 3 · 30-39: 4 ...
--
-- Principios:
--   * Cuentan ENTRADAS VÁLIDAS (ticket_items.status = 'valid'), no clics ni pedidos.
--   * Cada operación lleva una clave de idempotencia: reprocesarla devuelve el
--     resultado guardado sin duplicar compras ni recompensas. Un mismo pedido
--     externo no puede registrarse dos veces.
--   * Las compras de una campaña nunca se mezclan con otra: el enlace debe
--     pertenecer a la campaña y los reembolsos actúan sobre el pedido original.
--   * Cambiar las reglas crea una versión nueva. Nunca retira recompensas ya
--     concedidas; solo puede conceder más si la nueva regla es más generosa.
--   * Reembolsos/cancelaciones: se retiran solo invitaciones DISPONIBLES (la más
--     alta primero) y como máximo las que dependían de esas entradas. Si la
--     invitación ya se canjeó no se anula: queda un déficit que absorben las
--     siguientes entradas válidas antes de generar nuevas invitaciones.
--   * Una invitación se canjea una sola vez (actualización atómica).
--   * Modo 'simulation': solo admite compras del simulador (marcadas como tales).
--     Modo 'live': solo admitiría confirmaciones verificables de un proveedor vía
--     service_role. Ningún proveedor está conectado en esta versión.

create table public.referral_campaigns (
  id uuid primary key default gen_random_uuid(),
  community_id uuid not null references public.communities (id) on delete cascade,
  event_id uuid references public.events (id) on delete set null,
  name text not null check (char_length(btrim(name)) between 1 and 100),
  description text check (char_length(description) <= 1500),
  mode text not null default 'simulation' check (mode in ('simulation', 'live')),
  status text not null default 'active' check (status in ('draft', 'active', 'closed')),
  starts_at timestamptz not null default now(),
  ends_at timestamptz,
  current_rule_version integer not null default 1,
  is_demo boolean not null default false,
  created_by uuid references auth.users (id) on delete set null,
  created_at timestamptz not null default now(),
  constraint campaigns_dates check (ends_at is null or ends_at > starts_at)
);

create table public.campaign_rules (
  id uuid primary key default gen_random_uuid(),
  campaign_id uuid not null references public.referral_campaigns (id) on delete cascade,
  version integer not null,
  base_threshold integer not null check (base_threshold between 1 and 1000),
  step_size integer not null check (step_size between 1 and 1000),
  max_extra integer check (max_extra is null or max_extra between 0 and 1000),
  conditions text check (char_length(conditions) <= 1500),
  created_by uuid references auth.users (id) on delete set null,
  created_at timestamptz not null default now(),
  unique (campaign_id, version),
  constraint rules_base_le_step check (base_threshold <= step_size)
);

create table public.referral_links (
  id uuid primary key default gen_random_uuid(),
  campaign_id uuid not null references public.referral_campaigns (id) on delete cascade,
  user_id uuid not null references auth.users (id) on delete cascade,
  code text not null unique check (code ~ '^[A-Z0-9]{8}$'),
  created_at timestamptz not null default now(),
  unique (campaign_id, user_id)
);

create table public.ticket_orders (
  id uuid primary key default gen_random_uuid(),
  campaign_id uuid not null references public.referral_campaigns (id) on delete cascade,
  referral_link_id uuid not null references public.referral_links (id) on delete cascade,
  provider text not null,
  external_order_id text not null,
  is_simulated boolean not null,
  purchased_at timestamptz not null default now(),
  created_at timestamptz not null default now(),
  unique (provider, external_order_id),
  constraint orders_simulated_provider check (is_simulated = (provider = 'simulator'))
);
create index ticket_orders_link_idx on public.ticket_orders (referral_link_id);

create table public.ticket_items (
  id uuid primary key default gen_random_uuid(),
  order_id uuid not null references public.ticket_orders (id) on delete cascade,
  external_ticket_id text not null,
  status text not null default 'valid' check (status in ('valid', 'refunded', 'cancelled')),
  status_changed_at timestamptz not null default now(),
  unique (order_id, external_ticket_id)
);

create table public.ticket_operations (
  idempotency_key text primary key,
  campaign_id uuid not null references public.referral_campaigns (id) on delete cascade,
  kind text not null check (kind in ('purchase', 'refunded', 'cancelled')),
  result jsonb,
  created_by uuid references auth.users (id) on delete set null,
  created_at timestamptz not null default now()
);

create table public.rewards (
  id uuid primary key default gen_random_uuid(),
  campaign_id uuid not null references public.referral_campaigns (id) on delete cascade,
  referral_link_id uuid not null references public.referral_links (id) on delete cascade,
  user_id uuid not null references auth.users (id) on delete cascade,
  sequence integer not null check (sequence >= 1),
  kind text not null check (kind in ('own', 'extra')),
  status text not null default 'available' check (status in ('available', 'redeemed', 'revoked')),
  rule_version integer not null,
  code text not null unique,
  is_simulated boolean not null,
  granted_at timestamptz not null default now(),
  redeemed_at timestamptz,
  redeemed_by uuid references auth.users (id) on delete set null,
  revoked_at timestamptz,
  revoke_reason text,
  constraint rewards_redeemed_consistent check ((status = 'redeemed') = (redeemed_at is not null))
);
-- Nunca dos recompensas vivas con el mismo número para el mismo enlace.
create unique index rewards_live_sequence on public.rewards (referral_link_id, sequence) where status <> 'revoked';

create table public.reward_events (
  id bigint generated always as identity primary key,
  campaign_id uuid not null references public.referral_campaigns (id) on delete cascade,
  referral_link_id uuid references public.referral_links (id) on delete cascade,
  user_id uuid references auth.users (id) on delete cascade,
  type text not null check (type in ('tickets_valid', 'tickets_refunded', 'tickets_cancelled',
    'reward_granted', 'reward_revoked', 'reward_redeemed', 'reward_deficit', 'rules_changed', 'duplicate_ignored')),
  ticket_delta integer not null default 0,
  valid_tickets_after integer,
  reward_id uuid references public.rewards (id) on delete set null,
  detail text,
  operation_key text,
  is_simulated boolean not null default false,
  created_at timestamptz not null default now()
);
create index reward_events_link_idx on public.reward_events (referral_link_id, id desc);

-- ---------------------------------------------------------------------------
-- Cálculo puro (replicado en src/lib/domain/rewards.ts y probado en ambos lados)
-- ---------------------------------------------------------------------------
create or replace function public.reward_entitlement(p_valid integer, p_base integer, p_step integer, p_max_extra integer default null)
returns integer language sql immutable set search_path = '' as $$
  select case
    when p_valid < p_base then 0
    else 1 + least(p_valid / p_step, coalesce(p_max_extra, 2147483646))
  end;
$$;

create or replace function public.is_campaign_admin(p_campaign uuid)
returns boolean language sql stable security definer set search_path = '' as $$
  select exists (select 1 from public.referral_campaigns c
    where c.id = p_campaign and public.is_community_admin(c.community_id));
$$;

create or replace function public.link_valid_tickets(p_link uuid)
returns integer language sql stable security definer set search_path = '' as $$
  select count(*)::int from public.ticket_items i join public.ticket_orders o on o.id = i.order_id
  where o.referral_link_id = p_link and i.status = 'valid';
$$;

create or replace function public.random_code(p_len integer)
returns text language sql volatile set search_path = '' as $$
  select string_agg(substr('ABCDEFGHJKLMNPQRSTUVWXYZ23456789', 1 + (get_byte(b, i) % 32), 1), '')
  from (select extensions.gen_random_bytes(p_len) b) x, generate_series(0, p_len - 1) i;
$$;

-- Ajusta las recompensas de un enlace tras un cambio. Interna.
--   p_reason: 'purchase' | 'refund' | 'rules'
create or replace function public._apply_rewards(p_link uuid, p_valid_before integer, p_reason text, p_operation text)
returns jsonb language plpgsql security definer set search_path = '' as $$
declare
  v_link public.referral_links;
  v_campaign public.referral_campaigns;
  v_rule public.campaign_rules;
  v_valid integer;
  v_entitled integer;
  v_entitled_before integer;
  v_live integer;
  v_to_revoke integer;
  v_revoked integer := 0;
  v_granted jsonb := '[]'::jsonb;
  v_reward public.rewards;
  v_simulated boolean;
  i integer;
begin
  select * into v_link from public.referral_links where id = p_link;
  select * into v_campaign from public.referral_campaigns where id = v_link.campaign_id;
  select * into v_rule from public.campaign_rules where campaign_id = v_campaign.id and version = v_campaign.current_rule_version;
  v_simulated := v_campaign.mode = 'simulation';
  v_valid := public.link_valid_tickets(p_link);
  v_entitled := public.reward_entitlement(v_valid, v_rule.base_threshold, v_rule.step_size, v_rule.max_extra);
  select count(*) into v_live from public.rewards where referral_link_id = p_link and status <> 'revoked';

  if v_entitled > v_live then
    for i in 1 .. v_entitled loop
      exit when v_live >= v_entitled;
      if not exists (select 1 from public.rewards where referral_link_id = p_link and sequence = i and status <> 'revoked') then
        insert into public.rewards (campaign_id, referral_link_id, user_id, sequence, kind, rule_version, code, is_simulated)
        values (v_campaign.id, p_link, v_link.user_id, i, case when i = 1 then 'own' else 'extra' end,
                v_rule.version, 'INV-' || public.random_code(10), v_simulated)
        returning * into v_reward;
        v_live := v_live + 1;
        v_granted := v_granted || jsonb_build_object('id', v_reward.id, 'sequence', i, 'kind', v_reward.kind);
        insert into public.reward_events (campaign_id, referral_link_id, user_id, type, valid_tickets_after, reward_id, detail, operation_key, is_simulated)
        values (v_campaign.id, p_link, v_link.user_id, 'reward_granted', v_valid, v_reward.id,
                case when i = 1 then 'Tu invitación' else 'Invitación adicional nº ' || (i - 1) end
                || ' · regla v' || v_rule.version, p_operation, v_simulated);
      end if;
    end loop;
  elsif v_entitled < v_live and p_reason = 'refund' then
    v_entitled_before := public.reward_entitlement(p_valid_before, v_rule.base_threshold, v_rule.step_size, v_rule.max_extra);
    v_to_revoke := least(v_live - v_entitled, greatest(v_entitled_before - v_entitled, 0));
    for v_reward in
      select * from public.rewards where referral_link_id = p_link and status = 'available'
      order by sequence desc limit v_to_revoke
    loop
      update public.rewards set status = 'revoked', revoked_at = now(),
        revoke_reason = 'Entradas reembolsadas o canceladas' where id = v_reward.id;
      v_revoked := v_revoked + 1;
      insert into public.reward_events (campaign_id, referral_link_id, user_id, type, valid_tickets_after, reward_id, detail, operation_key, is_simulated)
      values (v_campaign.id, p_link, v_link.user_id, 'reward_revoked', v_valid, v_reward.id,
              'Se retira una invitación no canjeada por reembolso o cancelación', p_operation, v_simulated);
    end loop;
    if v_revoked < v_to_revoke then
      insert into public.reward_events (campaign_id, referral_link_id, user_id, type, valid_tickets_after, detail, operation_key, is_simulated)
      values (v_campaign.id, p_link, v_link.user_id, 'reward_deficit', v_valid,
              (v_to_revoke - v_revoked) || ' invitación(es) ya canjeada(s) no se anulan: las próximas entradas válidas cubrirán la diferencia',
              p_operation, v_simulated);
    end if;
  end if;

  return jsonb_build_object('valid_tickets', v_valid, 'entitled', v_entitled,
    'granted', v_granted, 'revoked', v_revoked, 'rule_version', v_rule.version);
end;
$$;

-- Registra una compra confirmada. Interna: la llaman simulate_purchase o, en el
-- futuro, un webhook verificado del proveedor con service_role.
create or replace function public.process_ticket_purchase(
  p_campaign uuid, p_link_code text, p_provider text, p_external_order_id text,
  p_ticket_ids text[], p_idempotency_key text
) returns jsonb language plpgsql security definer set search_path = '' as $$
declare
  v_campaign public.referral_campaigns;
  v_link public.referral_links;
  v_key text := p_provider || ':' || p_idempotency_key;
  v_existing jsonb;
  v_order uuid;
  v_before integer;
  v_result jsonb;
  v_simulated boolean := p_provider = 'simulator';
  v_ticket text;
begin
  if p_idempotency_key is null or char_length(p_idempotency_key) < 8 then
    raise exception 'Falta una clave de idempotencia válida';
  end if;
  select * into v_campaign from public.referral_campaigns where id = p_campaign;
  if v_campaign.id is null then raise exception 'Campaña no encontrada'; end if;

  -- Idempotencia: misma operación => mismo resultado, sin efectos nuevos.
  insert into public.ticket_operations (idempotency_key, campaign_id, kind, created_by)
  values (v_key, p_campaign, 'purchase', auth.uid())
  on conflict (idempotency_key) do nothing;
  if not found then
    select result into v_existing from public.ticket_operations where idempotency_key = v_key;
    if (select campaign_id from public.ticket_operations where idempotency_key = v_key) <> p_campaign then
      raise exception 'La clave de operación pertenece a otra campaña';
    end if;
    return coalesce(v_existing, '{}'::jsonb) || jsonb_build_object('replayed', true);
  end if;

  if v_campaign.status <> 'active' or now() < v_campaign.starts_at or (v_campaign.ends_at is not null and now() > v_campaign.ends_at) then
    raise exception 'La campaña no está activa';
  end if;
  if v_campaign.mode = 'simulation' and not v_simulated then
    raise exception 'Esta campaña es de simulación: no admite compras reales';
  end if;
  if v_campaign.mode = 'live' and v_simulated then
    raise exception 'Una campaña real no admite compras simuladas';
  end if;

  select * into v_link from public.referral_links where code = upper(btrim(p_link_code));
  if v_link.id is null then raise exception 'Enlace de referido desconocido'; end if;
  if v_link.campaign_id <> p_campaign then
    raise exception 'El enlace no pertenece a esta campaña: no se mezclan compras entre campañas';
  end if;
  if coalesce(array_length(p_ticket_ids, 1), 0) not between 1 and 50 then
    raise exception 'Un pedido debe tener entre 1 y 50 entradas';
  end if;
  if (select count(distinct t) from unnest(p_ticket_ids) t) <> array_length(p_ticket_ids, 1) then
    raise exception 'Hay identificadores de entrada repetidos';
  end if;
  if exists (select 1 from public.ticket_orders where provider = p_provider and external_order_id = p_external_order_id) then
    v_result := jsonb_build_object('status', 'duplicate_order', 'message', 'Este pedido ya estaba registrado: no se cuenta dos veces');
    update public.ticket_operations set result = v_result where idempotency_key = v_key;
    insert into public.reward_events (campaign_id, referral_link_id, user_id, type, detail, operation_key, is_simulated)
    values (p_campaign, v_link.id, v_link.user_id, 'duplicate_ignored', 'Pedido ' || p_external_order_id || ' repetido', v_key, v_simulated);
    return v_result;
  end if;

  perform pg_advisory_xact_lock(hashtext('referral_link:' || v_link.id::text));
  v_before := public.link_valid_tickets(v_link.id);

  insert into public.ticket_orders (campaign_id, referral_link_id, provider, external_order_id, is_simulated)
  values (p_campaign, v_link.id, p_provider, p_external_order_id, v_simulated)
  returning id into v_order;
  foreach v_ticket in array p_ticket_ids loop
    insert into public.ticket_items (order_id, external_ticket_id) values (v_order, v_ticket);
  end loop;

  insert into public.reward_events (campaign_id, referral_link_id, user_id, type, ticket_delta, valid_tickets_after, detail, operation_key, is_simulated)
  values (p_campaign, v_link.id, v_link.user_id, 'tickets_valid', array_length(p_ticket_ids, 1),
          v_before + array_length(p_ticket_ids, 1),
          array_length(p_ticket_ids, 1) || ' entrada(s) válida(s) · pedido ' || p_external_order_id, v_key, v_simulated);

  v_result := jsonb_build_object('status', 'processed', 'order_id', v_order, 'tickets', array_length(p_ticket_ids, 1))
    || public._apply_rewards(v_link.id, v_before, 'purchase', v_key);
  update public.ticket_operations set result = v_result where idempotency_key = v_key;
  return v_result;
end;
$$;

-- Reembolso o cancelación de entradas de un pedido ya registrado. Interna.
create or replace function public.process_ticket_reversal(
  p_provider text, p_external_order_id text, p_ticket_ids text[], p_kind text, p_idempotency_key text
) returns jsonb language plpgsql security definer set search_path = '' as $$
declare
  v_order public.ticket_orders;
  v_key text := p_provider || ':' || p_idempotency_key;
  v_existing jsonb;
  v_before integer;
  v_changed integer;
  v_result jsonb;
  v_user uuid;
begin
  if p_kind not in ('refunded', 'cancelled') then raise exception 'Tipo de operación no válido'; end if;
  if p_idempotency_key is null or char_length(p_idempotency_key) < 8 then
    raise exception 'Falta una clave de idempotencia válida';
  end if;
  select * into v_order from public.ticket_orders where provider = p_provider and external_order_id = p_external_order_id;
  if v_order.id is null then raise exception 'Pedido no encontrado'; end if;

  insert into public.ticket_operations (idempotency_key, campaign_id, kind, created_by)
  values (v_key, v_order.campaign_id, p_kind, auth.uid())
  on conflict (idempotency_key) do nothing;
  if not found then
    select result into v_existing from public.ticket_operations where idempotency_key = v_key;
    return coalesce(v_existing, '{}'::jsonb) || jsonb_build_object('replayed', true);
  end if;

  perform pg_advisory_xact_lock(hashtext('referral_link:' || v_order.referral_link_id::text));
  v_before := public.link_valid_tickets(v_order.referral_link_id);
  update public.ticket_items set status = p_kind, status_changed_at = now()
  where order_id = v_order.id and status = 'valid'
    and (p_ticket_ids is null or external_ticket_id = any (p_ticket_ids));
  get diagnostics v_changed = row_count;
  select user_id into v_user from public.referral_links where id = v_order.referral_link_id;

  if v_changed = 0 then
    v_result := jsonb_build_object('status', 'nothing_to_change', 'message', 'Esas entradas ya no estaban válidas');
  else
    insert into public.reward_events (campaign_id, referral_link_id, user_id, type, ticket_delta, valid_tickets_after, detail, operation_key, is_simulated)
    values (v_order.campaign_id, v_order.referral_link_id, v_user,
            case when p_kind = 'refunded' then 'tickets_refunded' else 'tickets_cancelled' end,
            -v_changed, v_before - v_changed,
            v_changed || ' entrada(s) ' || case when p_kind = 'refunded' then 'reembolsada(s)' else 'cancelada(s)' end
              || ' · pedido ' || p_external_order_id, v_key, v_order.is_simulated);
    v_result := jsonb_build_object('status', 'processed', 'tickets_changed', v_changed)
      || public._apply_rewards(v_order.referral_link_id, v_before, 'refund', v_key);
  end if;
  update public.ticket_operations set result = v_result where idempotency_key = v_key;
  return v_result;
end;
$$;

-- ---------------------------------------------------------------------------
-- API para la app (authenticated)
-- ---------------------------------------------------------------------------
create or replace function public.create_campaign(
  p_community uuid, p_name text, p_description text default null,
  p_base integer default 5, p_step integer default 10, p_max_extra integer default null,
  p_conditions text default null, p_event uuid default null, p_ends_at timestamptz default null
) returns uuid language plpgsql security definer set search_path = '' as $$
declare
  v_id uuid;
begin
  if not public.is_community_admin(p_community) then
    raise exception 'Solo la administración de la comunidad puede crear campañas' using errcode = '42501';
  end if;
  insert into public.referral_campaigns (community_id, event_id, name, description, mode, ends_at, created_by)
  values (p_community, p_event, btrim(p_name), p_description, 'simulation', p_ends_at, auth.uid())
  returning id into v_id;
  insert into public.campaign_rules (campaign_id, version, base_threshold, step_size, max_extra, conditions, created_by)
  values (v_id, 1, p_base, p_step, p_max_extra, p_conditions, auth.uid());
  return v_id;
end;
$$;

create or replace function public.update_campaign_rules(
  p_campaign uuid, p_base integer, p_step integer, p_max_extra integer default null, p_conditions text default null
) returns integer language plpgsql security definer set search_path = '' as $$
declare
  v_version integer;
  v_link record;
begin
  if not public.is_campaign_admin(p_campaign) then
    raise exception 'Solo la administración puede cambiar las reglas' using errcode = '42501';
  end if;
  select current_rule_version + 1 into v_version from public.referral_campaigns where id = p_campaign for update;
  insert into public.campaign_rules (campaign_id, version, base_threshold, step_size, max_extra, conditions, created_by)
  values (p_campaign, v_version, p_base, p_step, p_max_extra, p_conditions, auth.uid());
  update public.referral_campaigns set current_rule_version = v_version where id = p_campaign;
  insert into public.reward_events (campaign_id, type, detail, operation_key, is_simulated)
  values (p_campaign, 'rules_changed',
    'Regla v' || v_version || ': invitación desde ' || p_base || ' entradas, +1 cada ' || p_step
      || coalesce(' (máx. ' || p_max_extra || ' adicionales)', '') || '. Las recompensas ya concedidas se mantienen.',
    'rules:' || p_campaign || ':' || v_version,
    (select mode = 'simulation' from public.referral_campaigns where id = p_campaign));
  -- Solo puede conceder más (nunca retira por cambio de regla).
  for v_link in select id from public.referral_links where campaign_id = p_campaign loop
    perform pg_advisory_xact_lock(hashtext('referral_link:' || v_link.id::text));
    perform public._apply_rewards(v_link.id, public.link_valid_tickets(v_link.id), 'rules', 'rules:' || p_campaign || ':' || v_version);
  end loop;
  return v_version;
end;
$$;

create or replace function public.get_or_create_referral_link(p_campaign uuid)
returns public.referral_links language plpgsql security definer set search_path = '' as $$
declare
  v_uid uuid := auth.uid();
  v_link public.referral_links;
  v_campaign public.referral_campaigns;
begin
  if v_uid is null then raise exception 'Necesitas iniciar sesión' using errcode = '28000'; end if;
  select * into v_campaign from public.referral_campaigns where id = p_campaign;
  if v_campaign.id is null then raise exception 'Campaña no encontrada'; end if;
  select * into v_link from public.referral_links where campaign_id = p_campaign and user_id = v_uid;
  if v_link.id is not null then return v_link; end if;
  if not (public.is_community_member(v_campaign.community_id) or public.is_community_admin(v_campaign.community_id)) then
    raise exception 'Únete a la comunidad para obtener tu enlace personal' using errcode = '42501';
  end if;
  if v_campaign.status <> 'active' then raise exception 'La campaña no está activa'; end if;
  loop
    begin
      insert into public.referral_links (campaign_id, user_id, code)
      values (p_campaign, v_uid, public.random_code(8)) returning * into v_link;
      return v_link;
    exception when unique_violation then
      select * into v_link from public.referral_links where campaign_id = p_campaign and user_id = v_uid;
      if v_link.id is not null then return v_link; end if;
    end;
  end loop;
end;
$$;

-- Datos públicos de un enlace (para la página /r/CODIGO). No expone a la persona.
create or replace function public.resolve_referral_code(p_code text)
returns table (campaign_id uuid, campaign_name text, community_slug text, community_name text,
  event_id uuid, event_title text, ticket_url text, mode text)
language sql stable security definer set search_path = '' as $$
  select c.id, c.name, co.slug, co.name, e.id, e.title, e.ticket_url, c.mode
  from public.referral_links l
  join public.referral_campaigns c on c.id = l.campaign_id
  join public.communities co on co.id = c.community_id
  left join public.events e on e.id = c.event_id
  where l.code = upper(btrim(p_code));
$$;

-- Simulador: separado del flujo real, solo en campañas de simulación.
-- Lo puede usar la administración (cualquier enlace) o la persona dueña del enlace.
create or replace function public.simulate_purchase(p_campaign uuid, p_link_code text, p_quantity integer, p_idempotency_key text)
returns jsonb language plpgsql security definer set search_path = '' as $$
declare
  v_link public.referral_links;
  v_mode text;
begin
  select mode into v_mode from public.referral_campaigns where id = p_campaign;
  if v_mode is distinct from 'simulation' then raise exception 'El simulador solo funciona en campañas de simulación'; end if;
  select * into v_link from public.referral_links where code = upper(btrim(p_link_code));
  if not (public.is_campaign_admin(p_campaign) or coalesce(v_link.user_id = auth.uid(), false)) then
    raise exception 'Solo puedes simular compras con tu propio enlace' using errcode = '42501';
  end if;
  if p_quantity not between 1 and 50 then raise exception 'Entre 1 y 50 entradas por compra'; end if;
  return public.process_ticket_purchase(p_campaign, p_link_code, 'simulator', 'SIM-' || p_idempotency_key,
    array(select 'SIM-' || p_idempotency_key || '-' || g from generate_series(1, p_quantity) g),
    p_idempotency_key);
end;
$$;

create or replace function public.simulate_reversal(p_order uuid, p_quantity integer, p_kind text, p_idempotency_key text)
returns jsonb language plpgsql security definer set search_path = '' as $$
declare
  v_order public.ticket_orders;
  v_owner uuid;
  v_ids text[];
begin
  select * into v_order from public.ticket_orders where id = p_order;
  if v_order.id is null or not v_order.is_simulated then raise exception 'Solo se pueden revertir compras simuladas aquí'; end if;
  select user_id into v_owner from public.referral_links where id = v_order.referral_link_id;
  if not (public.is_campaign_admin(v_order.campaign_id) or v_owner = auth.uid()) then
    raise exception 'No puedes modificar esta compra' using errcode = '42501';
  end if;
  select array_agg(external_ticket_id order by external_ticket_id desc) into v_ids
  from (select external_ticket_id from public.ticket_items where order_id = p_order and status = 'valid'
        order by external_ticket_id desc limit greatest(p_quantity, 0)) t;
  return public.process_ticket_reversal('simulator', v_order.external_order_id, coalesce(v_ids, '{}'), p_kind, p_idempotency_key);
end;
$$;

-- Canje en puerta: solo administración, una sola vez.
create or replace function public.redeem_reward(p_code text)
returns jsonb language plpgsql security definer set search_path = '' as $$
declare
  v_reward public.rewards;
begin
  select * into v_reward from public.rewards where code = upper(btrim(p_code));
  if v_reward.id is null then raise exception 'Código de invitación desconocido'; end if;
  if not public.is_campaign_admin(v_reward.campaign_id) then
    raise exception 'Solo la administración de la campaña puede canjear invitaciones' using errcode = '42501';
  end if;
  update public.rewards set status = 'redeemed', redeemed_at = now(), redeemed_by = auth.uid()
  where id = v_reward.id and status = 'available'
  returning * into v_reward;
  if not found then
    select * into v_reward from public.rewards where code = upper(btrim(p_code));
    if v_reward.status = 'redeemed' then
      raise exception 'Esta invitación ya se canjeó el %', to_char(v_reward.redeemed_at at time zone 'Europe/Madrid', 'DD/MM/YYYY HH24:MI') using hint = 'already_redeemed';
    end if;
    raise exception 'Esta invitación fue retirada y no se puede canjear' using hint = 'revoked';
  end if;
  insert into public.reward_events (campaign_id, referral_link_id, user_id, type, reward_id, detail, operation_key, is_simulated)
  values (v_reward.campaign_id, v_reward.referral_link_id, v_reward.user_id, 'reward_redeemed', v_reward.id,
          'Invitación canjeada', 'redeem:' || v_reward.id, v_reward.is_simulated);
  return jsonb_build_object('status', 'redeemed', 'reward_id', v_reward.id, 'kind', v_reward.kind, 'sequence', v_reward.sequence);
end;
$$;

-- Resultados por enlace para el panel (solo administración).
create or replace function public.campaign_results(p_campaign uuid)
returns table (referral_link_id uuid, code text, display_name text, valid_tickets bigint, reversed_tickets bigint,
  orders bigint, rewards_available bigint, rewards_redeemed bigint, rewards_revoked bigint)
language sql stable security definer set search_path = '' as $$
  select l.id, l.code, p.display_name,
    (select count(*) from public.ticket_items i join public.ticket_orders o on o.id = i.order_id where o.referral_link_id = l.id and i.status = 'valid'),
    (select count(*) from public.ticket_items i join public.ticket_orders o on o.id = i.order_id where o.referral_link_id = l.id and i.status <> 'valid'),
    (select count(*) from public.ticket_orders o where o.referral_link_id = l.id),
    (select count(*) from public.rewards r where r.referral_link_id = l.id and r.status = 'available'),
    (select count(*) from public.rewards r where r.referral_link_id = l.id and r.status = 'redeemed'),
    (select count(*) from public.rewards r where r.referral_link_id = l.id and r.status = 'revoked')
  from public.referral_links l join public.profiles p on p.id = l.user_id
  where l.campaign_id = p_campaign and public.is_campaign_admin(p_campaign)
  order by 4 desc, 3;
$$;

-- ---------------------------------------------------------------------------
-- RLS
-- ---------------------------------------------------------------------------
alter table public.referral_campaigns enable row level security;
alter table public.campaign_rules enable row level security;
alter table public.referral_links enable row level security;
alter table public.ticket_orders enable row level security;
alter table public.ticket_items enable row level security;
alter table public.ticket_operations enable row level security;
alter table public.rewards enable row level security;
alter table public.reward_events enable row level security;

create policy "campaigns: lectura pública" on public.referral_campaigns for select using (true);
create policy "campaigns: la administración edita textos y estado" on public.referral_campaigns
  for update to authenticated using (public.is_campaign_admin(id)) with check (public.is_campaign_admin(id));
revoke update on public.referral_campaigns from authenticated;
grant update (name, description, status, ends_at, event_id) on public.referral_campaigns to authenticated;

create policy "campaign_rules: lectura pública" on public.campaign_rules for select using (true);

create policy "referral_links: propio o administración" on public.referral_links
  for select to authenticated using (user_id = (select auth.uid()) or public.is_campaign_admin(campaign_id));

create policy "ticket_orders: propio o administración" on public.ticket_orders
  for select to authenticated using (
    public.is_campaign_admin(campaign_id)
    or exists (select 1 from public.referral_links l where l.id = referral_link_id and l.user_id = (select auth.uid())));
create policy "ticket_items: propio o administración" on public.ticket_items
  for select to authenticated using (exists (
    select 1 from public.ticket_orders o join public.referral_links l on l.id = o.referral_link_id
    where o.id = order_id and (l.user_id = (select auth.uid()) or public.is_campaign_admin(o.campaign_id))));
create policy "ticket_operations: administración" on public.ticket_operations
  for select to authenticated using (public.is_campaign_admin(campaign_id));
create policy "rewards: propias o administración" on public.rewards
  for select to authenticated using (user_id = (select auth.uid()) or public.is_campaign_admin(campaign_id));
create policy "reward_events: propios o administración" on public.reward_events
  for select to authenticated using (user_id = (select auth.uid()) or public.is_campaign_admin(campaign_id));

-- Las funciones internas no se exponen a la API pública.
revoke execute on function public._apply_rewards(uuid, integer, text, text) from public, anon, authenticated;
revoke execute on function public.process_ticket_purchase(uuid, text, text, text, text[], text) from public, anon, authenticated;
revoke execute on function public.process_ticket_reversal(text, text, text[], text, text) from public, anon, authenticated;
revoke execute on function public.link_valid_tickets(uuid) from public, anon, authenticated;
revoke execute on function public.random_code(integer) from public, anon, authenticated;
grant execute on function public.process_ticket_purchase(uuid, text, text, text, text[], text) to service_role;
grant execute on function public.process_ticket_reversal(text, text, text[], text, text) to service_role;
revoke execute on function public.create_campaign(uuid, text, text, integer, integer, integer, text, uuid, timestamptz) from public, anon;
revoke execute on function public.update_campaign_rules(uuid, integer, integer, integer, text) from public, anon;
revoke execute on function public.get_or_create_referral_link(uuid) from public, anon;
revoke execute on function public.simulate_purchase(uuid, text, integer, text) from public, anon;
revoke execute on function public.simulate_reversal(uuid, integer, text, text) from public, anon;
revoke execute on function public.redeem_reward(text) from public, anon;
revoke execute on function public.campaign_results(uuid) from public, anon;
