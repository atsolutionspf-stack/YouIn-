-- DATOS DE DEMOSTRACIÓN · ficticios · generados por scripts/build-seed.mjs
-- Cuentas de prueba: correo @demo.youin.local · contraseña común indicada en README.
begin;
insert into auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at,
  raw_app_meta_data, raw_user_meta_data, created_at, updated_at, confirmation_token, recovery_token,
  email_change_token_new, email_change, email_change_token_current, phone_change, phone_change_token, reauthentication_token)
values ('00000000-0000-0000-0000-000000000000', 'ce8ad5eb-058d-523c-956b-3abc253e6ebc', 'authenticated', 'authenticated', 'arena@demo.youin.local',
  extensions.crypt('demo-youin-2026', extensions.gen_salt('bf')), now(),
  '{"provider":"email","providers":["email"]}'::jsonb, '{"display_name":"Marta · House Arena"}'::jsonb, now(), now(), '', '', '', '', '', '', '', '');
insert into auth.identities (id, user_id, provider_id, identity_data, provider, last_sign_in_at, created_at, updated_at)
values ('ce8ad5eb-058d-523c-956b-3abc253e6ebc', 'ce8ad5eb-058d-523c-956b-3abc253e6ebc', 'ce8ad5eb-058d-523c-956b-3abc253e6ebc', '{"sub":"ce8ad5eb-058d-523c-956b-3abc253e6ebc","email":"arena@demo.youin.local","email_verified":true}'::jsonb, 'email', now(), now(), now());
insert into auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at,
  raw_app_meta_data, raw_user_meta_data, created_at, updated_at, confirmation_token, recovery_token,
  email_change_token_new, email_change, email_change_token_current, phone_change, phone_change_token, reauthentication_token)
values ('00000000-0000-0000-0000-000000000000', '39524517-6328-5004-8c17-b94e69446256', 'authenticated', 'authenticated', 'casagroove@demo.youin.local',
  extensions.crypt('demo-youin-2026', extensions.gen_salt('bf')), now(),
  '{"provider":"email","providers":["email"]}'::jsonb, '{"display_name":"Equipo Casa Groove"}'::jsonb, now(), now(), '', '', '', '', '', '', '', '');
insert into auth.identities (id, user_id, provider_id, identity_data, provider, last_sign_in_at, created_at, updated_at)
values ('39524517-6328-5004-8c17-b94e69446256', '39524517-6328-5004-8c17-b94e69446256', '39524517-6328-5004-8c17-b94e69446256', '{"sub":"39524517-6328-5004-8c17-b94e69446256","email":"casagroove@demo.youin.local","email_verified":true}'::jsonb, 'email', now(), now(), now());
insert into auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at,
  raw_app_meta_data, raw_user_meta_data, created_at, updated_at, confirmation_token, recovery_token,
  email_change_token_new, email_change, email_change_token_current, phone_change, phone_change_token, reauthentication_token)
values ('00000000-0000-0000-0000-000000000000', 'b6884d5e-ca8c-5d21-a219-1c381c7c3612', 'authenticated', 'authenticated', 'sala@demo.youin.local',
  extensions.crypt('demo-youin-2026', extensions.gen_salt('bf')), now(),
  '{"provider":"email","providers":["email"]}'::jsonb, '{"display_name":"Equipo Nave 08"}'::jsonb, now(), now(), '', '', '', '', '', '', '', '');
insert into auth.identities (id, user_id, provider_id, identity_data, provider, last_sign_in_at, created_at, updated_at)
values ('b6884d5e-ca8c-5d21-a219-1c381c7c3612', 'b6884d5e-ca8c-5d21-a219-1c381c7c3612', 'b6884d5e-ca8c-5d21-a219-1c381c7c3612', '{"sub":"b6884d5e-ca8c-5d21-a219-1c381c7c3612","email":"sala@demo.youin.local","email_verified":true}'::jsonb, 'email', now(), now(), now());
insert into auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at,
  raw_app_meta_data, raw_user_meta_data, created_at, updated_at, confirmation_token, recovery_token,
  email_change_token_new, email_change, email_change_token_current, phone_change, phone_change_token, reauthentication_token)
values ('00000000-0000-0000-0000-000000000000', 'e25b05be-e651-5997-b9f8-4f8fab7a1ee3', 'authenticated', 'authenticated', 'luna@demo.youin.local',
  extensions.crypt('demo-youin-2026', extensions.gen_salt('bf')), now(),
  '{"provider":"email","providers":["email"]}'::jsonb, '{"display_name":"Luna Serra"}'::jsonb, now(), now(), '', '', '', '', '', '', '', '');
insert into auth.identities (id, user_id, provider_id, identity_data, provider, last_sign_in_at, created_at, updated_at)
values ('e25b05be-e651-5997-b9f8-4f8fab7a1ee3', 'e25b05be-e651-5997-b9f8-4f8fab7a1ee3', 'e25b05be-e651-5997-b9f8-4f8fab7a1ee3', '{"sub":"e25b05be-e651-5997-b9f8-4f8fab7a1ee3","email":"luna@demo.youin.local","email_verified":true}'::jsonb, 'email', now(), now(), now());
insert into auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at,
  raw_app_meta_data, raw_user_meta_data, created_at, updated_at, confirmation_token, recovery_token,
  email_change_token_new, email_change, email_change_token_current, phone_change, phone_change_token, reauthentication_token)
values ('00000000-0000-0000-0000-000000000000', 'b1f51c6f-18f8-5d34-aaa3-b7db1dc57bbf', 'authenticated', 'authenticated', 'nico@demo.youin.local',
  extensions.crypt('demo-youin-2026', extensions.gen_salt('bf')), now(),
  '{"provider":"email","providers":["email"]}'::jsonb, '{"display_name":"Nico Vela"}'::jsonb, now(), now(), '', '', '', '', '', '', '', '');
insert into auth.identities (id, user_id, provider_id, identity_data, provider, last_sign_in_at, created_at, updated_at)
values ('b1f51c6f-18f8-5d34-aaa3-b7db1dc57bbf', 'b1f51c6f-18f8-5d34-aaa3-b7db1dc57bbf', 'b1f51c6f-18f8-5d34-aaa3-b7db1dc57bbf', '{"sub":"b1f51c6f-18f8-5d34-aaa3-b7db1dc57bbf","email":"nico@demo.youin.local","email_verified":true}'::jsonb, 'email', now(), now(), now());
insert into auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at,
  raw_app_meta_data, raw_user_meta_data, created_at, updated_at, confirmation_token, recovery_token,
  email_change_token_new, email_change, email_change_token_current, phone_change, phone_change_token, reauthentication_token)
values ('00000000-0000-0000-0000-000000000000', '07db3d2f-3298-503c-ae87-952a4efe6b20', 'authenticated', 'authenticated', 'ana@demo.youin.local',
  extensions.crypt('demo-youin-2026', extensions.gen_salt('bf')), now(),
  '{"provider":"email","providers":["email"]}'::jsonb, '{"display_name":"Ana"}'::jsonb, now(), now(), '', '', '', '', '', '', '', '');
insert into auth.identities (id, user_id, provider_id, identity_data, provider, last_sign_in_at, created_at, updated_at)
values ('07db3d2f-3298-503c-ae87-952a4efe6b20', '07db3d2f-3298-503c-ae87-952a4efe6b20', '07db3d2f-3298-503c-ae87-952a4efe6b20', '{"sub":"07db3d2f-3298-503c-ae87-952a4efe6b20","email":"ana@demo.youin.local","email_verified":true}'::jsonb, 'email', now(), now(), now());
insert into auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at,
  raw_app_meta_data, raw_user_meta_data, created_at, updated_at, confirmation_token, recovery_token,
  email_change_token_new, email_change, email_change_token_current, phone_change, phone_change_token, reauthentication_token)
values ('00000000-0000-0000-0000-000000000000', 'd3c34344-8bf2-515a-a09e-a3b00e70ea98', 'authenticated', 'authenticated', 'leo@demo.youin.local',
  extensions.crypt('demo-youin-2026', extensions.gen_salt('bf')), now(),
  '{"provider":"email","providers":["email"]}'::jsonb, '{"display_name":"Leo"}'::jsonb, now(), now(), '', '', '', '', '', '', '', '');
insert into auth.identities (id, user_id, provider_id, identity_data, provider, last_sign_in_at, created_at, updated_at)
values ('d3c34344-8bf2-515a-a09e-a3b00e70ea98', 'd3c34344-8bf2-515a-a09e-a3b00e70ea98', 'd3c34344-8bf2-515a-a09e-a3b00e70ea98', '{"sub":"d3c34344-8bf2-515a-a09e-a3b00e70ea98","email":"leo@demo.youin.local","email_verified":true}'::jsonb, 'email', now(), now(), now());
insert into public.entities (id, kind, slug, name, tagline, bio, genres, area, municipality, province, address, lat, lng,
  initials, color, accent, profile_font, links, data_origin, user_id)
values ('dcc26238-5b7f-56eb-8d71-80e96dd16cb5', 'dj', 'luna-serra', 'Luna Serra', 'El groove también se siente como casa', 'Bajos cálidos, discos que cuentan historias y una pista donde cabemos todos. Desde Valencia, con groove. (Perfil de demostración)', array['House', 'Disco']::text[], 'Valencia',
  'València', 'Valencia', null, null, null,
  'LS', 'peach', '#AF4529', 'Manrope', '{}'::jsonb, 'demo', 'e25b05be-e651-5997-b9f8-4f8fab7a1ee3');
insert into public.entity_admins (entity_id, user_id, role) values ('dcc26238-5b7f-56eb-8d71-80e96dd16cb5', 'e25b05be-e651-5997-b9f8-4f8fab7a1ee3', 'owner');
insert into public.entities (id, kind, slug, name, tagline, bio, genres, area, municipality, province, address, lat, lng,
  initials, color, accent, profile_font, links, data_origin, user_id)
values ('bb736a16-f121-5996-ad5c-1d5d02e68ba8', 'dj', 'nico-vela', 'Nico Vela', 'Hasta el último bombo', 'Viajes nocturnos entre el techno hipnótico y la electrónica de club. (Perfil de demostración)', array['Techno', 'Electro']::text[], 'Valencia',
  'València', 'Valencia', null, null, null,
  'NV', 'lilac', '#596597', 'Manrope', '{}'::jsonb, 'demo', 'b1f51c6f-18f8-5d34-aaa3-b7db1dc57bbf');
insert into public.entity_admins (entity_id, user_id, role) values ('bb736a16-f121-5996-ad5c-1d5d02e68ba8', 'b1f51c6f-18f8-5d34-aaa3-b7db1dc57bbf', 'owner');
insert into public.entities (id, kind, slug, name, tagline, bio, genres, area, municipality, province, address, lat, lng,
  initials, color, accent, profile_font, links, data_origin, user_id)
values ('dd0ec6a5-e3be-5e44-8242-53e21f7d2347', 'venue', 'el-patio-club', 'El Patio Club', null, 'Un patio, buena música y ganas de encontrarnos. Una sala imaginaria para probar YOU IN?.', array['House', 'Disco']::text[], 'Russafa',
  'València', 'Valencia', 'Zona de Russafa, Valencia · ubicación de ejemplo', 39.4628, -0.3753,
  'EP', 'green', '#765466', 'Manrope', '{}'::jsonb, 'demo', null);
insert into public.entity_admins (entity_id, user_id, role) values ('dd0ec6a5-e3be-5e44-8242-53e21f7d2347', '39524517-6328-5004-8c17-b94e69446256', 'owner');
insert into public.entities (id, kind, slug, name, tagline, bio, genres, area, municipality, province, address, lat, lng,
  initials, color, accent, profile_font, links, data_origin, user_id)
values ('b5883021-bd2e-5047-b1e5-12a387ed5512', 'venue', 'nave-08', 'Nave 08', null, 'Sonido cuidado y noches largas en el distrito marítimo. Sala de demostración.', array['Techno']::text[], 'El Grau',
  'València', 'Valencia', 'Zona de El Grau, Valencia · ubicación de ejemplo', 39.4561, -0.3372,
  '08', 'lilac', '#765466', 'Manrope', '{}'::jsonb, 'demo', null);
insert into public.entity_admins (entity_id, user_id, role) values ('b5883021-bd2e-5047-b1e5-12a387ed5512', 'b6884d5e-ca8c-5d21-a219-1c381c7c3612', 'owner');
insert into public.entities (id, kind, slug, name, tagline, bio, genres, area, municipality, province, address, lat, lng,
  initials, color, accent, profile_font, links, data_origin, user_id)
values ('b31147f0-1f81-5955-a2e2-67a624e5ad6e', 'collective', 'casa-groove', 'Casa Groove', null, 'La casa es la pista. Encuentros de house hechos por gente que vive la música. (Colectivo de demostración)', array['House', 'Disco']::text[], 'Valencia',
  'València', 'Valencia', null, null, null,
  'CG', 'yellow', '#765466', 'Manrope', '{}'::jsonb, 'demo', null);
insert into public.entity_admins (entity_id, user_id, role) values ('b31147f0-1f81-5955-a2e2-67a624e5ad6e', '39524517-6328-5004-8c17-b94e69446256', 'owner');
insert into public.entities (id, kind, slug, name, tagline, bio, genres, area, municipality, province, address, lat, lng,
  initials, color, accent, profile_font, links, data_origin, user_id)
values ('6a784ff6-e86f-5318-b7e6-5ba032289ee0', 'collective', 'onda-libre', 'Onda Libre', null, 'Ritmos que nos juntan, del directo a la última canción. (Colectivo de demostración)', array['Reggaetón', 'En directo']::text[], 'Valencia',
  'València', 'Valencia', null, null, null,
  'OL', 'peach', '#765466', 'Manrope', '{}'::jsonb, 'demo', null);
insert into public.entity_admins (entity_id, user_id, role) values ('6a784ff6-e86f-5318-b7e6-5ba032289ee0', 'b6884d5e-ca8c-5d21-a219-1c381c7c3612', 'owner');
insert into public.entities (id, kind, slug, name, tagline, bio, genres, area, municipality, province, address, lat, lng,
  initials, color, accent, profile_font, links, data_origin, user_id)
values ('2a5c8b20-032c-5530-b1b8-228d6fbd5aa9', 'collective', 'house-arena-demo', 'House Arena (demo)', 'Trae a tu gente, la pista te lo devuelve', 'Comunidad de demostración para probar enlaces personales, entradas referidas e invitaciones. No es una promotora real ni vende entradas.', array['House']::text[], 'Valencia',
  'València', 'Valencia', null, null, null,
  'HA', 'yellow', '#84652D', 'Manrope', '{}'::jsonb, 'demo', null);
insert into public.entity_admins (entity_id, user_id, role) values ('2a5c8b20-032c-5530-b1b8-228d6fbd5aa9', 'ce8ad5eb-058d-523c-956b-3abc253e6ebc', 'owner');
insert into public.communities (id, entity_id, slug, name, description, genres, free_benefits, welcome_message, rules, is_demo)
values ('9eba6c0a-fe3c-5ce3-a06b-849f7afdd0ed', 'b31147f0-1f81-5955-a2e2-67a624e5ad6e', 'la-casa-del-groove', 'La casa del groove', 'Discos que descubrimos, planes que compartimos y gente con quien bailar.', array['House', 'Disco']::text[],
  array['Sesiones compartidas por la comunidad', 'Avisos de próximas fiestas']::text[], '¡Bienvenidos a la casa! ¿Qué disco no puede faltar en vuestra próxima noche?', 'Respeto, cero spam y mucha música.', true);
insert into public.clubs (community_id, name, description, price_cents, billing_interval, benefits, status)
values ('9eba6c0a-fe3c-5ce3-a06b-849f7afdd0ed', 'Club Casa Groove', 'Espacio de pago separado de la comunidad gratuita.', 400, 'month', array['Preventa de eventos', 'Encuentros con artistas']::text[], 'preview');
insert into public.community_members (community_id, user_id) values ('9eba6c0a-fe3c-5ce3-a06b-849f7afdd0ed', '07db3d2f-3298-503c-ae87-952a4efe6b20');
insert into public.messages (community_id, channel, author_id, body, created_at)
values ('9eba6c0a-fe3c-5ce3-a06b-849f7afdd0ed', 'announcements', '39524517-6328-5004-8c17-b94e69446256', '¡Bienvenidos a la casa! ¿Qué disco no puede faltar en vuestra próxima noche? (mensaje de demostración)', now());
insert into public.communities (id, entity_id, slug, name, description, genres, free_benefits, welcome_message, rules, is_demo)
values ('79072065-94cc-5b92-890c-0c01bfcf1688', 'bb736a16-f121-5996-ad5c-1d5d02e68ba8', 'bajo-la-superficie', 'Bajo la superficie', 'Un lugar para quienes se quedan hasta el último bombo.', array['Techno', 'Electro']::text[],
  array['Novedades de sesiones', 'Conversaciones sobre música']::text[], 'Hoy compartimos sonidos de madrugada. ¿Qué estáis escuchando?', null, true);
insert into public.clubs (community_id, name, description, price_cents, billing_interval, benefits, status)
values ('79072065-94cc-5b92-890c-0c01bfcf1688', 'Club Bajo la superficie', 'Espacio de pago separado.', 300, 'month', array['Sesiones exclusivas', 'Acceso a encuentros privados']::text[], 'preview');
insert into public.messages (community_id, channel, author_id, body, created_at)
values ('79072065-94cc-5b92-890c-0c01bfcf1688', 'announcements', 'b1f51c6f-18f8-5d34-aaa3-b7db1dc57bbf', 'Hoy compartimos sonidos de madrugada. ¿Qué estáis escuchando? (mensaje de demostración)', now());
insert into public.communities (id, entity_id, slug, name, description, genres, free_benefits, welcome_message, rules, is_demo)
values ('4b2d58b4-168b-573e-96b2-4349e00c967c', '6a784ff6-e86f-5318-b7e6-5ba032289ee0', 'en-la-misma-onda', 'En la misma onda', 'Más ritmos, más encuentros. Tu gente antes y después del evento.', array['Reggaetón', 'En directo']::text[],
  array['Agenda de la comunidad', 'Recomendaciones musicales']::text[], 'Este es nuestro punto de encuentro. ¡Comparte tu próximo plan!', null, true);
insert into public.clubs (community_id, name, description, price_cents, billing_interval, benefits, status)
values ('4b2d58b4-168b-573e-96b2-4349e00c967c', 'Club Onda Libre', 'Espacio de pago separado.', 250, 'month', array['Ventajas elegidas por el colectivo']::text[], 'preview');
insert into public.messages (community_id, channel, author_id, body, created_at)
values ('4b2d58b4-168b-573e-96b2-4349e00c967c', 'announcements', 'b6884d5e-ca8c-5d21-a219-1c381c7c3612', 'Este es nuestro punto de encuentro. ¡Comparte tu próximo plan! (mensaje de demostración)', now());
insert into public.communities (id, entity_id, slug, name, description, genres, free_benefits, welcome_message, rules, is_demo)
values ('6ae1fbff-6ec9-5b8a-9676-453854d8b513', '2a5c8b20-032c-5530-b1b8-228d6fbd5aa9', 'house-arena', 'House Arena (demo)', 'Comunidad de demostración para probar referidos: comparte tu enlace, suma entradas válidas y consigue invitaciones.', array['House']::text[],
  array['Enlace personal de invitación', 'Seguimiento de tus entradas referidas', 'Invitaciones por objetivos']::text[], 'Comparte tu enlace personal. Desde 5 entradas válidas tienes tu invitación.', 'Las compras de esta comunidad son simuladas. Ninguna entrada es real.', true);
insert into public.clubs (community_id, name, description, price_cents, billing_interval, benefits, status)
values ('6ae1fbff-6ec9-5b8a-9676-453854d8b513', 'House Arena Club', 'Vista previa del club de pago (sin cobros).', 500, 'month', array['Preventa', 'Acceso prioritario', 'Encuentros con artistas']::text[], 'preview');
insert into public.messages (community_id, channel, author_id, body, created_at)
values ('6ae1fbff-6ec9-5b8a-9676-453854d8b513', 'announcements', 'ce8ad5eb-058d-523c-956b-3abc253e6ebc', 'Arranca la campaña de invitaciones de prueba. Consulta tu enlace en «Recompensas». (mensaje de demostración)', now());
insert into public.events (id, title, description, starts_at, ends_at, venue_entity_id, venue_name, address, area, municipality,
  province, lat, lng, location_precision, genre, price, price_kind, ticket_url, poster_style, organizer_entity_id, status, data_origin)
values ('0ccb59bd-fb78-5d07-ba1b-b7fdadb00975', 'Una noche en casa', 'House cálido, selecciones de disco y esa sensación de estar en el lugar correcto. Evento de demostración.', ((date_trunc('day', now() at time zone 'Europe/Madrid') + interval '0 days' + time '22:00') at time zone 'Europe/Madrid'), ((date_trunc('day', now() at time zone 'Europe/Madrid') + interval '1 days' + time '05:00') at time zone 'Europe/Madrid'),
  'dd0ec6a5-e3be-5e44-8242-53e21f7d2347', 'El Patio Club', 'Zona de Russafa, Valencia · ubicación de ejemplo', 'Russafa',
  'València', 'Valencia', 39.4628, -0.3753, 'organizer-pin',
  'House', 12, 'fixed', null, 'groove', 'b31147f0-1f81-5955-a2e2-67a624e5ad6e', 'published', 'demo');
insert into public.event_artists (event_id, entity_id, position) values ('0ccb59bd-fb78-5d07-ba1b-b7fdadb00975', 'dcc26238-5b7f-56eb-8d71-80e96dd16cb5', 0);
insert into public.events (id, title, description, starts_at, ends_at, venue_entity_id, venue_name, address, area, municipality,
  province, lat, lng, location_precision, genre, price, price_kind, ticket_url, poster_style, organizer_entity_id, status, data_origin)
values ('3db3fab3-3a0c-5593-9ca4-7ff019f74734', 'Órbita 004', 'Deja la ciudad fuera. Una exploración del techno más profundo, del primer pulso al amanecer. Evento de demostración.', ((date_trunc('day', now() at time zone 'Europe/Madrid') + interval '0 days' + time '23:30') at time zone 'Europe/Madrid'), ((date_trunc('day', now() at time zone 'Europe/Madrid') + interval '1 days' + time '06:00') at time zone 'Europe/Madrid'),
  'b5883021-bd2e-5047-b1e5-12a387ed5512', 'Nave 08', 'Zona de El Grau, Valencia · ubicación de ejemplo', 'El Grau',
  'València', 'Valencia', 39.4561, -0.3372, 'organizer-pin',
  'Techno', 18, 'fixed', null, 'orbita', 'b5883021-bd2e-5047-b1e5-12a387ed5512', 'published', 'demo');
insert into public.event_artists (event_id, entity_id, position) values ('3db3fab3-3a0c-5593-9ca4-7ff019f74734', 'bb736a16-f121-5996-ad5c-1d5d02e68ba8', 0);
insert into public.events (id, title, description, starts_at, ends_at, venue_entity_id, venue_name, address, area, municipality,
  province, lat, lng, location_precision, genre, price, price_kind, ticket_url, poster_style, organizer_entity_id, status, data_origin)
values ('a58a3727-6800-587e-adbd-6d83877c55f1', 'Discos al sol', 'Una fiesta de tarde con discos, amigos y mucho espacio para bailar. Evento de demostración.', ((date_trunc('day', now() at time zone 'Europe/Madrid') + interval '2 days' + time '17:00') at time zone 'Europe/Madrid'), ((date_trunc('day', now() at time zone 'Europe/Madrid') + interval '2 days' + time '23:00') at time zone 'Europe/Madrid'),
  null, 'Jardín del Ritmo', 'Zona de Benimaclet, Valencia · ubicación de ejemplo', 'Benimaclet',
  'València', 'Valencia', 39.4845, -0.3612, 'organizer-pin',
  'Disco', 0, 'fixed', null, 'sol', 'b31147f0-1f81-5955-a2e2-67a624e5ad6e', 'published', 'demo');
insert into public.event_artists (event_id, entity_id, position) values ('a58a3727-6800-587e-adbd-6d83877c55f1', 'dcc26238-5b7f-56eb-8d71-80e96dd16cb5', 0);
insert into public.events (id, title, description, starts_at, ends_at, venue_entity_id, venue_name, address, area, municipality,
  province, lat, lng, location_precision, genre, price, price_kind, ticket_url, poster_style, organizer_entity_id, status, data_origin)
values ('a573dccc-df89-5832-b814-fdefae878dd5', 'Fuera de frecuencia', 'Un encuentro entre voces nuevas y ritmos que conoces. Evento de demostración.', ((date_trunc('day', now() at time zone 'Europe/Madrid') + interval '3 days' + time '20:00') at time zone 'Europe/Madrid'), ((date_trunc('day', now() at time zone 'Europe/Madrid') + interval '4 days' + time '01:00') at time zone 'Europe/Madrid'),
  null, 'Espacio Onda', 'Zona de Ciutat Vella, Valencia · ubicación de ejemplo', 'Ciutat Vella',
  'València', 'Valencia', 39.4782, -0.382, 'organizer-pin',
  'En directo', 10, 'fixed', null, 'onda', '6a784ff6-e86f-5318-b7e6-5ba032289ee0', 'published', 'demo');
insert into public.events (id, title, description, starts_at, ends_at, venue_entity_id, venue_name, address, area, municipality,
  province, lat, lng, location_precision, genre, price, price_kind, ticket_url, poster_style, organizer_entity_id, status, data_origin)
values ('8f6cbce7-1c5e-553c-a723-fbd2fb7498fb', 'Ritmo compartido', 'Una noche abierta a todos los ritmos. Evento de demostración.', ((date_trunc('day', now() at time zone 'Europe/Madrid') + interval '1 days' + time '23:00') at time zone 'Europe/Madrid'), ((date_trunc('day', now() at time zone 'Europe/Madrid') + interval '2 days' + time '05:00') at time zone 'Europe/Madrid'),
  null, 'Espacio Onda', 'Zona de Ciutat Vella, Valencia · ubicación de ejemplo', 'Ciutat Vella',
  'València', 'Valencia', 39.4782, -0.382, 'organizer-pin',
  'Reggaetón', 8, 'fixed', null, 'onda', '6a784ff6-e86f-5318-b7e6-5ba032289ee0', 'published', 'demo');
insert into public.events (id, title, description, starts_at, ends_at, venue_entity_id, venue_name, address, area, municipality,
  province, lat, lng, location_precision, genre, price, price_kind, ticket_url, poster_style, organizer_entity_id, status, data_origin)
values ('fb915892-4468-5d2a-82cf-bc8cc8341f53', 'Tarde entre olas', 'Evento ficticio para explorar el mapa regional. No es una fiesta real.', ((date_trunc('day', now() at time zone 'Europe/Madrid') + interval '1 days' + time '22:00') at time zone 'Europe/Madrid'), ((date_trunc('day', now() at time zone 'Europe/Madrid') + interval '2 days' + time '05:00') at time zone 'Europe/Madrid'),
  null, 'Espacio de prueba · Alicante', 'Ubicación de demostración en Alicante', 'Centro · ejemplo',
  'Alicante', 'Alicante', 38.346, -0.49, 'organizer-pin',
  'House', 12, 'fixed', null, 'groove', 'b31147f0-1f81-5955-a2e2-67a624e5ad6e', 'published', 'demo');
insert into public.event_artists (event_id, entity_id, position) values ('fb915892-4468-5d2a-82cf-bc8cc8341f53', 'dcc26238-5b7f-56eb-8d71-80e96dd16cb5', 0);
insert into public.events (id, title, description, starts_at, ends_at, venue_entity_id, venue_name, address, area, municipality,
  province, lat, lng, location_precision, genre, price, price_kind, ticket_url, poster_style, organizer_entity_id, status, data_origin)
values ('dfda0277-cbbd-521a-b0c3-9c7b71a645cb', 'Frecuencia norte', 'Evento ficticio para explorar el mapa regional. No es una fiesta real.', ((date_trunc('day', now() at time zone 'Europe/Madrid') + interval '2 days' + time '22:00') at time zone 'Europe/Madrid'), ((date_trunc('day', now() at time zone 'Europe/Madrid') + interval '3 days' + time '05:00') at time zone 'Europe/Madrid'),
  null, 'Espacio de prueba · Castelló de la Plana', 'Ubicación de demostración en Castelló de la Plana', 'Centro · ejemplo',
  'Castelló de la Plana', 'Castellón', 39.986, -0.051, 'organizer-pin',
  'Techno', 12, 'fixed', null, 'orbita', 'b5883021-bd2e-5047-b1e5-12a387ed5512', 'published', 'demo');
insert into public.event_artists (event_id, entity_id, position) values ('dfda0277-cbbd-521a-b0c3-9c7b71a645cb', 'bb736a16-f121-5996-ad5c-1d5d02e68ba8', 0);
insert into public.events (id, title, description, starts_at, ends_at, venue_entity_id, venue_name, address, area, municipality,
  province, lat, lng, location_precision, genre, price, price_kind, ticket_url, poster_style, organizer_entity_id, status, data_origin)
values ('07d5aded-3136-599f-827e-b3b520498af9', 'Groove de la huerta', 'Evento ficticio para explorar el mapa regional. No es una fiesta real.', ((date_trunc('day', now() at time zone 'Europe/Madrid') + interval '3 days' + time '22:00') at time zone 'Europe/Madrid'), ((date_trunc('day', now() at time zone 'Europe/Madrid') + interval '4 days' + time '05:00') at time zone 'Europe/Madrid'),
  null, 'Espacio de prueba · Alboraia', 'Ubicación de demostración en Alboraia', 'Centro · ejemplo',
  'Alboraia', 'Valencia', 39.5, -0.349, 'organizer-pin',
  'Disco', 12, 'fixed', null, 'sol', 'b31147f0-1f81-5955-a2e2-67a624e5ad6e', 'published', 'demo');
insert into public.event_artists (event_id, entity_id, position) values ('07d5aded-3136-599f-827e-b3b520498af9', 'dcc26238-5b7f-56eb-8d71-80e96dd16cb5', 0);
insert into public.events (id, title, description, starts_at, ends_at, venue_entity_id, venue_name, address, area, municipality,
  province, lat, lng, location_precision, genre, price, price_kind, ticket_url, poster_style, organizer_entity_id, status, data_origin)
values ('aa529cf0-a50e-516c-b2b1-6e423a63963b', 'House Arena · Noche de prueba', 'Evento de demostración vinculado a la campaña de referidos de House Arena. No hay entradas reales a la venta.', ((date_trunc('day', now() at time zone 'Europe/Madrid') + interval '9 days' + time '23:00') at time zone 'Europe/Madrid'), ((date_trunc('day', now() at time zone 'Europe/Madrid') + interval '10 days' + time '06:00') at time zone 'Europe/Madrid'),
  'dd0ec6a5-e3be-5e44-8242-53e21f7d2347', 'El Patio Club', 'Zona de Russafa, Valencia · ubicación de ejemplo', 'Russafa',
  'València', 'Valencia', 39.4628, -0.3753, 'organizer-pin',
  'House', 15, 'fixed', null, 'groove', '2a5c8b20-032c-5530-b1b8-228d6fbd5aa9', 'published', 'demo');
insert into public.event_artists (event_id, entity_id, position) values ('aa529cf0-a50e-516c-b2b1-6e423a63963b', 'dcc26238-5b7f-56eb-8d71-80e96dd16cb5', 0);
insert into public.referral_campaigns (id, community_id, event_id, name, description, mode, status, starts_at, ends_at, is_demo, created_by)
values ('352997e3-a61e-53aa-a753-5bcf8ae7bf19', '6ae1fbff-6ec9-5b8a-9676-453854d8b513', 'aa529cf0-a50e-516c-b2b1-6e423a63963b',
  'Trae a tu gente · House Arena', 'Comparte tu enlace personal. Desde 5 entradas válidas consigues tu invitación; a partir de 10, una adicional por cada bloque de 10.', 'simulation', 'active', now() - interval '1 day', ((date_trunc('day', now() at time zone 'Europe/Madrid') + interval '9 days' + time '23:59') at time zone 'Europe/Madrid'), true,
  'ce8ad5eb-058d-523c-956b-3abc253e6ebc');
insert into public.campaign_rules (campaign_id, version, base_threshold, step_size, max_extra, conditions, created_by)
values ('352997e3-a61e-53aa-a753-5bcf8ae7bf19', 1, 5, 10, null, 'Solo cuentan entradas válidas (no clics ni pedidos). Los reembolsos y cancelaciones restan. Campaña de simulación: ninguna compra es real.', 'ce8ad5eb-058d-523c-956b-3abc253e6ebc');
commit;
