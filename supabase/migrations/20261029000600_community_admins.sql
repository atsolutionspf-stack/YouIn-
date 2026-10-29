-- Quién administra una comunidad (para mostrar la etiqueta «Admin» en los mensajes).
-- Solo devuelve identificadores de cuenta; nombres ya son públicos en profiles.
create or replace function public.community_admin_ids(p_community uuid)
returns setof uuid language sql stable security definer set search_path = '' as $$
  select a.user_id from public.communities c
  join public.entity_admins a on a.entity_id = c.entity_id
  where c.id = p_community;
$$;
