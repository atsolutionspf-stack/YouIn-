-- YOU IN? · Archivos (carteles, fotos, portadas, vídeos) y métricas del panel.

-- Bucket público de lectura. Cada persona solo escribe en su carpeta <uid>/...
insert into storage.buckets (id, name, public, file_size_limit, allowed_mime_types)
values ('media', 'media', true, 41943040,
  array['image/jpeg', 'image/png', 'image/webp', 'video/mp4', 'video/webm'])
on conflict (id) do nothing;

create policy "media: subir a la carpeta propia" on storage.objects
  for insert to authenticated
  with check (bucket_id = 'media' and (storage.foldername(name))[1] = (select auth.uid())::text);
create policy "media: reemplazar lo propio" on storage.objects
  for update to authenticated
  using (bucket_id = 'media' and owner_id = (select auth.uid())::text)
  with check (bucket_id = 'media' and (storage.foldername(name))[1] = (select auth.uid())::text);
create policy "media: borrar lo propio" on storage.objects
  for delete to authenticated
  using (bucket_id = 'media' and owner_id = (select auth.uid())::text);

-- Métricas calculadas solo con datos existentes. Nada estimado ni inventado.
create or replace function public.entity_dashboard(p_entity uuid)
returns jsonb language plpgsql stable security definer set search_path = '' as $$
declare
  v_community uuid;
  v_result jsonb;
begin
  if not public.is_entity_admin(p_entity) then
    raise exception 'Solo la administración del perfil puede ver sus métricas' using errcode = '42501';
  end if;
  select id into v_community from public.communities where entity_id = p_entity;
  select jsonb_build_object(
    'followers', (select count(*) from public.follows where entity_id = p_entity),
    'upcoming_events', (select count(*) from public.events e where e.status = 'published' and e.ends_at > now()
        and (e.organizer_entity_id = p_entity or e.venue_entity_id = p_entity
             or exists (select 1 from public.event_artists a where a.event_id = e.id and a.entity_id = p_entity))),
    'past_events', (select count(*) from public.events e where e.ends_at <= now()
        and (e.organizer_entity_id = p_entity or e.venue_entity_id = p_entity)),
    'event_saves', (select count(*) from public.favorites f join public.events e on e.id = f.event_id
        where e.organizer_entity_id = p_entity or e.venue_entity_id = p_entity),
    'community_id', v_community,
    'members', (select count(*) from public.community_members where community_id = v_community),
    'members_last_7d', (select count(*) from public.community_members where community_id = v_community and joined_at > now() - interval '7 days'),
    'messages_last_7d', (select count(*) from public.messages where community_id = v_community and created_at > now() - interval '7 days' and deleted_at is null),
    'active_authors_last_7d', (select count(distinct author_id) from public.messages where community_id = v_community and created_at > now() - interval '7 days'),
    'bans', (select count(*) from public.community_bans where community_id = v_community),
    'campaigns', (select count(*) from public.referral_campaigns where community_id = v_community)
  ) into v_result;
  return v_result;
end;
$$;
revoke execute on function public.entity_dashboard(uuid) from public, anon;

-- Entidades que administra la persona.
create or replace function public.my_entities()
returns table (id uuid, kind public.entity_kind, slug text, name text, role public.entity_admin_role, community_id uuid)
language sql stable security definer set search_path = '' as $$
  select e.id, e.kind, e.slug, e.name, a.role, c.id
  from public.entity_admins a
  join public.entities e on e.id = a.entity_id
  left join public.communities c on c.entity_id = e.id
  where a.user_id = auth.uid()
  order by e.kind, e.name;
$$;
revoke execute on function public.my_entities() from public, anon;

-- Restablece las fechas de los eventos de demostración respecto a hoy
-- (para entornos de prueba que lleven días encendidos). Solo service_role.
create or replace function public.refresh_demo_event_dates()
returns integer language plpgsql security definer set search_path = '' as $$
declare
  v_shift interval;
  v_count integer;
begin
  select (date_trunc('day', now() at time zone 'Europe/Madrid') - date_trunc('day', min(starts_at) at time zone 'Europe/Madrid'))
  into v_shift from public.events where data_origin = 'demo';
  if v_shift is null or v_shift <= interval '0' then return 0; end if;
  update public.events set starts_at = starts_at + v_shift, ends_at = ends_at + v_shift where data_origin = 'demo';
  get diagnostics v_count = row_count;
  return v_count;
end;
$$;
revoke execute on function public.refresh_demo_event_dates() from public, anon, authenticated;
grant execute on function public.refresh_demo_event_dates() to service_role;
