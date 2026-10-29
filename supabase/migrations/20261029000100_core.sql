-- YOU IN? · Núcleo: cuentas, perfiles profesionales (entidades) y permisos.
--
-- Modelo:
--   * Una persona = una fila en auth.users + public.profiles.
--   * DJ, sala y colectivo son "entidades". Un DJ es una entidad cuyo único
--     propietario es la persona que activa su perfil de DJ. Salas y colectivos
--     pueden tener varios administradores (public.entity_admins).
--   * Las entidades importadas (data_origin = 'imported') no tienen
--     administradores y no se pueden editar ni reclamar desde la app.
--   * Los permisos se aplican con RLS y funciones SECURITY DEFINER; la
--     interfaz solo refleja lo que la base de datos permite.

create extension if not exists pgcrypto with schema extensions;
create extension if not exists unaccent with schema extensions;

create type public.entity_kind as enum ('dj', 'venue', 'collective');
create type public.data_origin as enum ('demo', 'imported', 'user');
create type public.entity_admin_role as enum ('owner', 'admin');

-- ---------------------------------------------------------------------------
-- Perfil de usuario
-- ---------------------------------------------------------------------------
create table public.profiles (
  id uuid primary key references auth.users (id) on delete cascade,
  display_name text not null check (char_length(btrim(display_name)) between 1 and 50),
  bio text check (char_length(bio) <= 600),
  avatar_path text,
  favorite_colors jsonb not null default '{}'::jsonb,
  is_demo boolean not null default false,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);
comment on column public.profiles.is_demo is 'Cuenta de prueba sembrada por seed (correo @demo.youin.local).';

create or replace function public.touch_updated_at()
returns trigger language plpgsql set search_path = '' as $$
begin
  new.updated_at := now();
  return new;
end;
$$;

create trigger profiles_touch before update on public.profiles
  for each row execute function public.touch_updated_at();

-- Crea el perfil automáticamente al registrarse.
create or replace function public.handle_new_user()
returns trigger language plpgsql security definer set search_path = '' as $$
declare
  v_name text := nullif(btrim(coalesce(new.raw_user_meta_data ->> 'display_name', '')), '');
begin
  insert into public.profiles (id, display_name, is_demo)
  values (
    new.id,
    left(coalesce(v_name, split_part(coalesce(new.email, 'persona'), '@', 1)), 50),
    coalesce(new.email, '') like '%@demo.youin.local'
  );
  return new;
end;
$$;

create trigger on_auth_user_created after insert on auth.users
  for each row execute function public.handle_new_user();

alter table public.profiles enable row level security;

-- El nombre visible y el avatar son públicos (autoría de mensajes).
create policy "profiles: lectura pública" on public.profiles
  for select using (true);
create policy "profiles: cada persona edita el suyo" on public.profiles
  for update to authenticated using (id = (select auth.uid())) with check (id = (select auth.uid()));

-- Las columnas sensibles no se exponen a otros usuarios: se revoca la lectura
-- de favorite_colors y se ofrece la vista my_profile para el propio usuario.
revoke select on public.profiles from anon, authenticated;
grant select (id, display_name, bio, avatar_path, is_demo, created_at) on public.profiles to anon, authenticated;
grant update (display_name, bio, avatar_path, favorite_colors) on public.profiles to authenticated;

create or replace function public.my_profile()
returns table (id uuid, display_name text, bio text, avatar_path text, favorite_colors jsonb, is_demo boolean, email text)
language sql stable security definer set search_path = '' as $$
  select p.id, p.display_name, p.bio, p.avatar_path, p.favorite_colors, p.is_demo, u.email::text
  from public.profiles p join auth.users u on u.id = p.id
  where p.id = auth.uid();
$$;

-- ---------------------------------------------------------------------------
-- Entidades: DJ, sala, colectivo
-- ---------------------------------------------------------------------------
create table public.entities (
  id uuid primary key default gen_random_uuid(),
  kind public.entity_kind not null,
  slug text not null unique check (slug ~ '^[a-z0-9][a-z0-9-]{1,79}$'),
  name text not null check (char_length(btrim(name)) between 1 and 80),
  tagline text check (char_length(tagline) <= 100),
  bio text check (char_length(bio) <= 1500),
  genres text[] not null default '{}',
  area text,
  municipality text,
  province text check (province in ('Valencia', 'Alicante', 'Castellón')),
  address text check (char_length(address) <= 200),
  lat double precision check (lat between 37.75 and 40.85),
  lng double precision check (lng between -1.6 and 0.65),
  photo_path text,
  cover_path text,
  image_url text check (image_url ~ '^https://'),
  initials text check (char_length(initials) <= 3),
  color text not null default 'peach' check (color in ('peach', 'lilac', 'green', 'yellow')),
  accent text not null default '#765466' check (accent in ('#765466', '#AF4529', '#386B68', '#596597', '#84652D')),
  profile_font text not null default 'Manrope' check (profile_font in ('Manrope', 'DM Sans', 'Georgia')),
  profile_layout text not null default 'editorial' check (profile_layout in ('editorial', 'compact')),
  links jsonb not null default '{}'::jsonb,
  contact_email text check (char_length(contact_email) <= 100),
  contact_phone text check (char_length(contact_phone) <= 30),
  data_origin public.data_origin not null default 'user',
  source_url text check (source_url ~ '^https://'),
  source_key text unique,
  user_id uuid references auth.users (id) on delete cascade,
  created_by uuid references auth.users (id) on delete set null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint entities_dj_has_user check (kind <> 'dj' or data_origin <> 'user' or user_id is not null),
  constraint entities_only_dj_user check (kind = 'dj' or user_id is null)
);
comment on table public.entities is 'Perfiles profesionales. Las filas importadas son referencias informativas sin reclamar.';
comment on column public.entities.user_id is 'Solo para DJ: la persona dueña del perfil artístico.';

-- Una persona tiene como máximo un perfil de DJ.
create unique index entities_one_dj_per_user on public.entities (user_id) where kind = 'dj';
create index entities_kind_idx on public.entities (kind);

create trigger entities_touch before update on public.entities
  for each row execute function public.touch_updated_at();

create table public.entity_admins (
  entity_id uuid not null references public.entities (id) on delete cascade,
  user_id uuid not null references auth.users (id) on delete cascade,
  role public.entity_admin_role not null default 'admin',
  created_at timestamptz not null default now(),
  primary key (entity_id, user_id)
);
create index entity_admins_user_idx on public.entity_admins (user_id);

create or replace function public.is_entity_admin(p_entity uuid)
returns boolean language sql stable security definer set search_path = '' as $$
  select exists (
    select 1 from public.entity_admins a
    join public.entities e on e.id = a.entity_id
    where a.entity_id = p_entity and a.user_id = auth.uid() and e.data_origin <> 'imported'
  );
$$;

create or replace function public.is_entity_owner(p_entity uuid)
returns boolean language sql stable security definer set search_path = '' as $$
  select exists (
    select 1 from public.entity_admins a
    where a.entity_id = p_entity and a.user_id = auth.uid() and a.role = 'owner'
  );
$$;

alter table public.entities enable row level security;
alter table public.entity_admins enable row level security;

create policy "entities: lectura pública" on public.entities for select using (true);
create policy "entities: editan sus administradores" on public.entities
  for update to authenticated
  using (public.is_entity_admin(id))
  with check (public.is_entity_admin(id) and data_origin <> 'imported');
-- No hay política de INSERT ni DELETE directos: se usan las funciones de abajo.

-- Columnas que un administrador puede cambiar (nunca kind, origen, dueño ni fuente).
revoke update on public.entities from authenticated;
grant update (name, tagline, bio, genres, area, municipality, province, address, lat, lng,
  photo_path, cover_path, color, accent, profile_font, profile_layout, links,
  contact_email, contact_phone) on public.entities to authenticated;

create policy "entity_admins: ver los equipos propios" on public.entity_admins
  for select to authenticated
  using (user_id = (select auth.uid()) or public.is_entity_admin(entity_id));

create or replace function public.slugify(p_text text)
returns text language sql immutable set search_path = '' as $$
  select coalesce(nullif(trim(both '-' from regexp_replace(
    lower(extensions.unaccent(coalesce(p_text, ''))), '[^a-z0-9]+', '-', 'g')), ''), 'perfil');
$$;

create or replace function public.unique_entity_slug(p_name text)
returns text language plpgsql set search_path = '' as $$
declare
  v_base text := left(public.slugify(p_name), 60);
  v_slug text := v_base;
  v_n int := 1;
begin
  if char_length(v_base) < 2 then v_base := 'perfil-' || v_base; v_slug := v_base; end if;
  while exists (select 1 from public.entities where slug = v_slug) loop
    v_n := v_n + 1;
    v_slug := v_base || '-' || v_n;
  end loop;
  return v_slug;
end;
$$;

-- Activar el perfil de DJ de la persona autenticada (idempotente).
create or replace function public.activate_dj_profile(p_artist_name text default null)
returns uuid language plpgsql security definer set search_path = '' as $$
declare
  v_uid uuid := auth.uid();
  v_id uuid;
  v_name text;
begin
  if v_uid is null then raise exception 'Necesitas iniciar sesión' using errcode = '28000'; end if;
  select id into v_id from public.entities where user_id = v_uid and kind = 'dj';
  if v_id is not null then return v_id; end if;
  select coalesce(nullif(btrim(p_artist_name), ''), display_name) into v_name from public.profiles where id = v_uid;
  insert into public.entities (kind, slug, name, data_origin, user_id, created_by, initials, color)
  values ('dj', public.unique_entity_slug(v_name), left(v_name, 80), 'user', v_uid, v_uid,
          upper(left(v_name, 2)), 'peach')
  returning id into v_id;
  insert into public.entity_admins (entity_id, user_id, role) values (v_id, v_uid, 'owner');
  return v_id;
end;
$$;

-- Crear una sala o un colectivo administrado por quien lo crea.
create or replace function public.create_organization(
  p_kind public.entity_kind, p_name text, p_bio text default null,
  p_municipality text default 'València', p_province text default 'Valencia',
  p_address text default null, p_lat double precision default null, p_lng double precision default null,
  p_genres text[] default '{}'
)
returns uuid language plpgsql security definer set search_path = '' as $$
declare
  v_uid uuid := auth.uid();
  v_id uuid;
begin
  if v_uid is null then raise exception 'Necesitas iniciar sesión' using errcode = '28000'; end if;
  if p_kind not in ('venue', 'collective') then raise exception 'Solo salas o colectivos'; end if;
  if (select count(*) from public.entity_admins where user_id = v_uid and role = 'owner') >= 20 then
    raise exception 'Has alcanzado el límite de perfiles profesionales';
  end if;
  insert into public.entities (kind, slug, name, bio, municipality, province, address, lat, lng,
    genres, data_origin, created_by, initials, color)
  values (p_kind, public.unique_entity_slug(p_name), btrim(p_name), p_bio, p_municipality, p_province,
    p_address, p_lat, p_lng, coalesce(p_genres, '{}'), 'user', v_uid, upper(left(btrim(p_name), 2)),
    case when p_kind = 'venue' then 'green' else 'yellow' end)
  returning id into v_id;
  insert into public.entity_admins (entity_id, user_id, role) values (v_id, v_uid, 'owner');
  return v_id;
end;
$$;

-- El propietario añade a otra persona registrada como administradora.
create or replace function public.add_entity_admin(p_entity uuid, p_email text)
returns void language plpgsql security definer set search_path = '' as $$
declare
  v_target uuid;
  v_kind public.entity_kind;
begin
  if not public.is_entity_owner(p_entity) then raise exception 'Solo el propietario puede añadir administradores' using errcode = '42501'; end if;
  select kind into v_kind from public.entities where id = p_entity;
  if v_kind = 'dj' then raise exception 'Un perfil de DJ pertenece a una sola persona'; end if;
  select id into v_target from auth.users where lower(email) = lower(btrim(p_email));
  if v_target is null then raise exception 'No existe ninguna cuenta con ese correo'; end if;
  insert into public.entity_admins (entity_id, user_id, role) values (p_entity, v_target, 'admin')
  on conflict do nothing;
end;
$$;

create or replace function public.remove_entity_admin(p_entity uuid, p_user uuid)
returns void language plpgsql security definer set search_path = '' as $$
begin
  if not public.is_entity_owner(p_entity) then raise exception 'Solo el propietario puede quitar administradores' using errcode = '42501'; end if;
  delete from public.entity_admins where entity_id = p_entity and user_id = p_user and role <> 'owner';
end;
$$;

-- Equipo de una entidad, solo visible para sus administradores.
create or replace function public.entity_team(p_entity uuid)
returns table (user_id uuid, display_name text, role public.entity_admin_role, email text)
language sql stable security definer set search_path = '' as $$
  select a.user_id, p.display_name, a.role, u.email::text
  from public.entity_admins a
  join public.profiles p on p.id = a.user_id
  join auth.users u on u.id = a.user_id
  where a.entity_id = p_entity and public.is_entity_admin(p_entity)
  order by a.role, p.display_name;
$$;

revoke execute on function public.handle_new_user() from public, anon, authenticated;
revoke execute on function public.activate_dj_profile(text) from public, anon;
revoke execute on function public.create_organization(public.entity_kind, text, text, text, text, text, double precision, double precision, text[]) from public, anon;
revoke execute on function public.add_entity_admin(uuid, text) from public, anon;
revoke execute on function public.remove_entity_admin(uuid, uuid) from public, anon;
