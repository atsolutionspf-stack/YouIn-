-- YOU IN? · Comunidades, anuncios, chat de miembros, moderación y club de pago (estructura).
--
-- Reglas:
--   * Cada DJ, sala o colectivo puede tener UNA comunidad gratuita.
--   * Seguir un perfil no da acceso a su comunidad: hay que unirse.
--   * La comunidad la administran los administradores de la entidad.
--   * Una persona expulsada pierde la membresía y queda vetada: las políticas
--     RLS dejan de devolverle mensajes, también por Realtime.
--   * El club de pago es un espacio separado con su propio acceso
--     (club_memberships). En esta versión NO hay cobros: no existe ninguna vía
--     para crear membresías de club desde la app, solo la vista previa.

create type public.message_channel as enum ('announcements', 'chat', 'club');

create table public.communities (
  id uuid primary key default gen_random_uuid(),
  entity_id uuid not null unique references public.entities (id) on delete cascade,
  slug text not null unique check (slug ~ '^[a-z0-9][a-z0-9-]{1,79}$'),
  name text not null check (char_length(btrim(name)) between 1 and 80),
  description text check (char_length(description) <= 1000),
  genres text[] not null default '{}',
  rules text check (char_length(rules) <= 1500),
  free_benefits text[] not null default '{}',
  welcome_message text check (char_length(welcome_message) <= 500),
  is_demo boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create trigger communities_touch before update on public.communities
  for each row execute function public.touch_updated_at();

create table public.community_members (
  community_id uuid not null references public.communities (id) on delete cascade,
  user_id uuid not null references auth.users (id) on delete cascade,
  joined_at timestamptz not null default now(),
  primary key (community_id, user_id)
);
create index community_members_user_idx on public.community_members (user_id);

create table public.community_bans (
  community_id uuid not null references public.communities (id) on delete cascade,
  user_id uuid not null references auth.users (id) on delete cascade,
  reason text check (char_length(reason) <= 300),
  banned_by uuid references auth.users (id) on delete set null,
  created_at timestamptz not null default now(),
  primary key (community_id, user_id)
);

create table public.messages (
  id bigint generated always as identity primary key,
  community_id uuid not null references public.communities (id) on delete cascade,
  channel public.message_channel not null default 'chat',
  author_id uuid not null default auth.uid() references auth.users (id) on delete cascade,
  body text not null default '',
  client_id uuid,
  created_at timestamptz not null default now(),
  deleted_at timestamptz,
  deleted_by uuid references auth.users (id) on delete set null,
  constraint messages_body_len check (
    (deleted_at is null and char_length(btrim(body)) between 1 and 1500)
    or (deleted_at is not null and body = '')
  ),
  constraint messages_client_unique unique (author_id, client_id)
);
create index messages_page_idx on public.messages (community_id, channel, id desc);
create index messages_author_recent_idx on public.messages (author_id, created_at desc);

create table public.community_reads (
  community_id uuid not null references public.communities (id) on delete cascade,
  user_id uuid not null references auth.users (id) on delete cascade,
  channel public.message_channel not null,
  last_read_id bigint not null default 0,
  updated_at timestamptz not null default now(),
  primary key (community_id, user_id, channel)
);

-- Club de pago: una suscripción propia por comunidad. Precio y ventajas los
-- decide la comunidad; la comisión de la plataforma no la edita el creador.
create table public.clubs (
  id uuid primary key default gen_random_uuid(),
  community_id uuid not null unique references public.communities (id) on delete cascade,
  name text not null check (char_length(btrim(name)) between 1 and 80),
  description text check (char_length(description) <= 1000),
  price_cents integer not null default 0 check (price_cents between 0 and 100000),
  currency text not null default 'EUR' check (currency = 'EUR'),
  billing_interval text not null default 'month' check (billing_interval in ('month', 'year')),
  benefits text[] not null default '{}',
  platform_fee_bps integer not null default 1000 check (platform_fee_bps between 0 and 5000),
  -- 'active' queda bloqueado hasta conectar un proveedor de pagos real.
  status text not null default 'preview' check (status in ('draft', 'preview')),
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
create trigger clubs_touch before update on public.clubs
  for each row execute function public.touch_updated_at();

create table public.club_memberships (
  club_id uuid not null references public.clubs (id) on delete cascade,
  user_id uuid not null references auth.users (id) on delete cascade,
  status text not null check (status in ('active', 'past_due', 'cancelled')),
  provider text not null,
  provider_subscription_id text not null,
  current_period_end timestamptz not null,
  created_at timestamptz not null default now(),
  primary key (club_id, user_id),
  unique (provider, provider_subscription_id)
);
comment on table public.club_memberships is 'Solo la escribiría el webhook de un proveedor de pagos con service_role. Vacía en esta versión: no se simula acceso premium.';

-- ---------------------------------------------------------------------------
-- Funciones de permiso
-- ---------------------------------------------------------------------------
create or replace function public.is_community_admin(p_community uuid)
returns boolean language sql stable security definer set search_path = '' as $$
  select exists (
    select 1 from public.communities c
    where c.id = p_community and public.is_entity_admin(c.entity_id)
  );
$$;

create or replace function public.is_community_member(p_community uuid)
returns boolean language sql stable security definer set search_path = '' as $$
  select exists (
    select 1 from public.community_members m
    where m.community_id = p_community and m.user_id = auth.uid()
  ) and not exists (
    select 1 from public.community_bans b
    where b.community_id = p_community and b.user_id = auth.uid()
  );
$$;

create or replace function public.has_club_access(p_community uuid)
returns boolean language sql stable security definer set search_path = '' as $$
  select exists (
    select 1 from public.clubs c
    join public.club_memberships m on m.club_id = c.id
    where c.community_id = p_community and m.user_id = auth.uid()
      and m.status = 'active' and m.current_period_end > now()
  ) or public.is_community_admin(p_community);
$$;

-- ---------------------------------------------------------------------------
-- RLS
-- ---------------------------------------------------------------------------
alter table public.communities enable row level security;
alter table public.community_members enable row level security;
alter table public.community_bans enable row level security;
alter table public.messages enable row level security;
alter table public.community_reads enable row level security;
alter table public.clubs enable row level security;
alter table public.club_memberships enable row level security;

create policy "communities: lectura pública" on public.communities for select using (true);
create policy "communities: editan sus administradores" on public.communities
  for update to authenticated using (public.is_entity_admin(entity_id)) with check (public.is_entity_admin(entity_id));
revoke update on public.communities from authenticated;
grant update (name, description, genres, rules, free_benefits, welcome_message) on public.communities to authenticated;

create policy "community_members: la persona ve sus membresías" on public.community_members
  for select to authenticated using (user_id = (select auth.uid()) or public.is_community_admin(community_id));

create policy "community_bans: solo administradores" on public.community_bans
  for select to authenticated using (public.is_community_admin(community_id) or user_id = (select auth.uid()));

create policy "messages: leen miembros y administradores" on public.messages
  for select to authenticated using (
    (channel in ('announcements', 'chat') and (public.is_community_member(community_id) or public.is_community_admin(community_id)))
    or (channel = 'club' and public.has_club_access(community_id))
  );
create policy "messages: escriben según canal" on public.messages
  for insert to authenticated with check (
    author_id = (select auth.uid())
    and deleted_at is null
    and (
      (channel = 'chat' and (public.is_community_member(community_id) or public.is_community_admin(community_id)))
      or (channel = 'announcements' and public.is_community_admin(community_id))
      or (channel = 'club' and public.has_club_access(community_id))
    )
  );
revoke insert, update, delete on public.messages from authenticated;
grant insert (community_id, channel, body, client_id) on public.messages to authenticated;

create policy "community_reads: propias" on public.community_reads
  for select to authenticated using (user_id = (select auth.uid()));

create policy "clubs: vista previa pública" on public.clubs for select using (true);
create policy "clubs: editan los administradores" on public.clubs
  for update to authenticated
  using (public.is_community_admin(community_id)) with check (public.is_community_admin(community_id));
create policy "clubs: crean los administradores" on public.clubs
  for insert to authenticated with check (public.is_community_admin(community_id) and platform_fee_bps = 1000);
revoke update on public.clubs from authenticated;
grant update (name, description, price_cents, billing_interval, benefits, status) on public.clubs to authenticated;

create policy "club_memberships: la propia" on public.club_memberships
  for select to authenticated using (user_id = (select auth.uid()));

-- ---------------------------------------------------------------------------
-- Protección básica frente a spam (se aplica también a administradores)
-- ---------------------------------------------------------------------------
create or replace function public.messages_guard()
returns trigger language plpgsql security definer set search_path = '' as $$
declare
  v_recent int;
  v_last text;
begin
  new.created_at := now();
  new.deleted_at := null;
  new.deleted_by := null;
  new.body := btrim(new.body);

  select count(*) into v_recent from public.messages
  where author_id = new.author_id and created_at > now() - interval '20 seconds';
  if v_recent >= 6 then
    raise exception 'Vas demasiado rápido. Espera unos segundos antes de enviar otro mensaje.' using errcode = 'P0001', hint = 'rate_limited';
  end if;

  select count(*) into v_recent from public.messages
  where author_id = new.author_id and created_at > now() - interval '1 hour';
  if v_recent >= 120 then
    raise exception 'Has alcanzado el límite de mensajes por hora.' using errcode = 'P0001', hint = 'rate_limited';
  end if;

  select body into v_last from public.messages
  where author_id = new.author_id and community_id = new.community_id and channel = new.channel
    and created_at > now() - interval '2 minutes' and deleted_at is null
  order by id desc limit 1;
  if v_last is not null and lower(v_last) = lower(new.body) then
    raise exception 'Ese mensaje ya está enviado.' using errcode = 'P0001', hint = 'duplicate';
  end if;

  if (select count(*) from regexp_matches(new.body, 'https?://', 'g')) > 3 then
    raise exception 'Demasiados enlaces en un mismo mensaje.' using errcode = 'P0001', hint = 'links';
  end if;
  return new;
end;
$$;
create trigger messages_guard before insert on public.messages
  for each row execute function public.messages_guard();

-- ---------------------------------------------------------------------------
-- Operaciones
-- ---------------------------------------------------------------------------
create or replace function public.create_community(
  p_entity uuid, p_name text, p_description text default null,
  p_genres text[] default '{}', p_benefits text[] default '{}'
) returns uuid language plpgsql security definer set search_path = '' as $$
declare
  v_id uuid;
  v_slug text;
  v_n int := 1;
begin
  if not public.is_entity_admin(p_entity) then
    raise exception 'Solo los administradores del perfil pueden crear su comunidad' using errcode = '42501';
  end if;
  v_slug := left(public.slugify(p_name), 60);
  if char_length(v_slug) < 2 then v_slug := 'comunidad-' || v_slug; end if;
  while exists (select 1 from public.communities where slug = v_slug) loop
    v_n := v_n + 1; v_slug := left(public.slugify(p_name), 60) || '-' || v_n;
  end loop;
  insert into public.communities (entity_id, slug, name, description, genres, free_benefits)
  values (p_entity, v_slug, btrim(p_name), p_description, coalesce(p_genres, '{}'), coalesce(p_benefits, '{}'))
  returning id into v_id;
  return v_id;
end;
$$;

create or replace function public.join_community(p_community uuid)
returns boolean language plpgsql security definer set search_path = '' as $$
declare
  v_uid uuid := auth.uid();
begin
  if v_uid is null then raise exception 'Necesitas iniciar sesión' using errcode = '28000'; end if;
  if not exists (select 1 from public.communities where id = p_community) then
    raise exception 'Comunidad no encontrada';
  end if;
  if exists (select 1 from public.community_bans where community_id = p_community and user_id = v_uid) then
    raise exception 'No puedes unirte: la administración de esta comunidad te ha expulsado.' using errcode = '42501';
  end if;
  insert into public.community_members (community_id, user_id) values (p_community, v_uid)
  on conflict do nothing;
  -- Al entrar, el historial anterior no cuenta como "no leído".
  insert into public.community_reads (community_id, user_id, channel, last_read_id)
  select p_community, v_uid, ch, coalesce((select max(id) from public.messages
    where community_id = p_community and channel = ch), 0)
  from unnest(array['announcements', 'chat']::public.message_channel[]) ch
  on conflict do nothing;
  return true;
end;
$$;

create or replace function public.leave_community(p_community uuid)
returns void language plpgsql security definer set search_path = '' as $$
begin
  delete from public.community_members where community_id = p_community and user_id = auth.uid();
  delete from public.community_reads where community_id = p_community and user_id = auth.uid();
end;
$$;

create or replace function public.kick_member(p_community uuid, p_user uuid, p_reason text default null)
returns void language plpgsql security definer set search_path = '' as $$
begin
  if not public.is_community_admin(p_community) then
    raise exception 'Solo la administración puede expulsar' using errcode = '42501';
  end if;
  if exists (select 1 from public.communities c join public.entity_admins a on a.entity_id = c.entity_id
             where c.id = p_community and a.user_id = p_user) then
    raise exception 'No se puede expulsar a un administrador';
  end if;
  delete from public.community_members where community_id = p_community and user_id = p_user;
  delete from public.community_reads where community_id = p_community and user_id = p_user;
  insert into public.community_bans (community_id, user_id, reason, banned_by)
  values (p_community, p_user, p_reason, auth.uid())
  on conflict (community_id, user_id) do update set reason = excluded.reason, banned_by = excluded.banned_by, created_at = now();
end;
$$;

create or replace function public.unban_member(p_community uuid, p_user uuid)
returns void language plpgsql security definer set search_path = '' as $$
begin
  if not public.is_community_admin(p_community) then
    raise exception 'Solo la administración puede readmitir' using errcode = '42501';
  end if;
  delete from public.community_bans where community_id = p_community and user_id = p_user;
end;
$$;

-- Moderación: el autor o la administración retiran un mensaje (queda constancia).
create or replace function public.delete_message(p_message bigint)
returns void language plpgsql security definer set search_path = '' as $$
declare
  v_msg public.messages;
begin
  select * into v_msg from public.messages where id = p_message;
  if v_msg.id is null then raise exception 'Mensaje no encontrado'; end if;
  if v_msg.author_id <> auth.uid() and not public.is_community_admin(v_msg.community_id) then
    raise exception 'No puedes retirar este mensaje' using errcode = '42501';
  end if;
  update public.messages set body = '', deleted_at = now(), deleted_by = auth.uid()
  where id = p_message and deleted_at is null;
end;
$$;

create or replace function public.mark_read(p_community uuid, p_channel public.message_channel, p_last_id bigint)
returns void language plpgsql security definer set search_path = '' as $$
begin
  if not (public.is_community_member(p_community) or public.is_community_admin(p_community)) then return; end if;
  insert into public.community_reads (community_id, user_id, channel, last_read_id, updated_at)
  values (p_community, auth.uid(), p_channel, p_last_id, now())
  on conflict (community_id, user_id, channel)
  do update set last_read_id = greatest(public.community_reads.last_read_id, excluded.last_read_id), updated_at = now();
end;
$$;

create or replace function public.community_member_count(p_community uuid)
returns bigint language sql stable security definer set search_path = '' as $$
  select count(*) from public.community_members where community_id = p_community;
$$;

-- Comunidades de la persona, con mensajes no leídos por canal.
create or replace function public.my_communities()
returns table (
  community_id uuid, slug text, name text, entity_id uuid, entity_name text, entity_kind public.entity_kind,
  is_admin boolean, is_member boolean, unread_chat bigint, unread_announcements bigint, last_message_at timestamptz
) language sql stable security definer set search_path = '' as $$
  with mine as (
    select m.community_id, true as is_member from public.community_members m where m.user_id = auth.uid()
    union
    select c.id, false from public.communities c
    join public.entity_admins a on a.entity_id = c.entity_id
    where a.user_id = auth.uid()
      and not exists (select 1 from public.community_members m2 where m2.community_id = c.id and m2.user_id = auth.uid())
  )
  select c.id, c.slug, c.name, e.id, e.name, e.kind,
    public.is_community_admin(c.id),
    mine.is_member,
    (select count(*) from public.messages msg where msg.community_id = c.id and msg.channel = 'chat'
       and msg.deleted_at is null and msg.author_id <> auth.uid()
       and msg.id > coalesce((select r.last_read_id from public.community_reads r
         where r.community_id = c.id and r.user_id = auth.uid() and r.channel = 'chat'), 0)),
    (select count(*) from public.messages msg where msg.community_id = c.id and msg.channel = 'announcements'
       and msg.deleted_at is null and msg.author_id <> auth.uid()
       and msg.id > coalesce((select r.last_read_id from public.community_reads r
         where r.community_id = c.id and r.user_id = auth.uid() and r.channel = 'announcements'), 0)),
    (select max(msg.created_at) from public.messages msg where msg.community_id = c.id and msg.channel in ('chat', 'announcements'))
  from mine
  join public.communities c on c.id = mine.community_id
  join public.entities e on e.id = c.entity_id
  order by 11 desc nulls last, c.name;
$$;

-- Miembros visibles para la administración (moderación).
create or replace function public.community_members_admin(p_community uuid)
returns table (user_id uuid, display_name text, joined_at timestamptz, message_count bigint, banned boolean)
language sql stable security definer set search_path = '' as $$
  select m.user_id, p.display_name, m.joined_at,
    (select count(*) from public.messages x where x.community_id = p_community and x.author_id = m.user_id),
    false
  from public.community_members m join public.profiles p on p.id = m.user_id
  where m.community_id = p_community and public.is_community_admin(p_community)
  union all
  select b.user_id, p.display_name, b.created_at,
    (select count(*) from public.messages x where x.community_id = p_community and x.author_id = b.user_id),
    true
  from public.community_bans b join public.profiles p on p.id = b.user_id
  where b.community_id = p_community and public.is_community_admin(p_community)
  order by 5, 3 desc;
$$;

-- Realtime: postgres_changes aplica las políticas RLS de SELECT a cada suscriptor.
alter publication supabase_realtime add table public.messages;
alter table public.messages replica identity full;

revoke execute on function public.messages_guard() from public, anon, authenticated;
revoke execute on function public.create_community(uuid, text, text, text[], text[]) from public, anon;
revoke execute on function public.join_community(uuid) from public, anon;
revoke execute on function public.leave_community(uuid) from public, anon;
revoke execute on function public.kick_member(uuid, uuid, text) from public, anon;
revoke execute on function public.unban_member(uuid, uuid) from public, anon;
revoke execute on function public.delete_message(bigint) from public, anon;
revoke execute on function public.mark_read(uuid, public.message_channel, bigint) from public, anon;
revoke execute on function public.my_communities() from public, anon;
