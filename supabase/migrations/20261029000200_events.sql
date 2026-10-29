-- YOU IN? · Eventos, menciones a DJs, favoritos, seguimiento e importaciones.

create type public.event_status as enum ('draft', 'published', 'cancelled');
create type public.price_kind as enum ('fixed', 'from', 'conditional-free', 'unknown');

-- Lote de importación puntual: conserva fuente, cobertura y fecha de consulta.
create table public.import_batches (
  id uuid primary key default gen_random_uuid(),
  label text not null,
  revision text not null unique,
  retrieved_at timestamptz not null,
  coverage text not null,
  window_info jsonb not null default '{}'::jsonb,
  stats jsonb not null default '{}'::jsonb,
  automatic_sync boolean not null default false check (automatic_sync = false),
  created_at timestamptz not null default now()
);
comment on table public.import_batches is 'Importaciones puntuales. automatic_sync es siempre false: no hay integración activa.';

-- Proveedores de ticketing conocidos. Ninguno está conectado en esta versión.
create table public.ticketing_providers (
  id text primary key check (id ~ '^[a-z0-9-]+$'),
  name text not null,
  website text check (website ~ '^https://'),
  integration_status text not null default 'not_connected'
    check (integration_status in ('not_connected', 'pending_agreement', 'connected')),
  notes text
);

create table public.events (
  id uuid primary key default gen_random_uuid(),
  title text not null check (char_length(btrim(title)) between 1 and 120),
  description text check (char_length(description) <= 2000),
  starts_at timestamptz not null,
  ends_at timestamptz not null,
  until_late boolean not null default false,
  time_warning text,
  venue_entity_id uuid references public.entities (id) on delete set null,
  venue_name text not null check (char_length(btrim(venue_name)) between 1 and 120),
  room text,
  address text not null check (char_length(btrim(address)) between 1 and 200),
  area text,
  municipality text not null default 'València',
  province text not null default 'Valencia' check (province in ('Valencia', 'Alicante', 'Castellón')),
  -- Sin coordenadas publicadas el evento no aparece en el mapa (nunca se inventan).
  lat double precision check (lat between 37.75 and 40.85),
  lng double precision check (lng between -1.6 and 0.65),
  location_precision text not null default 'organizer-pin'
    check (location_precision in ('organizer-pin', 'source-coordinates', 'unknown')),
  genre text not null default 'Sin clasificar',
  source_genres text[] not null default '{}',
  price numeric(10, 2) check (price is null or price between 0 and 10000),
  price_kind public.price_kind not null default 'fixed',
  price_note text,
  ticket_url text check (ticket_url ~ '^https://'),
  ticket_provider_id text references public.ticketing_providers (id),
  poster_path text,
  poster_url text check (poster_url ~ '^https://'),
  poster_style text not null default 'groove' check (poster_style in ('groove', 'orbita', 'sol', 'onda')),
  video_path text,
  age text,
  organizer_entity_id uuid references public.entities (id) on delete cascade,
  status public.event_status not null default 'published',
  data_origin public.data_origin not null default 'user',
  import_batch_id uuid references public.import_batches (id) on delete cascade,
  source_event_key text unique,
  sources jsonb not null default '[]'::jsonb,
  verified_at timestamptz,
  created_by uuid references auth.users (id) on delete set null,
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now(),
  constraint events_end_after_start check (ends_at > starts_at),
  constraint events_coords_pair check ((lat is null) = (lng is null)),
  constraint events_price_known check (price_kind = 'unknown' or price is not null),
  constraint events_user_has_organizer check (data_origin <> 'user' or organizer_entity_id is not null),
  constraint events_imported_has_batch check (data_origin <> 'imported' or import_batch_id is not null)
);
comment on column public.events.verified_at is 'Fecha de consulta en la fuente (solo importados). No implica que precio o disponibilidad sigan vigentes.';

create index events_time_idx on public.events (ends_at, starts_at) where status = 'published';
create index events_organizer_idx on public.events (organizer_entity_id);
create index events_venue_idx on public.events (venue_entity_id);

create trigger events_touch before update on public.events
  for each row execute function public.touch_updated_at();

-- Menciones: añaden el evento a la agenda del DJ. El DJ puede ocultarlo de su
-- perfil (hidden_by_artist) sin borrar ni alterar el evento original.
create table public.event_artists (
  event_id uuid not null references public.events (id) on delete cascade,
  entity_id uuid not null references public.entities (id) on delete cascade,
  position smallint not null default 0,
  hidden_by_artist boolean not null default false,
  created_at timestamptz not null default now(),
  primary key (event_id, entity_id)
);
create index event_artists_entity_idx on public.event_artists (entity_id);

create or replace function public.can_manage_event(p_event uuid)
returns boolean language sql stable security definer set search_path = '' as $$
  select exists (
    select 1 from public.events e
    where e.id = p_event and e.data_origin <> 'imported'
      and e.organizer_entity_id is not null and public.is_entity_admin(e.organizer_entity_id)
  );
$$;

-- Solo DJs pueden mencionarse.
create or replace function public.check_event_artist()
returns trigger language plpgsql set search_path = '' as $$
begin
  if (select kind from public.entities where id = new.entity_id) <> 'dj' then
    raise exception 'Solo se puede mencionar a perfiles de DJ';
  end if;
  return new;
end;
$$;
create trigger event_artists_check before insert or update of entity_id on public.event_artists
  for each row execute function public.check_event_artist();

alter table public.events enable row level security;
alter table public.event_artists enable row level security;

create policy "events: publicados visibles para todos" on public.events
  for select using (status <> 'draft' or public.can_manage_event(id));
create policy "events: publican administradores de sala o colectivo" on public.events
  for insert to authenticated
  with check (
    data_origin = 'user'
    and organizer_entity_id is not null
    and public.is_entity_admin(organizer_entity_id)
    and (select kind from public.entities where id = organizer_entity_id) in ('venue', 'collective')
    and (venue_entity_id is null or venue_entity_id = organizer_entity_id
         or (select kind from public.entities where id = venue_entity_id) = 'venue')
    and created_by = (select auth.uid())
  );
create policy "events: editan sus organizadores" on public.events
  for update to authenticated
  using (public.can_manage_event(id))
  with check (data_origin = 'user' and public.is_entity_admin(organizer_entity_id));
create policy "events: borran sus organizadores" on public.events
  for delete to authenticated using (public.can_manage_event(id));

revoke update on public.events from authenticated;
grant update (title, description, starts_at, ends_at, until_late, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, genre, price, price_kind, price_note, ticket_url,
  poster_path, poster_style, video_path, age, status) on public.events to authenticated;

create policy "event_artists: lectura pública" on public.event_artists
  for select using (
    exists (select 1 from public.events e where e.id = event_id and (e.status <> 'draft' or public.can_manage_event(e.id)))
  );
create policy "event_artists: el organizador menciona" on public.event_artists
  for insert to authenticated with check (public.can_manage_event(event_id) and hidden_by_artist = false);
create policy "event_artists: el organizador retira menciones" on public.event_artists
  for delete to authenticated using (public.can_manage_event(event_id));
-- El DJ mencionado solo puede cambiar la visibilidad en su propio perfil.
create policy "event_artists: el DJ decide si se ve en su perfil" on public.event_artists
  for update to authenticated
  using (public.is_entity_admin(entity_id))
  with check (public.is_entity_admin(entity_id));
revoke update on public.event_artists from authenticated;
grant update (hidden_by_artist) on public.event_artists to authenticated;

-- ---------------------------------------------------------------------------
-- Favoritos y seguimiento (seguir ≠ unirse a la comunidad)
-- ---------------------------------------------------------------------------
create table public.favorites (
  user_id uuid not null references auth.users (id) on delete cascade,
  event_id uuid not null references public.events (id) on delete cascade,
  created_at timestamptz not null default now(),
  primary key (user_id, event_id)
);
create table public.follows (
  user_id uuid not null references auth.users (id) on delete cascade,
  entity_id uuid not null references public.entities (id) on delete cascade,
  created_at timestamptz not null default now(),
  primary key (user_id, entity_id)
);
create index follows_entity_idx on public.follows (entity_id);
create index favorites_event_idx on public.favorites (event_id);

alter table public.favorites enable row level security;
alter table public.follows enable row level security;

create policy "favorites: privados" on public.favorites
  for select to authenticated using (user_id = (select auth.uid()));
create policy "favorites: añadir los propios" on public.favorites
  for insert to authenticated with check (user_id = (select auth.uid()));
create policy "favorites: quitar los propios" on public.favorites
  for delete to authenticated using (user_id = (select auth.uid()));

create policy "follows: privados" on public.follows
  for select to authenticated using (user_id = (select auth.uid()));
create policy "follows: seguir" on public.follows
  for insert to authenticated with check (user_id = (select auth.uid()));
create policy "follows: dejar de seguir" on public.follows
  for delete to authenticated using (user_id = (select auth.uid()));

-- Recuento público de seguidores (sin exponer quién sigue a quién).
create or replace function public.follower_count(p_entity uuid)
returns bigint language sql stable security definer set search_path = '' as $$
  select count(*) from public.follows where entity_id = p_entity;
$$;

alter table public.import_batches enable row level security;
alter table public.ticketing_providers enable row level security;
create policy "import_batches: lectura pública" on public.import_batches for select using (true);
create policy "ticketing_providers: lectura pública" on public.ticketing_providers for select using (true);

insert into public.ticketing_providers (id, name, website, integration_status, notes) values
  ('fourvenues', 'Fourvenues', 'https://site.fourvenues.com', 'not_connected',
   'Solo enlaces externos e importación puntual de páginas públicas. Integración pendiente de acuerdo y documentación oficial.'),
  ('xceed', 'Xceed', 'https://xceed.me', 'not_connected',
   'Solo enlaces externos e importación puntual de páginas públicas. Integración pendiente de acuerdo y documentación oficial.'),
  ('other', 'Otro vendedor', null, 'not_connected', 'Enlace externo indicado por el organizador.');
