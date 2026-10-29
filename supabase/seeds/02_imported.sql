-- IMPORTACIÓN PUNTUAL del piloto (You-in-piloto-4.html) · NO es una integración activa.
-- Consulta: 2026-10-19T08:31:12.206Z · revisión aed267ae18e75f · 119 eventos.
begin;
insert into public.import_batches (id, label, revision, retrieved_at, coverage, window_info, stats, automatic_sync)
values ('ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'Eventos anunciados en Fourvenues, Marina Beach Club y Xceed', 'aed267ae18e75f', '2026-10-19T08:31:12.206Z',
  'Importación puntual de páginas públicas accesibles y sus fichas enlazadas; no garantiza el inventario completo de las plataformas ni eventos aún no publicados.', '{"from":"2026-10-19","through":"2026-12-31","start":"2026-10-18T22:00:00Z","endExclusive":"2026-12-31T23:00:00Z","timezone":"Europe/Madrid","radiusKm":50,"center":{"lat":39.47,"lng":-0.376}}'::jsonb, '{"total":119,"byProvider":{"fourvenues":77,"xceed":42},"duplicatesRemoved":76,"unknownPrices":6,"withoutCoordinates":0,"sourcePages":["https://marinabeachclub.com/calendario-eventos/","https://xceed.me/es/valencia/events","https://site.fourvenues.com/es/nightlife-valencia"]}'::jsonb, false);
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('dc75fbbf-4710-5740-ab6c-520120ae0d33', 'venue', 'rumbo-144', 'Rumbo 144', 'Referencia informativa de la programación pública. Este perfil no ha sido registrado ni reclamado por la sala en You In.', '{}'::text[], 'València', 'València',
  'Valencia', 'Avenida Blasco Ibáñez, 144, 46022 Valencia (Valencia), España', 39.47245, -0.3447, 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/8154c4fc-0360-4da3-3819-e19fdb946e00/w=100,h=100',
  'RU', 'peach', 'imported', 'https://site.fourvenues.com/es/rumbo144', 'pilot:venue-import-0b01101005b667');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('b748dfd3-edda-57df-b4d2-0b5736191f04', 'venue', 'veles-e-vents', 'VELES E VENTS', 'Referencia informativa de la programación pública. Este perfil no ha sido registrado ni reclamado por la sala en You In.', '{}'::text[], 'València', 'València',
  'Valencia', 'Edificio Veles e Vents La Marina de València, 46024 València, Valencia, España', 39.4608845, -0.3240626, 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/dd82d019-1483-44a2-72ed-b9a4b97ab000/w=100,h=100',
  'VE', 'peach', 'imported', 'https://site.fourvenues.com/es/veles-e-vents-eventos', 'pilot:venue-import-88e049f8354997');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('91f2ebc6-3c7a-520c-a2d9-037b7d469d68', 'venue', 'havana-valencia', 'Havana Valencia', 'Referencia informativa de la programación pública. Este perfil no ha sido registrado ni reclamado por la sala en You In.', '{}'::text[], 'València', 'València',
  'Valencia', 'Plaza Cánovas del Castillo, 6, 46005 Valencia (Valencia), España', 39.46783, -0.36564, 'https://d72sklgi05fbu.cloudfront.net/images/venues/logo/tjzwj5j3v000ugfmvno4e9pko8cOnHX3.png?versionId=gwsdOBRK8PazHqRDQM4pJ501wvZM6bN_',
  'HA', 'peach', 'imported', 'https://site.fourvenues.com/es/havana-canovas', 'pilot:venue-import-269454f023dfde');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('726aaac7-561a-5edd-a55d-78f78013af54', 'venue', 'marina-beach-club', 'Marina Beach Club', 'Referencia informativa de la programación pública. Este perfil no ha sido registrado ni reclamado por la sala en You In.', '{}'::text[], 'València', 'València',
  'Valencia', 'C. Marina Real Juan Carlos I, s/n, 46011 Valencia, España', 39.4629916, -0.3216705, 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/c06f3425-65be-4270-8335-f830e234e500/w=100,h=100',
  'MA', 'peach', 'imported', 'https://site.fourvenues.com/es/marina-beach-club', 'pilot:venue-import-cfdaa3e299bb90');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('85d20105-2d60-5581-a35f-aede6e416dbc', 'venue', 'barraca', 'Barraca', 'Referencia informativa de la programación pública. Este perfil no ha sido registrado ni reclamado por la sala en You In.', '{}'::text[], 'Sueca', 'València',
  'Valencia', 'Calle Les Palmeres, Sueca, Valencia', 39.254649, -0.26666, 'https://images.xceed.me/clubs/covers/barraca-club-valencia-xceed-a47c.jpg',
  'BA', 'peach', 'imported', 'https://xceed.me/es/valencia/venue/barraca', 'pilot:venue-import-99040ce0305c36');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('1ea3f9fb-60bd-545f-ba3e-63cacf23edbf', 'dj', 'lilly-palmer', 'Lilly Palmer', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['swiss techno']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/lilly-palmer-artist-xceed-cover-7732.jpg',
  'LI', 'lilac', 'imported', 'https://xceed.me/es/artist/lilly-palmer', 'pilot:artist-import-248d973172b20a');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('81700985-74c9-5933-adc1-be7d1f51d9b0', 'dj', 'elena-megi', 'Elena Megi', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/elena-megi-artist-xceed-cover-a7d3.jpg',
  'EL', 'lilac', 'imported', 'https://xceed.me/es/artist/elena-megi', 'pilot:artist-import-fada97cc0975da');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('cbe949b0-364d-5edf-a75d-8aab698e3a41', 'venue', 'spook-club', 'Spook Club', 'Referencia informativa de la programación pública. Este perfil no ha sido registrado ni reclamado por la sala en You In.', '{}'::text[], 'València', 'València',
  'Valencia', 'Carretera del Rio, 399, Pinedo', 39.410901, -0.33605499999999, 'https://images.xceed.me/clubs/covers/spook-club-club-valencia-xceed-2233.png',
  'SP', 'peach', 'imported', 'https://xceed.me/es/valencia/venue/spook-club', 'pilot:venue-import-5e5fe409577f2f');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('4e747646-e5a3-5606-9d18-328c38ae89f6', 'dj', 'mark-with-a-k', 'Mark with a K', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['hardstyle · hardcore · frenchcore']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/mark-with-a-k-artist-xceed-cover-42b7.jpg',
  'MA', 'lilac', 'imported', 'https://xceed.me/es/artist/mark-with-a-k', 'pilot:artist-import-0cd2db4f31030c');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('b38bea1f-3eff-5bf6-bcda-02e5310d5a05', 'dj', 'mc-chucky', 'MC Chucky', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/mc-chucky-artist-xceed-cover-7853.jpg',
  'MC', 'lilac', 'imported', 'https://xceed.me/es/artist/mc-chucky', 'pilot:artist-import-8d138701f7e394');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('4f5b8aff-27ae-57fd-a685-c229330f3e3b', 'dj', 'gpf-greazy-puzzy-fuckerz', 'GPF - Greazy Puzzy Fuckerz', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/gpf-greazy-puzzy-fuckerz-artist-xceed-cover-136a.jpg',
  'GP', 'lilac', 'imported', 'https://xceed.me/es/artist/gpf-greazy-puzzy-fuckerz', 'pilot:artist-import-e4b2e33f05fc45');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('ce532ebf-992e-56da-b8d0-27afbdc0827a', 'dj', 'dr-donk', 'DR Donk', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['frenchcore · hardcore · hardstyle · speedcore · hardcore techno · gabber']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/dr-donk-1-artist-xceed-cover-1106.jpg',
  'DR', 'lilac', 'imported', 'https://xceed.me/es/artist/dr-donk-1', 'pilot:artist-import-2880f3b0c95cd2');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('1ca0f06c-2805-5814-a6a1-9aae0e545eaf', 'dj', 'tommyknocker', 'Tommyknocker', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/tommyknocker-artist-xceed-cover-37ee.jpg',
  'TO', 'lilac', 'imported', 'https://xceed.me/es/artist/tommyknocker', 'pilot:artist-import-af60df1ed602e1');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('12938f7d-b5e7-53c7-a866-6717c7554fd5', 'dj', 'amygdala', 'Amygdala', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['tekno · techno']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/amygdala-1-artist-xceed-cover-02d7.jpg',
  'AM', 'lilac', 'imported', 'https://xceed.me/es/artist/amygdala-1', 'pilot:artist-import-9c220dd2b1ed05');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('4b91c672-8be2-5cab-83d9-7c8a96fb42b2', 'dj', 'abel-k-kana', 'Abel K'' Kaña', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['hardcore techno · hardcore · tekno · hard house']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/abel-k-kana-1-artist-xceed-cover-1303.jpg',
  'AB', 'lilac', 'imported', 'https://xceed.me/es/artist/abel-k-kana-1', 'pilot:artist-import-db1cbb67bacc78');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('fd6a0f8c-8342-5e12-b470-2a3267c7e9f4', 'dj', 'kcho', 'Kcho', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/kcho-artist-xceed-cover-7259.jpg',
  'KC', 'lilac', 'imported', 'https://xceed.me/es/artist/kcho', 'pilot:artist-import-5129da84d83151');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('fe71e859-f403-50d1-8be6-fed44fc9106a', 'dj', 'norimaki', 'Norimaki', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/norimaki-artist-xceed-cover-3541.jpg',
  'NO', 'lilac', 'imported', 'https://xceed.me/es/artist/norimaki', 'pilot:artist-import-9add22ec08314b');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('7a05b721-01ac-5d52-bd68-bfb0be26e6da', 'dj', 'kali-tek', 'Kali Tek', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/kali-tek-1-artist-xceed-cover-7890.jpg',
  'KA', 'lilac', 'imported', 'https://xceed.me/es/artist/kali-tek-1', 'pilot:artist-import-3060ca6ae4eace');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('aaf902d3-c546-5bd6-8ca9-7f66dcaaeb38', 'dj', 'hardsuel', 'Hardsuel', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/hardsuel-artist-xceed-cover-dab2.jpg',
  'HA', 'lilac', 'imported', 'https://xceed.me/es/artist/hardsuel', 'pilot:artist-import-429e9216841f0a');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('535351f8-2ece-5f4f-a395-d7c1c3ae7ce9', 'dj', 'raul-b', 'Raul B', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/raul-b-1-artist-xceed-cover-9fcf.jpg',
  'RA', 'lilac', 'imported', 'https://xceed.me/es/artist/raul-b-1', 'pilot:artist-import-85b392147037f6');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('d23f7dd7-fe8d-50c0-b606-d3ab2309ee82', 'dj', 'hermanos-kapiya', 'Hermanos Kapiya', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['tekno · hardcore · hardcore techno · techno']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/hermanos-kapiya-artist-xceed-cover-31f9.jpg',
  'HE', 'lilac', 'imported', 'https://xceed.me/es/artist/hermanos-kapiya', 'pilot:artist-import-e07a9c9ed34dd5');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('90cc4922-1d68-5b9e-9df8-766aa865ad2f', 'dj', 'dvrk-oktopus', 'Dvrk Oktopus', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/dvrk-oktopus-artist-xceed-cover-7d4c.jpg',
  'DV', 'lilac', 'imported', 'https://xceed.me/es/artist/dvrk-oktopus', 'pilot:artist-import-cca8e8a017254a');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('89882fd6-b8e0-5a6f-99db-8023782c41a3', 'dj', 'lia-jensen', 'Lia Jensen', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/lia-jensen-1-artist-xceed-cover-a49e.jpg',
  'LI', 'lilac', 'imported', 'https://xceed.me/es/artist/lia-jensen-1', 'pilot:artist-import-72ab0f5f772e92');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('3ad47757-769f-554e-9e88-844af81c14a6', 'dj', 'lemur', 'Lemur', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/lemur-artist-xceed-cover-58e9.jpg',
  'LE', 'lilac', 'imported', 'https://xceed.me/es/artist/lemur', 'pilot:artist-import-44a3899107fdb2');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('54d54317-8b2a-5917-b0c9-846eeff96215', 'dj', 'vdk', 'VDK', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/vdk-1-artist-xceed-cover-ef53.jpg',
  'VD', 'lilac', 'imported', 'https://xceed.me/es/artist/vdk-1', 'pilot:artist-import-26b301b9f84eb6');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('716bd3fa-a498-51d5-8dce-6e5ecda1176f', 'dj', 'ogalla', 'Ogalla', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/ogalla-artist-xceed-cover-ca53.jpg',
  'OG', 'lilac', 'imported', 'https://xceed.me/es/artist/ogalla', 'pilot:artist-import-e8412c954e2a86');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('cacaa8a9-7056-5f9c-a077-dc8a0f1d5c9a', 'dj', 'juanma', 'Juanma', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['hardcore · gabber · hardcore techno']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/juanma-1-artist-xceed-cover-8484.jpg',
  'JU', 'lilac', 'imported', 'https://xceed.me/es/artist/juanma-1', 'pilot:artist-import-2b8509a4fa61c2');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('3e5a39ae-0cb9-50ca-9a5a-92a2dc4155dd', 'dj', 'dr-evil', 'DR Evil', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/dr-evil-2-artist-xceed-cover-0f1b.jpg',
  'DR', 'lilac', 'imported', 'https://xceed.me/es/artist/dr-evil-2', 'pilot:artist-import-7ef0fff8042c8b');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('a742a47b-1647-5e2a-a894-33cf9c11460f', 'dj', 'papero', 'Papero', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['tekno · hardcore']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/papero-1-artist-xceed-cover-0545.jpg',
  'PA', 'lilac', 'imported', 'https://xceed.me/es/artist/papero-1', 'pilot:artist-import-25a0060edf3b11');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('ded32f77-5cd0-589d-b395-35b40fe64f29', 'venue', 'mucho', 'MUCHO', 'Referencia informativa de la programación pública. Este perfil no ha sido registrado ni reclamado por la sala en You In.', '{}'::text[], 'València', 'València',
  'Valencia', 'Carrer de Martí, 4', 39.4655443, -0.37091799999996, 'https://images.xceed.me/clubs/covers/mucho-club-valencia-xceed-6fc7.jpg',
  'MU', 'peach', 'imported', 'https://xceed.me/es/valencia/venue/mucho', 'pilot:venue-import-68faa687ba9a09');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('074cb32b-b2e1-58ad-a650-568910faca86', 'venue', 'sound-factory', 'Sound Factory', 'Referencia informativa de la programación pública. Este perfil no ha sido registrado ni reclamado por la sala en You In.', '{}'::text[], 'València', 'València',
  'Valencia', 'Carrera del Riu, 399', 39.4105911, -0.3351692, 'https://images.xceed.me/clubs/covers/sound-factory-club-valencia-xceed-d1cd.jpg',
  'SO', 'peach', 'imported', 'https://xceed.me/es/valencia/venue/sound-factory', 'pilot:venue-import-7a46581c351f3d');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('1ac304f6-6b70-5593-ac53-18885ed43b6d', 'dj', 'a-n-i', 'A.N.I.', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/ani-1-artist-xceed-cover-1871.jpg',
  'A.', 'lilac', 'imported', 'https://xceed.me/es/artist/ani-1', 'pilot:artist-import-a062761c141d6d');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('f0edcc13-6afc-5f78-8802-4fa58d0c1cee', 'dj', 'cassie-raptor', 'Cassie Raptor', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/cassie-raptor-artist-xceed-cover-f72b.jpg',
  'CA', 'lilac', 'imported', 'https://xceed.me/es/artist/cassie-raptor', 'pilot:artist-import-e40ce822aeb054');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('ca35afc1-6d19-5c38-9bf5-e041583f5ee1', 'dj', 'dyen', 'DYEN', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['industrial techno · techno rave']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/dyen-artist-xceed-cover-7c53.jpg',
  'DY', 'lilac', 'imported', 'https://xceed.me/es/artist/dyen', 'pilot:artist-import-2cd5225fcbd4f1');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('4a6c9ea1-2b18-5b76-ae6b-c88744df661e', 'dj', 'sugarfree', 'Sugarfree', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/static/entities/artist-place-holder.jpg',
  'SU', 'lilac', 'imported', 'https://xceed.me/es/artist/sugarfree', 'pilot:artist-import-01a99ebfc3c6e4');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('40b5dc2b-ff20-586c-8831-cd822b2de717', 'dj', 'laia', 'LAIA', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/laia-1-artist-xceed-cover-ac37.jpg',
  'LA', 'lilac', 'imported', 'https://xceed.me/es/artist/laia-1', 'pilot:artist-import-ea6cc889716840');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('fb58c7b1-61f3-5b0e-af44-27e795285cde', 'dj', 'ines-isla', 'Inés Isla', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/static/entities/artist-place-holder.jpg',
  'IN', 'lilac', 'imported', 'https://xceed.me/es/artist/ines-isla', 'pilot:artist-import-55535d5ceabd38');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('a8c34e8a-e323-5250-a66a-e6ebb9ff0bf9', 'dj', 'boranimals', 'Boranimals', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/boranimals-artist-xceed-cover-a468.jpg',
  'BO', 'lilac', 'imported', 'https://xceed.me/es/artist/boranimals', 'pilot:artist-import-2540c7587bbf87');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('89a5bea0-c7cb-5f69-840e-7c7480723b9e', 'dj', 'christian-merino', 'Christian Merino', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/static/entities/artist-place-holder.jpg',
  'CH', 'lilac', 'imported', 'https://xceed.me/es/artist/christian-merino', 'pilot:artist-import-385a3c0da26cfb');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('2be7d40d-bd36-543e-9ed7-b3f8d11fd15a', 'dj', 'domen', 'Domen', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/domen-artist-xceed-cover-abea.jpg',
  'DO', 'lilac', 'imported', 'https://xceed.me/es/artist/domen', 'pilot:artist-import-1bad316737fd7c');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('2d8f5d1d-db5c-5735-989b-e11e80fbf59d', 'dj', 'fino-fino', 'fino fino', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/fino-fino-artist-xceed-cover-4530.jpg',
  'FI', 'lilac', 'imported', 'https://xceed.me/es/artist/fino-fino', 'pilot:artist-import-e7daeeea44ac84');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('bb27b34a-2f6d-5f0d-ad62-c96b502095f0', 'dj', 'goalmaker', 'Goalmaker', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/goalmaker-artist-xceed-cover-0c4e.jpg',
  'GO', 'lilac', 'imported', 'https://xceed.me/es/artist/goalmaker', 'pilot:artist-import-87836d774bc3fa');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('3171c5a6-5684-55ca-9b56-3b0b495b4c59', 'dj', 'hearthug', 'HearThuG', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['acid house']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/hearthug-1-artist-xceed-cover-fffd.jpg',
  'HE', 'lilac', 'imported', 'https://xceed.me/es/artist/hearthug-1', 'pilot:artist-import-26d84746c31d62');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('4ccfef75-16ab-522d-a3b9-6529f109dc94', 'dj', 'javi-palermo', 'Javi Palermo', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/static/entities/artist-place-holder.jpg',
  'JA', 'lilac', 'imported', 'https://xceed.me/es/artist/javi-palermo', 'pilot:artist-import-a01cd6f51900f4');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('842a2cfa-7210-50db-aa2c-30b0c883628b', 'dj', 'josep-llop', 'Josep Llop', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/josep-llop-artist-xceed-cover-067b.jpg',
  'JO', 'lilac', 'imported', 'https://xceed.me/es/artist/josep-llop', 'pilot:artist-import-e76020034a3110');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('92d75c1f-8808-5d6a-adac-94f3c5cad9a0', 'dj', 'lazystep', 'Lazystep', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/static/entities/artist-place-holder.jpg',
  'LA', 'lilac', 'imported', 'https://xceed.me/es/artist/lazystep', 'pilot:artist-import-a7e27c69ab9f16');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('f1e8ba91-1d93-53bd-970a-4c4b61aa2035', 'dj', 'lucas-cabello', 'Lucas Cabello', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/lucas-cabello-artist-xceed-cover-62f5.jpg',
  'LU', 'lilac', 'imported', 'https://xceed.me/es/artist/lucas-cabello', 'pilot:artist-import-b13dc5110872bc');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('103fe896-1718-56c5-bda8-c745b25287ba', 'dj', 'muvement', 'Muvement', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/static/entities/artist-place-holder.jpg',
  'MU', 'lilac', 'imported', 'https://xceed.me/es/artist/muvement', 'pilot:artist-import-781d5ee6e15481');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('6ceefd11-cd3f-59fe-a6b9-9aac18acd348', 'dj', 'nate-cabrera', 'Nate Cabrera', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/nate-cabrera-artist-xceed-cover-dbac.jpg',
  'NA', 'lilac', 'imported', 'https://xceed.me/es/artist/nate-cabrera', 'pilot:artist-import-44349b2fe44fea');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('69e12d48-9832-5efd-95cf-3b0498cc8c7f', 'dj', 'nativo-live', 'Nativo Live', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/static/entities/artist-place-holder.jpg',
  'NA', 'lilac', 'imported', 'https://xceed.me/es/artist/nativo-live', 'pilot:artist-import-7212863f0c7e6f');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('e2a1578e-5714-551d-b3d5-24a052ba308c', 'dj', 'perc', 'Perc', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['minimal dub']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/perc-artist-xceed-cover-ed57.jpg',
  'PE', 'lilac', 'imported', 'https://xceed.me/es/artist/perc', 'pilot:artist-import-113a1bb1ae7574');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('ce9bc856-c52c-5eb9-9fb6-985066389943', 'dj', 'retiro-electronico', 'Retiro Electrónico', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/static/entities/artist-place-holder.jpg',
  'RE', 'lilac', 'imported', 'https://xceed.me/es/artist/retiro-electronico', 'pilot:artist-import-b2997e45ec9179');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('d6a87e3f-59a8-55c8-85a4-ddd50d5ebb74', 'dj', 'sou-allen', 'Sou Allen', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/sou-allen-artist-xceed-cover-65bb.jpg',
  'SO', 'lilac', 'imported', 'https://xceed.me/es/artist/sou-allen', 'pilot:artist-import-17b33529ae3084');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('f1acca12-1364-5a62-98ae-3dad4fbe682e', 'dj', 'stefano-andriezzi', 'Stefano Andriezzi', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/stefano-andriezzi-artist-xceed-cover-e559.jpg',
  'ST', 'lilac', 'imported', 'https://xceed.me/es/artist/stefano-andriezzi', 'pilot:artist-import-40fd46e19feaa6');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('710bb82a-cb36-503d-b410-5de207d7727b', 'dj', 'stella-fiore', 'stella fiore', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/static/entities/artist-place-holder.jpg',
  'ST', 'lilac', 'imported', 'https://xceed.me/es/artist/stella-fiore', 'pilot:artist-import-febdd561134226');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('4cce3d20-feb9-5e78-91e3-b77c7a0643a6', 'dj', 'whatever-charles', 'Whatever Charles', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/whatever-charles-artist-xceed-cover-c1b9.jpg',
  'WH', 'lilac', 'imported', 'https://xceed.me/es/artist/whatever-charles', 'pilot:artist-import-bacd6a00b7651c');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('8d8e38cc-90fb-545b-a9d7-52ce337c1f46', 'dj', 'future-666', 'Future.666', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/future666-artist-xceed-cover-43e7.jpg',
  'FU', 'lilac', 'imported', 'https://xceed.me/es/artist/future666', 'pilot:artist-import-5dced2609f826b');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('16a96edd-801d-5038-a01e-592a0a8eedab', 'dj', 'fenim0re', 'FENIM0RE', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['techno']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/fenim0re-artist-xceed-cover-68d2.jpg',
  'FE', 'lilac', 'imported', 'https://xceed.me/es/artist/fenim0re', 'pilot:artist-import-0f0f58e1f7711d');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('feacc8e2-bb9d-5ea3-9f71-ff6f05eea834', 'dj', 'bixbita', 'Bixbita', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/bixbita-artist-xceed-cover-bdc7.jpg',
  'BI', 'lilac', 'imported', 'https://xceed.me/es/artist/bixbita', 'pilot:artist-import-218039bc816da5');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('64225be8-2c65-5020-b316-0a77deed07ac', 'dj', 'hector-oaks', 'Héctor Oaks', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['techno · acid techno · hard techno']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/hector-oaks-artist-xceed-cover-aa68.jpg',
  'HÉ', 'lilac', 'imported', 'https://xceed.me/es/artist/hector-oaks', 'pilot:artist-import-8c8cd1ae461683');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('f72316e4-b058-500e-87c9-e06869f186ab', 'dj', 'egyptian-lover', 'Egyptian Lover', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['miami bass · old school hip hop · electro']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/egyptian-lover-artist-xceed-cover-e8b4.jpg',
  'EG', 'lilac', 'imported', 'https://xceed.me/es/artist/egyptian-lover', 'pilot:artist-import-a1a12ea2c6e40c');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('b7da4801-6aab-5db7-8a78-deaf38e45623', 'dj', 'vendex', 'Vendex', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['hard techno · techno · acid techno · industrial · tekno']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/vendex-1-artist-xceed-cover-ea9c.jpg',
  'VE', 'lilac', 'imported', 'https://xceed.me/es/artist/vendex-1', 'pilot:artist-import-9677ca72203aed');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('ef5bdee4-fbf6-5a4c-936c-37051d5abc6b', 'dj', 'm8nse', 'm8nse', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/static/entities/artist-place-holder.jpg',
  'M8', 'lilac', 'imported', 'https://xceed.me/es/artist/m8nse', 'pilot:artist-import-56000ffecea579');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('aff81e43-b778-537b-b711-de48358f8aba', 'dj', 'onlynumbers', 'Onlynumbers', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['techno rave']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/onlynumbers-artist-xceed-cover-0956.jpg',
  'ON', 'lilac', 'imported', 'https://xceed.me/es/artist/onlynumbers', 'pilot:artist-import-53dc7b8453e44d');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('ef7d7dce-0627-5d93-bf85-8cd5747ba851', 'dj', 'richie-hawtin', 'Richie Hawtin', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['acid house · detroit techno · microhouse · minimal techno · tech house · techno']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/richie-hawtin-artist-xceed-cover-ac1f.jpg',
  'RI', 'lilac', 'imported', 'https://xceed.me/es/artist/richie-hawtin', 'pilot:artist-import-a28250261bd396');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('e38ff22a-414d-505a-8151-b9d97186869f', 'dj', 'unai-trotti', 'Unai Trotti', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/unai-trotti-artist-xceed-cover-8e3f.jpg',
  'UN', 'lilac', 'imported', 'https://xceed.me/es/artist/unai-trotti', 'pilot:artist-import-f7668e2ee1a6df');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('d92928f1-5f3b-5d43-a03b-d62591ef5e12', 'venue', 'cocoa-beach-club', 'Cocoa Beach Club', 'Referencia informativa de la programación pública. Este perfil no ha sido registrado ni reclamado por la sala en You In.', '{}'::text[], 'Sagunt', 'València',
  'Valencia', 'Av. Mediterraneo, 44 Puerto De Sagunto', 39.6601318, -0.21153419999996, 'https://images.xceed.me/clubs/covers/cocoa-beach-club-club-valencia-xceed-ca84.jpg',
  'CO', 'peach', 'imported', 'https://xceed.me/es/valencia/venue/cocoa-beach-club', 'pilot:venue-import-1ba078b9ac2a81');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('3618cea4-5a50-53a2-803d-a95a3cd04084', 'venue', 'picca', 'PICCA', 'Referencia informativa de la programación pública. Este perfil no ha sido registrado ni reclamado por la sala en You In.', '{}'::text[], 'València', 'València',
  'Valencia', 'Carrer dels Tomassos, 14', 39.461619, -0.37232700000004, 'https://images.xceed.me/clubs/covers/picca-club-valencia-xceed-53ed.jpg',
  'PI', 'peach', 'imported', 'https://xceed.me/es/valencia/venue/picca', 'pilot:venue-import-9435eb285c8cec');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('14cc8db0-b58b-5966-8862-e70a320fab36', 'dj', 'cristian-varela', 'Cristian Varela', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['techno']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/cristian-varela-artist-xceed-cover-ba2b.jpg',
  'CR', 'lilac', 'imported', 'https://xceed.me/es/artist/cristian-varela', 'pilot:artist-import-cea704e8521885');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('ff0901d6-747b-540e-8dee-d1232bdf19c3', 'dj', 'dj-pepo', 'Dj Pepo', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/dj-pepo-artist-xceed-cover-98f2.jpg',
  'DJ', 'lilac', 'imported', 'https://xceed.me/es/artist/dj-pepo', 'pilot:artist-import-974e63377fef0d');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('3b708a01-87d9-5829-ad72-b123a9669368', 'venue', 'roto-club', 'ROTO CLUB', 'Referencia informativa de la programación pública. Este perfil no ha sido registrado ni reclamado por la sala en You In.', '{}'::text[], 'València', 'València',
  'Valencia', 'Av. d''Ausiàs March, 18', 39.454988, -0.3748483, 'https://images.xceed.me/clubs/covers/roto-club-1-club-valencia-xceed-b486.jpg',
  'RO', 'peach', 'imported', 'https://xceed.me/es/valencia/venue/roto-club-1', 'pilot:venue-import-add0320bf95782');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('e9b3283e-58bf-5395-a6a3-0b1bfb3328d1', 'dj', 'tkmami', 'Tkmami', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/tkmami-artist-xceed-cover-3f7c.jpg',
  'TK', 'lilac', 'imported', 'https://xceed.me/es/artist/tkmami', 'pilot:artist-import-d9017a7be3bf96');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('aa61166b-6f78-5bb6-b9d2-2aa6a129fe91', 'dj', 'aft3er-life', 'Aft3er Life', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/static/entities/artist-place-holder.jpg',
  'AF', 'lilac', 'imported', 'https://xceed.me/es/artist/aft3er-life', 'pilot:artist-import-c9d4aa71938639');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('817c6ccc-bc99-5529-b4be-bf883240e963', 'dj', 'chzter', 'CHZTER', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['neoperreo · reggaeton mexa']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/chzter-artist-xceed-cover-d32d.jpg',
  'CH', 'lilac', 'imported', 'https://xceed.me/es/artist/chzter', 'pilot:artist-import-de4118af98ec8f');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('5c448e67-fa17-54e1-af10-fcb8f7a6f696', 'dj', 'disobey', 'disobey', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/disobey-artist-xceed-cover-015e.jpg',
  'DI', 'lilac', 'imported', 'https://xceed.me/es/artist/disobey', 'pilot:artist-import-8df27322f4ef1d');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('21c922b1-4544-5e4d-8290-2be9968ee916', 'dj', 'roomtrash', 'Roomtrash', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/roomtrash-artist-xceed-cover-5b3e.jpg',
  'RO', 'lilac', 'imported', 'https://xceed.me/es/artist/roomtrash', 'pilot:artist-import-c7d0e494d75d3c');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('3054c44b-27fc-5108-970d-bb78a087fb94', 'venue', 'latex-club', 'Latex Club', 'Referencia informativa de la programación pública. Este perfil no ha sido registrado ni reclamado por la sala en You In.', '{}'::text[], 'València', 'València',
  'Valencia', 'Carlos Cervera, 23', 39.4615073, -0.3727169, 'https://images.xceed.me/clubs/covers/latex-club-club-valencia-xceed-a7ae.jpg',
  'LA', 'peach', 'imported', 'https://xceed.me/es/valencia/venue/latex-club', 'pilot:venue-import-60e5f258a91a88');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('9f967428-1d45-565d-ad58-d9f65a8604ee', 'venue', 'la3', 'La3', 'Referencia informativa de la programación pública. Este perfil no ha sido registrado ni reclamado por la sala en You In.', '{}'::text[], 'València', 'València',
  'Valencia', 'Avenida Blasco Ibanez 111', 39.473577, -0.34458459999996, 'https://images.xceed.me/clubs/covers/la3-club-valencia-xceed-3613.png',
  'LA', 'peach', 'imported', 'https://xceed.me/es/valencia/venue/la3', 'pilot:venue-import-9cd5426f0809db');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('086d9781-3463-531e-8e33-96792e9bb4c2', 'dj', 'tuti', 'tuti', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/static/entities/artist-place-holder.jpg',
  'TU', 'lilac', 'imported', 'https://xceed.me/es/artist/tuti', 'pilot:artist-import-0f625d8ca5ca61');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('e561a33b-218d-5fc8-a8b8-ef21b116f795', 'dj', '17beats', '17beats', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/17beats-1-artist-xceed-cover-dd9b.jpg',
  '17', 'lilac', 'imported', 'https://xceed.me/es/artist/17beats-1', 'pilot:artist-import-b13d7616b7d1d5');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('6bbedc6e-0ab2-5657-9392-d026d3a8a0dc', 'dj', 'cencii', 'Cencii', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/static/entities/artist-place-holder.jpg',
  'CE', 'lilac', 'imported', 'https://xceed.me/es/artist/cencii', 'pilot:artist-import-003f4cb1742e2f');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('e5713117-3b02-578c-966f-32173fb440b9', 'venue', 'multispook', 'Multispook', 'Referencia informativa de la programación pública. Este perfil no ha sido registrado ni reclamado por la sala en You In.', '{}'::text[], 'València', 'València',
  'Valencia', 'Carr. del Río, 399, Poblados del Sur, 46012', 39.4105911, -0.3351692, 'https://images.xceed.me/clubs/covers/multispook-club-valencia-xceed-0382.jpg',
  'MU', 'peach', 'imported', 'https://xceed.me/es/valencia/venue/multispook', 'pilot:venue-import-7ffab4b772cafa');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('122d2c78-1462-57c5-af56-2e099bc3ee31', 'venue', 'oven-club', 'Oven Club', 'Referencia informativa de la programación pública. Este perfil no ha sido registrado ni reclamado por la sala en You In.', '{}'::text[], 'València', 'València',
  'Valencia', 'Gran Via de les Germanies, 31', 39.4637314, -0.37599309999996, 'https://images.xceed.me/clubs/covers/oven-club-centro-club-valencia-xceed-a3ae.jpg',
  'OV', 'peach', 'imported', 'https://xceed.me/es/valencia/venue/oven-club', 'pilot:venue-import-4908abbcc9666d');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('258c3ba4-fb0d-5980-ac34-b92ff9ee893a', 'venue', 'roig-arena', 'Roig Arena', 'Referencia informativa de la programación pública. Este perfil no ha sido registrado ni reclamado por la sala en You In.', '{}'::text[], 'València', 'València',
  'Valencia', 'C/ del Bomber Ramon Duart, 12, Quatre Carreres, 46013', 39.4490862, -0.3642708, 'https://images.xceed.me/clubs/covers/roig-arena-club-valencia-xceed-1174.png',
  'RO', 'peach', 'imported', 'https://xceed.me/es/valencia/venue/roig-arena', 'pilot:venue-import-cc40f206e9c989');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('e8474119-02f7-5273-8bc1-48caa65a9c0f', 'dj', 'folamour', 'Folamour', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['deep house · disco house · electronica · indie soul · jazz house · lo-fi house']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/folamour-artist-xceed-cover-7ef3.jpg',
  'FO', 'lilac', 'imported', 'https://xceed.me/es/artist/folamour', 'pilot:artist-import-75329019113efe');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('ca7fc685-71b8-53b8-86f3-37bb9cd0afa9', 'dj', 'dan-shake', 'Dan Shake', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['float house']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/dan-shake-artist-xceed-cover-6c53.jpg',
  'DA', 'lilac', 'imported', 'https://xceed.me/es/artist/dan-shake', 'pilot:artist-import-e11d9ab6f1cbb2');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('e46bd73e-bf76-54d2-a91c-e46bdf894ddc', 'dj', 'demi-riquisimo', 'Demi Riquisimo', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['acid house · disco house']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/demi-riquisimo-1-artist-xceed-cover-2d9c.jpg',
  'DE', 'lilac', 'imported', 'https://xceed.me/es/artist/demi-riquisimo-1', 'pilot:artist-import-a775be01049faf');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('c6c1d288-52cb-5511-80d0-67421473ae05', 'dj', 'derali', 'Derali', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/derali-artist-xceed-cover-48e6.png',
  'DE', 'lilac', 'imported', 'https://xceed.me/es/artist/derali', 'pilot:artist-import-bba586a1fc2c60');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('077d5842-1c9b-5acd-9a30-e7c9d1366a9c', 'dj', 'marc-strap', 'Marc Strap', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/marc-strap-artist-xceed-cover-6ebb.png',
  'MA', 'lilac', 'imported', 'https://xceed.me/es/artist/marc-strap', 'pilot:artist-import-d37b322a8da56d');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('4289771f-47cb-5a26-af43-e56ddc1fafc4', 'dj', 'thebasement-soundsystem', 'theBasement Soundsystem', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/thebasement-soundsystem-artist-xceed-cover-65bb.jpg',
  'TH', 'lilac', 'imported', 'https://xceed.me/es/artist/thebasement-soundsystem', 'pilot:artist-import-28aaa09ff148a8');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('63c0b048-4f22-5a23-b347-e9125fc37ffe', 'venue', 'play-club', 'Play Club', 'Referencia informativa de la programación pública. Este perfil no ha sido registrado ni reclamado por la sala en You In.', '{}'::text[], 'València', 'València',
  'Valencia', 'C/ Cuba, 8', 39.462588, -0.37752999999998, 'https://images.xceed.me/clubs/covers/play-club-club-valencia-xceed-7e03.jpg',
  'PL', 'peach', 'imported', 'https://xceed.me/es/valencia/venue/play-club', 'pilot:venue-import-aba4cc9b8af82d');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('c3bb297a-d0fb-5fb1-a5ce-bc3f80739317', 'venue', 'jagger-club', 'Jagger Club', 'Referencia informativa de la programación pública. Este perfil no ha sido registrado ni reclamado por la sala en You In.', '{}'::text[], 'València', 'València',
  'Valencia', 'Gran Via del Marqués del Túria, 23', 39.4660067, -0.3718288, 'https://images.xceed.me/clubs/covers/jagger-club-club-valencia-xceed-3f0a.jpg',
  'JA', 'peach', 'imported', 'https://xceed.me/es/valencia/venue/jagger-club', 'pilot:venue-import-70d87f860706b5');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('0c9634a3-0e7c-5474-b699-c7507a7599cf', 'dj', 'dj-dreya', 'Dj DREYA', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/static/entities/artist-place-holder.jpg',
  'DJ', 'lilac', 'imported', 'https://xceed.me/es/artist/dj-dreya', 'pilot:artist-import-30ee644288eda5');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('4419e253-67b7-5ba0-96f6-41e05967a6ef', 'dj', 'djnice', 'Djnice', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/static/entities/artist-place-holder.jpg',
  'DJ', 'lilac', 'imported', 'https://xceed.me/es/artist/djnice', 'pilot:artist-import-5cc25f8daaef28');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('4b42156b-76dc-5243-8d85-6464efd681a0', 'venue', 'hifi-valencia', 'HIFI Valencia', 'Referencia informativa de la programación pública. Este perfil no ha sido registrado ni reclamado por la sala en You In.', '{}'::text[], 'València', 'València',
  'Valencia', 'Calle Jesús 91, 46007', 39.4616791, -0.3870305, 'https://images.xceed.me/clubs/covers/hifi-valencia-club-valencia-xceed-57fb.jpg',
  'HI', 'peach', 'imported', 'https://xceed.me/es/valencia/venue/hifi-valencia', 'pilot:venue-import-fa0071d265cc23');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('ea0896e2-3b71-5ece-9e4b-30fd336b0d4f', 'venue', 'miniclub', 'Miniclub.', 'Referencia informativa de la programación pública. Este perfil no ha sido registrado ni reclamado por la sala en You In.', '{}'::text[], 'València', 'València',
  'Valencia', 'Avenida Blasco Ibañez, 111', 39.473504, -0.34454900000003, 'https://images.xceed.me/clubs/covers/miniclub-club-valencia-xceed-7978.jpg',
  'MI', 'peach', 'imported', 'https://xceed.me/es/valencia/venue/miniclub', 'pilot:venue-import-376def13372886');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('0f1d600d-072e-53c2-9cc6-ebe793fe92ee', 'dj', 'j-wheel', 'J.Wheel', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/j-wheel-artist-xceed-cover-66c7.jpg',
  'J.', 'lilac', 'imported', 'https://xceed.me/es/artist/j-wheel', 'pilot:artist-import-42fcd9f6457855');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('ecc5ae4e-fb10-5d0a-8dd1-e6db1c8cf739', 'dj', 'jonny-menzal', 'Jonny Menzal', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/jonny-menzal-artist-xceed-cover-4aa4.jpg',
  'JO', 'lilac', 'imported', 'https://xceed.me/es/artist/jonny-menzal', 'pilot:artist-import-9005b49260f6c7');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('04b90b0f-3c77-5765-b1ba-a36b2dfb0525', 'dj', 'raul-castano', 'Raul Castaño', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/raul-castano-artist-xceed-cover-d13e.jpg',
  'RA', 'lilac', 'imported', 'https://xceed.me/es/artist/raul-castano', 'pilot:artist-import-5469e40f29ea6c');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('70fefd92-e15f-5c67-8eaa-21dccd428853', 'dj', 'andres-campo', 'Andres Campo', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/andres-campo-artist-xceed-cover-75d6.jpg',
  'AN', 'lilac', 'imported', 'https://xceed.me/es/artist/andres-campo', 'pilot:artist-import-2d0cb5f25034cd');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('5df41e11-3be8-546a-b60f-4ecd92329d9f', 'dj', 'serafina', 'Serafina', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['bounce · hard techno']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/serafina-artist-xceed-cover-6b54.jpg',
  'SE', 'lilac', 'imported', 'https://xceed.me/es/artist/serafina', 'pilot:artist-import-cc48ddec414db8');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('702f4d19-769a-52b7-88af-dafe599d5a86', 'dj', 'zwilling', 'ZWILLING.', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['bounce · hard techno · trance']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/zwilling-1-artist-xceed-cover-f24f.jpg',
  'ZW', 'lilac', 'imported', 'https://xceed.me/es/artist/zwilling-1', 'pilot:artist-import-6d128dbf0100e6');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('26a0af12-7081-51fe-bc00-606a41d77a53', 'dj', 'tedesco', 'TEDESCO', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/tedesco-artist-xceed-cover-7de7.jpg',
  'TE', 'lilac', 'imported', 'https://xceed.me/es/artist/tedesco', 'pilot:artist-import-da61e4eb0a8951');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('b6a964c8-20b7-5798-95e4-4268ad72e503', 'dj', 'linapary', 'Linapary', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/linapary-artist-xceed-cover-8cbf.jpg',
  'LI', 'lilac', 'imported', 'https://xceed.me/es/artist/linapary', 'pilot:artist-import-0e2f8f3d1db780');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('1170fcf9-03e5-5d27-ace4-27ecbc379c8a', 'dj', 'jose', 'José', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/jose-artist-xceed-cover-08b2.jpg',
  'JO', 'lilac', 'imported', 'https://xceed.me/es/artist/jose', 'pilot:artist-import-effa985ab0d887');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('902089a0-e79a-5e65-a36d-88a481eb3079', 'dj', 'olga-korol', 'Olga Korol', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['minimal techno']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/olga-korol-1-artist-xceed-cover-1b3c.jpg',
  'OL', 'lilac', 'imported', 'https://xceed.me/es/artist/olga-korol-1', 'pilot:artist-import-050de4c141188f');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('b270a436-640d-546b-aa06-da593287174c', 'dj', 'the-ghost', 'The Ghost', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/artists/covers/the-ghost-artist-xceed-cover-b05a.jpg',
  'TH', 'lilac', 'imported', 'https://xceed.me/es/artist/the-ghost', 'pilot:artist-import-a6d902c8186eb0');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('f8e3bc1e-6079-51d2-be37-93a2fdd543d1', 'venue', 'ohana-360', 'OHANA 360', 'Referencia informativa de la programación pública. Este perfil no ha sido registrado ni reclamado por la sala en You In.', '{}'::text[], 'València', 'València',
  'Valencia', 'I Ros, Carrer del Poeta Mas i Ros, 42, Algirós, 46022', 39.4700202, -0.3475324, 'https://images.xceed.me/clubs/covers/ohana-360-club-valencia-xceed-3174.jpg',
  'OH', 'peach', 'imported', 'https://xceed.me/es/valencia/venue/ohana-360', 'pilot:venue-import-c9cc3f58676d72');
insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values ('49206d3d-e289-5f6f-87cf-f9d2714a8aca', 'dj', 'kadi', 'KADI', 'Artista anunciado por la plataforma de origen. Referencia pública, sin cuenta reclamada en You In.', array['Artista anunciado']::text[], 'Valencia y alrededores', null,
  null, null, null, null, 'https://images.xceed.me/static/entities/artist-place-holder.jpg',
  'KA', 'lilac', 'imported', 'https://xceed.me/es/artist/kadi', 'pilot:artist-import-2db34d36b6b180');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('090d2b2e-3bab-5708-8cc1-4b823bb29499', 'LUNES 19 | Happy Mondays!', 'Evento publicado en Xceed. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-19T23:59:00+02:00', '2026-10-20T07:00:00+02:00', false, null,
  '9f967428-1d45-565d-ad58-d9f65a8604ee', 'La3', null, 'Avenida Blasco Ibanez 111', 'CIUTAT JARDI', 'València',
  'Valencia', 39.473577, -0.34458459999996, 'source-coordinates', 'Sin clasificar', '{}'::text[], 12,
  'from', 'Ticket', 'https://xceed.me/es/valencia/event/lunes-19-happy-mondays/245204', 'xceed', 'https://images.xceed.me/events/banners/lunes-12-happy-mondays-valencia-xceed-square-209b.png?w=1920&h=1920&ar=1:1&fm=auto', 'groove',
  '18+', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'xceed:245204', '[{"label":"Xceed","url":"https://xceed.me/es/valencia/event/lunes-19-happy-mondays/245204"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('5520712b-38ec-574e-8a1e-29b0b9f54b65', 'MINICLUB: LUNES 19 - J.WHEEL | JONNY MENZAL / 00:00-7:30AM / FREE ENTRY ALL NIGHT', 'Evento publicado en Xceed. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-19T23:59:00+02:00', '2026-10-20T07:30:00+02:00', false, null,
  'ea0896e2-3b71-5ece-9e4b-30fd336b0d4f', 'Miniclub.', null, 'Avenida Blasco Ibañez, 111', 'CIUTAT JARDI', 'València',
  'Valencia', 39.473504, -0.34454900000003, 'source-coordinates', 'Sin clasificar', '{}'::text[], 0,
  'conditional-free', 'Lista de invitados', 'https://xceed.me/es/valencia/event/miniclub-lunes-19-jwheel-jonny-menzal-0000-730am-free-entry-all-night/248234', 'xceed', 'https://images.xceed.me/events/banners/miniclub-lunes-12-jwheel-jonny-menzal-0000-730am-free-entry-all-night-valencia-xceed-square-a4c5.jpg?w=1920&h=1920&ar=1:1&fm=auto', 'groove',
  '18+', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'xceed:248234', '[{"label":"Xceed","url":"https://xceed.me/es/valencia/event/miniclub-lunes-19-jwheel-jonny-menzal-0000-730am-free-entry-all-night/248234"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.event_artists (event_id, entity_id, position) values ('5520712b-38ec-574e-8a1e-29b0b9f54b65', '0f1d600d-072e-53c2-9cc6-ebe793fe92ee', 0);
insert into public.event_artists (event_id, entity_id, position) values ('5520712b-38ec-574e-8a1e-29b0b9f54b65', 'ecc5ae4e-fb10-5d0a-8dd1-e6db1c8cf739', 1);
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('5dd681a2-244a-51af-b934-4988276444a3', 'MARINA: TARDE VIVA MARINA', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-20T16:30:00.000Z', '2026-10-20T20:30:00.000Z', false, null,
  '726aaac7-561a-5edd-a55d-78f78013af54', 'Marina Beach Club', 'Marina Beach', 'C. Marina Real Juan Carlos I, s/n, 46011 Valencia, España', 'EL GRAU', 'València',
  'Valencia', 39.4629916, -0.3216705, 'source-coordinates', 'Sin clasificar', '{}'::text[], 12,
  'from', 'ENTRADA  ANTICIPADA  sin consumición. ENTRANDO ANTES DE LAS 20:00H', 'https://site.fourvenues.com/es/marina-beach-club/events/APN3', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/3bc3a65f-2993-46d7-1b51-378abab7c100/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:z7mgk3crihxckxyck6zif6t4msiayv85', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/marina-beach-club"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/marina-beach-club/events/APN3"},{"label":"Marina Beach Club","url":"https://marinabeachclub.com/calendario-eventos/"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('6375e2da-a49c-55dc-85b6-ae71987f0766', 'MARINA: NOCHE SWING CLOSING At POOL', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-20T20:30:00.000Z', '2026-10-21T01:30:00.000Z', false, null,
  '726aaac7-561a-5edd-a55d-78f78013af54', 'Marina Beach Club', 'Marina Beach', 'C. Marina Real Juan Carlos I, s/n, 46011 Valencia, España', 'EL GRAU', 'València',
  'Valencia', 39.4629916, -0.3216705, 'source-coordinates', 'Sin clasificar', '{}'::text[], 5,
  'from', 'ENTRADA ANTICIPADA sin consumicion. ENTRANDO ANTES DE LAS 00:00H', 'https://site.fourvenues.com/es/marina-beach-club/events/68EG', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/4a354ad0-820b-474f-657e-f674378dfd00/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:qt70yw16dordrxw7q6lrd1uat70uxxgs', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/marina-beach-club"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/marina-beach-club/events/68EG"},{"label":"Marina Beach Club","url":"https://marinabeachclub.com/calendario-eventos/"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('1a37f8b8-28b0-5d1d-b0b6-edfeeb72b8a0', 'MARTES  20 | La3 International  Club!', 'Evento publicado en Xceed. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-20T23:59:00+02:00', '2026-10-21T07:00:00+02:00', false, null,
  '9f967428-1d45-565d-ad58-d9f65a8604ee', 'La3', null, 'Avenida Blasco Ibanez 111', 'CIUTAT JARDI', 'València',
  'Valencia', 39.473577, -0.34458459999996, 'source-coordinates', 'Sin clasificar', '{}'::text[], 10,
  'from', 'Bottle Service', 'https://xceed.me/es/valencia/event/martes-20-la3-international-club/245206', 'xceed', 'https://images.xceed.me/events/banners/martes-6-la3-international-club-valencia-xceed-square-8916.png?w=1920&h=1920&ar=1:1&fm=auto', 'groove',
  '18+', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'xceed:245206', '[{"label":"Xceed","url":"https://xceed.me/es/valencia/event/martes-20-la3-international-club/245206"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('008ab45b-4a4d-57a0-aa2b-618cf8ad1da3', 'MINICLUB: MARTES 20 - SLIM | CALATA / 00:00-7:30AM / FREE ENTRY ALL NIGHT', 'Evento publicado en Xceed. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-20T23:59:00+02:00', '2026-10-21T07:30:00+02:00', false, null,
  'ea0896e2-3b71-5ece-9e4b-30fd336b0d4f', 'Miniclub.', null, 'Avenida Blasco Ibañez, 111', 'CIUTAT JARDI', 'València',
  'Valencia', 39.473504, -0.34454900000003, 'source-coordinates', 'Sin clasificar', '{}'::text[], 0,
  'conditional-free', 'Lista de invitados', 'https://xceed.me/es/valencia/event/miniclub-martes-20-slim-calata-0000-730am-free-entry-all-night/248235', 'xceed', 'https://images.xceed.me/events/banners/miniclub-martes-20-slim-calata-0000-730am-free-entry-all-night-valencia-xceed-square-337f.jpg?w=1920&h=1920&ar=1:1&fm=auto', 'groove',
  '18+', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'xceed:248235', '[{"label":"Xceed","url":"https://xceed.me/es/valencia/event/miniclub-martes-20-slim-calata-0000-730am-free-entry-all-night/248235"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('12dec413-c5de-5c54-95f3-505f4356ade3', 'Miércoles Noche R144 | ERASMUS PARTY', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-20T22:30:00.000Z', '2026-10-22T05:30:00.000Z', false, 'La fuente publica una duración superior a 24 horas. Horario pendiente de contrastar.',
  'dc75fbbf-4710-5740-ab6c-520120ae0d33', 'Rumbo 144', 'Rumbo 144', 'Avenida Blasco Ibáñez, 144, 46022 Valencia (Valencia), España', 'CIUTAT JARDI', 'València',
  'Valencia', 39.47245, -0.3447, 'source-coordinates', 'Sin clasificar', '{}'::text[], 12,
  'from', 'OFERTA ENTRADA CON 1 COPA', 'https://site.fourvenues.com/es/rumbo144/events/GINR', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/5d5fba08-0c84-4c42-7874-d8246b5a2f00/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:t2bh8k74q504v0qsae68ap2vyq4c90sn', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/nightlife-valencia"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/rumbo144/events/GINR"},{"label":"Fourvenues","url":"https://site.fourvenues.com/es/rumbo144"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('4b451c57-33fc-5987-8996-44dcc16f26d9', 'MARINA: TARDE TARDEOS AL MAR', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-21T15:30:00.000Z', '2026-10-21T20:30:00.000Z', false, null,
  '726aaac7-561a-5edd-a55d-78f78013af54', 'Marina Beach Club', 'Marina Beach', 'C. Marina Real Juan Carlos I, s/n, 46011 Valencia, España', 'EL GRAU', 'València',
  'Valencia', 39.4629916, -0.3216705, 'source-coordinates', 'Sin clasificar', '{}'::text[], null,
  'unknown', 'Consultar entradas y disponibilidad en origen', 'https://site.fourvenues.com/es/marina-beach-club/events/T2FP', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/f58e536d-387b-4cc0-2902-97bc0d7fc300/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:fmfelvtf9g3dmji9ln7d4z13hcxfv3gf', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/marina-beach-club"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/marina-beach-club/events/T2FP"},{"label":"Marina Beach Club","url":"https://marinabeachclub.com/calendario-eventos/"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('8d42c133-d65c-5478-9690-0789615ad068', 'MARINA: NOCHE JIPJOP', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-21T20:30:00.000Z', '2026-10-22T01:30:00.000Z', false, null,
  '726aaac7-561a-5edd-a55d-78f78013af54', 'Marina Beach Club', 'Marina Beach', 'C. Marina Real Juan Carlos I, s/n, 46011 Valencia, España', 'EL GRAU', 'València',
  'Valencia', 39.4629916, -0.3216705, 'source-coordinates', 'Sin clasificar', '{}'::text[], 10,
  'from', 'ENTRADA ANTICIPADA  sin consumición.', 'https://site.fourvenues.com/es/marina-beach-club/events/ZLQF', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/e0ac17f1-82ca-425d-4223-1151ede07700/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:et1igbz8ocutwts8zwijialyi9853wc4', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/marina-beach-club"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/marina-beach-club/events/ZLQF"},{"label":"Marina Beach Club","url":"https://marinabeachclub.com/calendario-eventos/"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('fe33bbdb-393e-5a87-a1aa-2a76742494b2', 'THE BREAK', 'Evento publicado en Xceed. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-21T22:30:00+02:00', '2026-10-22T03:30:00+02:00', false, null,
  'c3bb297a-d0fb-5fb1-a5ce-bc3f80739317', 'Jagger Club', null, 'Gran Via del Marqués del Túria, 23', 'EL PLA DEL REMEI', 'València',
  'Valencia', 39.4660067, -0.3718288, 'source-coordinates', 'Sin clasificar', '{}'::text[], 10,
  'from', 'Entrada', 'https://xceed.me/es/valencia/event/the-break-14/248397', 'xceed', 'https://images.xceed.me/events/banners/the-break-break-the-routine-and-feel-the-rhythm-4-valencia-xceed-square-637e.png?w=1920&h=1920&ar=1:1&fm=auto', 'groove',
  '21+', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'xceed:248397', '[{"label":"Xceed","url":"https://xceed.me/es/valencia/event/the-break-14/248397"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.event_artists (event_id, entity_id, position) values ('fe33bbdb-393e-5a87-a1aa-2a76742494b2', '04b90b0f-3c77-5765-b1ba-a36b2dfb0525', 0);
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('9b6f1c30-492b-548e-a453-1388b448aa16', 'Giorgio Bonetti & Souleast', 'Evento publicado en Xceed. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-21T23:30:00+02:00', '2026-10-22T05:00:00+02:00', false, null,
  '122d2c78-1462-57c5-af56-2e099bc3ee31', 'Oven Club', null, 'Gran Via de les Germanies, 31', 'RUSSAFA', 'València',
  'Valencia', 39.4637314, -0.37599309999996, 'source-coordinates', 'Sin clasificar', '{}'::text[], 10,
  'from', 'Ticket', 'https://xceed.me/es/valencia/event/giorgio-bonetti-souleast-2/245813', 'xceed', 'https://images.xceed.me/events/banners/giorgio-bonetti-souleast-2-valencia-xceed-square-bff4.jpg?w=1920&h=1920&ar=1:1&fm=auto', 'groove',
  '18+', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'xceed:245813', '[{"label":"Xceed","url":"https://xceed.me/es/valencia/event/giorgio-bonetti-souleast-2/245813"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('f1c405ae-6a16-5aad-a520-b92b054db96c', 'Jueves Noche R144 | JUEVES UNIVERSITARIO', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-21T22:30:00.000Z', '2026-10-23T05:30:00.000Z', false, 'La fuente publica una duración superior a 24 horas. Horario pendiente de contrastar.',
  'dc75fbbf-4710-5740-ab6c-520120ae0d33', 'Rumbo 144', 'Rumbo 144', 'Avenida Blasco Ibáñez, 144, 46022 Valencia (Valencia), España', 'CIUTAT JARDI', 'València',
  'Valencia', 39.47245, -0.3447, 'source-coordinates', 'Sin clasificar', '{}'::text[], 12,
  'from', 'OFERTA ENTRADA CON 1 COPA', 'https://site.fourvenues.com/es/rumbo144/events/BGGN', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/3aad001d-4adb-4adf-65d0-939455158400/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:g344varpsni0c52ky7dlnfudvz0dyuyh', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/nightlife-valencia"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/rumbo144/events/BGGN"},{"label":"Fourvenues","url":"https://site.fourvenues.com/es/rumbo144"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('4e748f06-3a1c-5784-abf4-af3df0998281', 'MARINA: TARDE TARDEOS AL MAR', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-22T15:30:00.000Z', '2026-10-22T20:30:00.000Z', false, null,
  '726aaac7-561a-5edd-a55d-78f78013af54', 'Marina Beach Club', 'Marina Beach', 'C. Marina Real Juan Carlos I, s/n, 46011 Valencia, España', 'EL GRAU', 'València',
  'Valencia', 39.4629916, -0.3216705, 'source-coordinates', 'Sin clasificar', '{}'::text[], null,
  'unknown', 'Consultar entradas y disponibilidad en origen', 'https://site.fourvenues.com/es/marina-beach-club/events/KDTF', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/f58e536d-387b-4cc0-2902-97bc0d7fc300/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:bx5n0bkvcpko5wq1hi3adp2ccszcgemh', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/marina-beach-club"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/marina-beach-club/events/KDTF"},{"label":"Marina Beach Club","url":"https://marinabeachclub.com/calendario-eventos/"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('12442fe2-1db9-5ca9-ba99-b90dab82947b', 'Europea club de emprendimiento', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-22T17:00:00.000Z', '2026-10-22T23:00:00.000Z', false, null,
  'b748dfd3-edda-57df-b4d2-0b5736191f04', 'VELES E VENTS', 'VELES E VENTS', 'Edificio Veles e Vents La Marina de València, 46024 València, Valencia, España', 'EL GRAU', 'València',
  'Valencia', 39.4608845, -0.3240626, 'source-coordinates', 'Sin clasificar', '{}'::text[], 12,
  'from', 'General Tickets', 'https://site.fourvenues.com/es/veles-e-vents-eventos/events/KCTT', 'fourvenues', null, 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:ofora1wsd8eyojxq5cdlhdkftj3k3jtd', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/nightlife-valencia"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/veles-e-vents-eventos/events/KCTT"},{"label":"Fourvenues","url":"https://site.fourvenues.com/es/veles-e-vents-eventos"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('1d4a97dc-4e6c-59b7-9587-9dcece44abc9', 'MARINA: NOCHE HITS', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-22T20:30:00.000Z', '2026-10-23T01:30:00.000Z', false, null,
  '726aaac7-561a-5edd-a55d-78f78013af54', 'Marina Beach Club', 'Marina Beach', 'C. Marina Real Juan Carlos I, s/n, 46011 Valencia, España', 'EL GRAU', 'València',
  'Valencia', 39.4629916, -0.3216705, 'source-coordinates', 'Sin clasificar', '{}'::text[], 10,
  'from', 'ENTRADA ANTICIPADA sin consumición. ENTRANDO ANTES DE LAS 00:00H', 'https://site.fourvenues.com/es/marina-beach-club/events/MXKH', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/c1f0a0da-d40c-48d8-c1df-eaee300f0a00/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:zgh4oaddnjtn0o4jddf7e55yga2154q4', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/marina-beach-club"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/marina-beach-club/events/MXKH"},{"label":"Marina Beach Club","url":"https://marinabeachclub.com/calendario-eventos/"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('6caf95a5-6625-5b8b-86f7-f19cda204ee6', '22/10 MOOVA  AYO NICE & DREYA', 'Evento publicado en Xceed. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-22T22:30:00+02:00', '2026-10-23T03:30:00+02:00', false, null,
  'c3bb297a-d0fb-5fb1-a5ce-bc3f80739317', 'Jagger Club', null, 'Gran Via del Marqués del Túria, 23', 'EL PLA DEL REMEI', 'València',
  'Valencia', 39.4660067, -0.3718288, 'source-coordinates', 'Sin clasificar', '{}'::text[], 10,
  'from', 'ANTICIPADA 10€', 'https://xceed.me/es/valencia/event/22-10-moova-ayo-nice-dreya/247162', 'xceed', 'https://images.xceed.me/events/banners/22-10-moova-ayo-nice-dreya-valencia-xceed-square-477e.png?w=1920&h=1920&ar=1:1&fm=auto', 'groove',
  '18+', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'xceed:247162', '[{"label":"Xceed","url":"https://xceed.me/es/valencia/event/22-10-moova-ayo-nice-dreya/247162"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.event_artists (event_id, entity_id, position) values ('6caf95a5-6625-5b8b-86f7-f19cda204ee6', '0c9634a3-0e7c-5474-b699-c7507a7599cf', 0);
insert into public.event_artists (event_id, entity_id, position) values ('6caf95a5-6625-5b8b-86f7-f19cda204ee6', '4419e253-67b7-5ba0-96f6-41e05967a6ef', 1);
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('e3780b35-a7a0-555a-b322-e36090e3fe02', '22/10 PRISMA X OHANA360 | JUEVES UNIVERSITARIO', 'Evento publicado en Xceed. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-22T23:00:00+02:00', '2026-10-23T03:30:00+02:00', false, null,
  'f8e3bc1e-6079-51d2-be37-93a2fdd543d1', 'OHANA 360', null, 'I Ros, Carrer del Poeta Mas i Ros, 42, Algirós, 46022', 'CIUTAT JARDI', 'València',
  'Valencia', 39.4700202, -0.3475324, 'source-coordinates', 'Sin clasificar', '{}'::text[], 5,
  'from', 'Entrada Anticipada + 1 Consumición', 'https://xceed.me/es/valencia/event/22-10-prisma-x-ohana360-jueves-universitario/248927', 'xceed', 'https://images.xceed.me/events/banners/22-10-prisma-x-ohana360-jueves-universitario-valencia-xceed-square-912a.png?w=1920&h=1920&ar=1:1&fm=auto', 'groove',
  null, 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'xceed:248927', '[{"label":"Xceed","url":"https://xceed.me/es/valencia/event/22-10-prisma-x-ohana360-jueves-universitario/248927"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.event_artists (event_id, entity_id, position) values ('e3780b35-a7a0-555a-b322-e36090e3fe02', '49206d3d-e289-5f6f-87cf-f9d2714a8aca', 0);
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('4fcc8ea2-485b-5234-a25d-84a4515ff676', 'Fresh groove: Marc Strap + Alpa + Xavi Chan', 'Evento publicado en Xceed. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-22T23:59:00+02:00', '2026-10-23T06:00:00+02:00', false, null,
  '122d2c78-1462-57c5-af56-2e099bc3ee31', 'Oven Club', null, 'Gran Via de les Germanies, 31', 'RUSSAFA', 'València',
  'Valencia', 39.4637314, -0.37599309999996, 'source-coordinates', 'Sin clasificar', '{}'::text[], 10,
  'from', 'Ticket', 'https://xceed.me/es/valencia/event/fresh-groove-marc-strap-alpa-xavi-chan/245764', 'xceed', 'https://images.xceed.me/events/banners/fresh-groove-marc-strap-alpa-xavi-chan-valencia-xceed-square-c80b.jpg?w=1920&h=1920&ar=1:1&fm=auto', 'groove',
  '18+', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'xceed:245764', '[{"label":"Xceed","url":"https://xceed.me/es/valencia/event/fresh-groove-marc-strap-alpa-xavi-chan/245764"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('dbe2aeff-0157-555f-b15f-db0488366ad7', 'LOS JUEVES DE HAVANA x ESN', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-22T22:00:00.000Z', '2026-10-23T04:30:00.000Z', false, null,
  '91f2ebc6-3c7a-520c-a2d9-037b7d469d68', 'Havana Valencia', 'Canovas', 'Plaza Cánovas del Castillo, 6, 46005 Valencia (Valencia), España', 'LA GRAN VIA', 'València',
  'Valencia', 39.46783, -0.36564, 'source-coordinates', 'House', array['pop', 'hits', 'reggaeton', 'house']::text[], 10,
  'from', 'TICKET GENERAL ', 'https://site.fourvenues.com/es/havana-canovas/events/9GIT', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/2ae742e3-e956-42ef-a3bb-b069245d9900/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:c0vcqcbojopucihdbw4wej7dmigk13sk', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/nightlife-valencia"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/havana-canovas/events/9GIT"},{"label":"Fourvenues","url":"https://site.fourvenues.com/es/havana-canovas"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('a14f6a10-4ed5-5e99-b72c-0c1d79afdb51', 'Viernes Noche R144 |', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-22T23:00:00.000Z', '2026-10-24T05:30:00.000Z', false, 'La fuente publica una duración superior a 24 horas. Horario pendiente de contrastar.',
  'dc75fbbf-4710-5740-ab6c-520120ae0d33', 'Rumbo 144', 'Rumbo 144', 'Avenida Blasco Ibáñez, 144, 46022 Valencia (Valencia), España', 'CIUTAT JARDI', 'València',
  'Valencia', 39.47245, -0.3447, 'source-coordinates', 'Sin clasificar', '{}'::text[], 12,
  'from', 'OFERTA ENTRADA CON 1 COPA', 'https://site.fourvenues.com/es/rumbo144/events/AEMG', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/2a112fcc-0cfa-4a04-fe2d-079143242c00/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:tt86nzewcd86sc6r1bp4bl97klti2vs2', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/nightlife-valencia"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/rumbo144/events/AEMG"},{"label":"Fourvenues","url":"https://site.fourvenues.com/es/rumbo144"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('16563e0c-ad77-59d2-9e28-45145c6688c5', 'Tardeo Verbena - 23.10.26', 'Evento publicado en Xceed. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-23T17:00:00+02:00', '2026-10-23T23:59:00+02:00', false, null,
  '63c0b048-4f22-5a23-b347-e9125fc37ffe', 'Play Club', null, 'C/ Cuba, 8', 'RUSSAFA', 'València',
  'Valencia', 39.462588, -0.37752999999998, 'source-coordinates', 'Sin clasificar', '{}'::text[], 10,
  'from', 'Entrada con consumición', 'https://xceed.me/es/valencia/event/tardeo-verbena-231026/246684', 'xceed', 'https://images.xceed.me/events/banners/tardeo-verbena-250926-valencia-xceed-square-b3d2.jpg?w=1920&h=1920&ar=1:1&fm=auto', 'groove',
  '18+', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'xceed:246684', '[{"label":"Xceed","url":"https://xceed.me/es/valencia/event/tardeo-verbena-231026/246684"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('56cb392f-9f01-50cc-90db-a2000ac13545', 'MARINA: TARDE TARDEOS AL MAR', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-23T15:30:00.000Z', '2026-10-23T20:30:00.000Z', false, null,
  '726aaac7-561a-5edd-a55d-78f78013af54', 'Marina Beach Club', 'Marina Beach', 'C. Marina Real Juan Carlos I, s/n, 46011 Valencia, España', 'EL GRAU', 'València',
  'Valencia', 39.4629916, -0.3216705, 'source-coordinates', 'Sin clasificar', '{}'::text[], null,
  'unknown', 'Consultar entradas y disponibilidad en origen', 'https://site.fourvenues.com/es/marina-beach-club/events/ZG33', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/f58e536d-387b-4cc0-2902-97bc0d7fc300/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:d42wxt4z1vkwztzg3yce6x0qqmuj4bgc', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/marina-beach-club"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/marina-beach-club/events/ZG33"},{"label":"Marina Beach Club","url":"https://marinabeachclub.com/calendario-eventos/"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('d031c248-c3f8-5555-9930-400003562e92', 'TARDEO MUCHO Afterwork  - Viernes', 'Evento publicado en Xceed. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-23T18:00:00+02:00', '2026-10-23T23:30:00+02:00', false, null,
  'ded32f77-5cd0-589d-b395-35b40fe64f29', 'MUCHO', null, 'Carrer de Martí, 4', 'LA GRAN VIA', 'València',
  'Valencia', 39.4655443, -0.37091799999996, 'source-coordinates', 'Sin clasificar', '{}'::text[], 12,
  'from', 'First Release', 'https://xceed.me/es/valencia/event/tardeo-mucho-afterwork-viernes-6/240867', 'xceed', 'https://images.xceed.me/events/banners/opening-tardeo-mucho-sabado-valencia-xceed-a59f.png?w=1920&h=1920&ar=1:1&fm=auto', 'groove',
  '24+', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'xceed:240867', '[{"label":"Xceed","url":"https://xceed.me/es/valencia/event/tardeo-mucho-afterwork-viernes-6/240867"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('ec4e513c-05da-598a-b7ba-25838c07dbbe', 'MARINA: NOCHE SARAH JANE', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-23T20:30:00.000Z', '2026-10-24T01:30:00.000Z', false, null,
  '726aaac7-561a-5edd-a55d-78f78013af54', 'Marina Beach Club', 'Marina Beach', 'C. Marina Real Juan Carlos I, s/n, 46011 Valencia, España', 'EL GRAU', 'València',
  'Valencia', 39.4629916, -0.3216705, 'source-coordinates', 'Sin clasificar', '{}'::text[], 10,
  'from', 'ENTRADA ANTICIPADA  sin consumición.', 'https://site.fourvenues.com/es/marina-beach-club/events/OVFU', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/f7a95a7c-6d6d-471a-b76b-71c1f9037000/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:n9ulwgdfzw0rg4uif1wjwm1sq5mbvo0x', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/marina-beach-club"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/marina-beach-club/events/OVFU"},{"label":"Marina Beach Club","url":"https://marinabeachclub.com/calendario-eventos/"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('991a1ce5-cf7e-58fc-85d0-4871b8e5bc43', 'Viernes 23/10 SPECIAL GUEST DVINE en PICCA', 'Evento publicado en Xceed. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-23T23:00:00+02:00', '2026-10-24T06:00:00+02:00', false, null,
  '3618cea4-5a50-53a2-803d-a95a3cd04084', 'PICCA', null, 'Carrer dels Tomassos, 14', 'RUSSAFA', 'València',
  'Valencia', 39.461619, -0.37232700000004, 'source-coordinates', 'Sin clasificar', '{}'::text[], 10,
  'from', 'ANTICIPADA 10€', 'https://xceed.me/es/valencia/event/viernes-23-10-special-guest-dvine-en-picca/245091', 'xceed', 'https://images.xceed.me/events/banners/viernes-23-10-special-guest-dvine-en-picca-valencia-xceed-square-6503.jpg?w=1920&h=1920&ar=1:1&fm=auto', 'groove',
  '18+', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'xceed:245091', '[{"label":"Xceed","url":"https://xceed.me/es/valencia/event/viernes-23-10-special-guest-dvine-en-picca/245091"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('b80cc7a4-ca21-5c85-8329-ce715159f75e', 'V23/10 WHATEVER CHARLES // PABLO CEBRIÁN  en LATEX', 'Evento publicado en Xceed. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-23T23:00:00+02:00', '2026-10-24T06:00:00+02:00', false, null,
  '3054c44b-27fc-5108-970d-bb78a087fb94', 'Latex Club', null, 'Carlos Cervera, 23', 'RUSSAFA', 'València',
  'Valencia', 39.4615073, -0.3727169, 'source-coordinates', 'Sin clasificar', '{}'::text[], 10,
  'from', 'ANTICIPADA 10€', 'https://xceed.me/es/valencia/event/v23-10-whatever-charles-pablo-cebrian-en-latex/245160', 'xceed', 'https://images.xceed.me/events/banners/v23-10-whatever-charles-pablo-cebrian-en-latex-valencia-xceed-square-c9ca.jpg?w=1920&h=1920&ar=1:1&fm=auto', 'groove',
  '18+', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'xceed:245160', '[{"label":"Xceed","url":"https://xceed.me/es/valencia/event/v23-10-whatever-charles-pablo-cebrian-en-latex/245160"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('90afe636-c9fb-587a-9ef0-131a93dc0326', 'Play + Kiki - 23.10.26', 'Evento publicado en Xceed. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-23T23:00:00+02:00', '2026-10-24T06:00:00+02:00', false, null,
  '63c0b048-4f22-5a23-b347-e9125fc37ffe', 'Play Club', null, 'C/ Cuba, 8', 'RUSSAFA', 'València',
  'Valencia', 39.462588, -0.37752999999998, 'source-coordinates', 'Sin clasificar', '{}'::text[], 10,
  'from', 'Entrada anticipada', 'https://xceed.me/es/valencia/event/play-kiki-231026/246686', 'xceed', 'https://images.xceed.me/events/banners/play-kiki-250926-valencia-xceed-square-1eaa.jpg?w=1920&h=1920&ar=1:1&fm=auto', 'groove',
  '18+', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'xceed:246686', '[{"label":"Xceed","url":"https://xceed.me/es/valencia/event/play-kiki-231026/246686"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('575d4019-2c2a-5732-bfd5-1e0579632fbf', '23/10 - TKMAMI + AFT3RLIFE (SHOWCASE + DJSET) + MORE + ASHTRAL', 'Evento publicado en Xceed. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-23T23:30:00+02:00', '2026-10-24T07:00:00+02:00', false, null,
  '3b708a01-87d9-5829-ad72-b123a9669368', 'ROTO CLUB', null, 'Av. d''Ausiàs March, 18', 'MALILLA', 'València',
  'Valencia', 39.454988, -0.3748483, 'source-coordinates', 'Sin clasificar', '{}'::text[], 10,
  'from', 'ANTICIPADA 10€', 'https://xceed.me/es/valencia/event/23-10-tkmami-aft3rlife-showcase-djset-more-ashtral/244752', 'xceed', 'https://images.xceed.me/events/banners/23-10-tkmami-aft3rlife-showcase-djset-more-ashtral-valencia-xceed-square-877a.jpg?w=1920&h=1920&ar=1:1&fm=auto', 'groove',
  '18+', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'xceed:244752', '[{"label":"Xceed","url":"https://xceed.me/es/valencia/event/23-10-tkmami-aft3rlife-showcase-djset-more-ashtral/244752"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.event_artists (event_id, entity_id, position) values ('575d4019-2c2a-5732-bfd5-1e0579632fbf', 'e9b3283e-58bf-5395-a6a3-0b1bfb3328d1', 0);
insert into public.event_artists (event_id, entity_id, position) values ('575d4019-2c2a-5732-bfd5-1e0579632fbf', 'aa61166b-6f78-5bb6-b9d2-2aa6a129fe91', 1);
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('742aace0-370e-52c4-82be-dd02a3d90bdb', 'MUCHO - Viernes', 'Evento publicado en Xceed. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-23T23:59:00+02:00', '2026-10-24T07:00:00+02:00', false, null,
  'ded32f77-5cd0-589d-b395-35b40fe64f29', 'MUCHO', null, 'Carrer de Martí, 4', 'LA GRAN VIA', 'València',
  'Valencia', 39.4655443, -0.37091799999996, 'source-coordinates', 'Sin clasificar', '{}'::text[], 12,
  'from', 'Lista de invitados', 'https://xceed.me/es/valencia/event/mucho-viernes-56/240789', 'xceed', 'https://images.xceed.me/events/banners/opening-mucho-viernes-valencia-xceed-8d18.png?w=1920&h=1920&ar=1:1&fm=auto', 'groove',
  '24+', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'xceed:240789', '[{"label":"Xceed","url":"https://xceed.me/es/valencia/event/mucho-viernes-56/240789"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('cf4e7171-1b12-53ab-8d6f-91bb2d97eacb', 'WE ARE GOING TO PARRANDA: HIT ME BABE', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-23T22:00:00.000Z', '2026-10-24T04:30:00.000Z', false, null,
  '91f2ebc6-3c7a-520c-a2d9-037b7d469d68', 'Havana Valencia', 'Canovas', 'Plaza Cánovas del Castillo, 6, 46005 Valencia (Valencia), España', 'LA GRAN VIA', 'València',
  'Valencia', 39.46783, -0.36564, 'source-coordinates', 'House', array['pop', 'hits', 'reggaeton', 'house']::text[], 12,
  'from', 'TICKET GENERAL ', 'https://site.fourvenues.com/es/havana-canovas/events/9UH2', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/8dd7aa59-844a-4d71-47bc-6e45af7dfe00/w=1350', 'groove',
  '21', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:fl5huhg1zl4ffbazljshjv9ssigbi7xu', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/nightlife-valencia"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/havana-canovas/events/9UH2"},{"label":"Fourvenues","url":"https://site.fourvenues.com/es/havana-canovas"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('1076f440-7f8c-53c2-905e-412fe2b065fb', 'Sábado Noche R144 | DJ BUM BUM', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-23T23:00:00.000Z', '2026-10-25T05:30:00.000Z', false, 'La fuente publica una duración superior a 24 horas. Horario pendiente de contrastar.',
  'dc75fbbf-4710-5740-ab6c-520120ae0d33', 'Rumbo 144', 'Rumbo 144', 'Avenida Blasco Ibáñez, 144, 46022 Valencia (Valencia), España', 'CIUTAT JARDI', 'València',
  'Valencia', 39.47245, -0.3447, 'source-coordinates', 'Sin clasificar', '{}'::text[], 25,
  'from', 'ENTRADA 1 COPA - ON LINE**', 'https://site.fourvenues.com/es/rumbo144/events/JHC1', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/60807b03-2ea8-474c-536f-7cf6e4b1df00/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:jcb9xpi2ljfkfq5cc7e4c7wmgdvzjjbm', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/nightlife-valencia"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/rumbo144/events/JHC1"},{"label":"Fourvenues","url":"https://site.fourvenues.com/es/rumbo144"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('714f152b-d6df-522f-a8eb-0e71122e5b51', 'STEFF PRESENTS: RED HORSE – 24 DE OCTUBRE', 'Evento publicado en Xceed. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-24T15:00:00+02:00', '2026-10-25T01:00:00+02:00', false, null,
  'e5713117-3b02-578c-966f-32173fb440b9', 'Multispook', null, 'Carr. del Río, 399, Poblados del Sur, 46012', 'PINEDO', 'València',
  'Valencia', 39.4105911, -0.3351692, 'source-coordinates', 'Sin clasificar', '{}'::text[], 12,
  'from', 'TICKETS - TRAMO 1', 'https://xceed.me/es/valencia/event/steff-presents-red-horse-24-de-octubre/245729', 'xceed', 'https://images.xceed.me/events/banners/steff-presents-red-horse-24-de-octubre-valencia-xceed-square-666e.png?w=1920&h=1920&ar=1:1&fm=auto', 'groove',
  '18+', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'xceed:245729', '[{"label":"Xceed","url":"https://xceed.me/es/valencia/event/steff-presents-red-horse-24-de-octubre/245729"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('4f676bd9-3a1d-5f34-97ba-338ee63c1d97', 'Tardeo Sábado | TODO SUCEDIÓ UN MARTES en Concierto', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-24T15:00:00.000Z', '2026-10-24T21:45:00.000Z', false, null,
  'dc75fbbf-4710-5740-ab6c-520120ae0d33', 'Rumbo 144', 'Rumbo 144', 'Avenida Blasco Ibáñez, 144, 46022 Valencia (Valencia), España', 'CIUTAT JARDI', 'València',
  'Valencia', 39.47245, -0.3447, 'source-coordinates', 'En directo', array['indie', 'rock', 'pop']::text[], 5,
  'from', 'Entrada CONCIERTO y TARDEO', 'https://site.fourvenues.com/es/rumbo144/events/H3O9', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/6dd1f019-0dc7-4f7f-c582-cbfba12b1000/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:q8rvf9tb6dlzz5sti0gshl5ocwb55r4c', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/nightlife-valencia"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/rumbo144/events/H3O9"},{"label":"Fourvenues","url":"https://site.fourvenues.com/es/rumbo144"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('ad1f80fe-359d-5566-9777-afe60473f571', 'TARDE_ON INDIE | LOS GUAPOS en Concierto', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-24T15:00:00.000Z', '2026-10-24T21:45:00.000Z', false, null,
  'dc75fbbf-4710-5740-ab6c-520120ae0d33', 'Rumbo 144', 'Rumbo 144', 'Avenida Blasco Ibáñez, 144, 46022 Valencia (Valencia), España', 'CIUTAT JARDI', 'València',
  'Valencia', 39.47245, -0.3447, 'source-coordinates', 'En directo', array['indie', 'rock', 'pop']::text[], 5,
  'from', 'Entrada CONCIERTO y TARDEO', 'https://site.fourvenues.com/es/rumbo144/events/YRNO', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/2fa8c635-4e4c-4e25-5760-7b45ceaa5700/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:rn1hw9zsgxnxsosfubhve7mbpr6a857n', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/nightlife-valencia"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/rumbo144/events/YRNO"},{"label":"Fourvenues","url":"https://site.fourvenues.com/es/rumbo144"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('bafc4321-f38e-5ab8-bbac-f6ed7b14fd72', 'TARDEOS SÓLO HITS', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-24T15:00:00.000Z', '2026-10-24T21:30:00.000Z', false, null,
  '91f2ebc6-3c7a-520c-a2d9-037b7d469d68', 'Havana Valencia', 'Canovas', 'Plaza Cánovas del Castillo, 6, 46005 Valencia (Valencia), España', 'LA GRAN VIA', 'València',
  'Valencia', 39.46783, -0.36564, 'source-coordinates', 'House', array['pop', 'house', 'comercial', 'hits']::text[], 10,
  'from', 'TICKET GENERAL ', 'https://site.fourvenues.com/es/havana-canovas/events/HD6N', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/184c8ff2-fcc9-4a91-5670-a4773f659e00/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:hqq09j0vmfx77n80mav2rgvupzmwyetv', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/nightlife-valencia"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/havana-canovas/events/HD6N"},{"label":"Fourvenues","url":"https://site.fourvenues.com/es/havana-canovas"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('b9883b71-267a-5ea3-bd30-720260674d2d', 'MARINA: TARDE Y NOCHE Y ANIMAS', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-24T15:30:00.000Z', '2026-10-25T02:30:00.000Z', false, null,
  '726aaac7-561a-5edd-a55d-78f78013af54', 'Marina Beach Club', 'Marina Beach', 'C. Marina Real Juan Carlos I, s/n, 46011 Valencia, España', 'EL GRAU', 'València',
  'Valencia', 39.4629916, -0.3216705, 'source-coordinates', 'Sin clasificar', '{}'::text[], 10,
  'from', 'ENTRADA ANTICIPADA sin consumición. ENTRA CUANDO QUIERAS ', 'https://site.fourvenues.com/es/marina-beach-club/events/919N', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/e856d520-ecf5-4235-c857-dd1996ddba00/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:c00g6nppaw1jxpyj5hqo8ckrnqnv6eqa', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/marina-beach-club"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/marina-beach-club/events/919N"},{"label":"Marina Beach Club","url":"https://marinabeachclub.com/calendario-eventos/"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('864c696b-e3c3-54b8-9c89-4619c587611a', 'PLAYA PALAPA: TARDE DELIRIO', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-24T16:30:00.000Z', '2026-10-24T22:00:00.000Z', false, null,
  '726aaac7-561a-5edd-a55d-78f78013af54', 'Marina Beach Club', 'Marina Beach', 'C. Marina Real Juan Carlos I, s/n, 46011 Valencia, España', 'EL GRAU', 'València',
  'Valencia', 39.4629916, -0.3216705, 'source-coordinates', 'Sin clasificar', '{}'::text[], 10,
  'from', 'ENTRADA  ANTICIPADA  sin consumición ENTRANDO ANTES DE LAS 20:00h', 'https://site.fourvenues.com/es/marina-beach-club/events/87F6', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/db33bd1e-f0f5-41ff-24df-0b36ec690300/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:uf4734lk6wob9qij4arll9kyle0p16o5', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/marina-beach-club"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/marina-beach-club/events/87F6"},{"label":"Marina Beach Club","url":"https://marinabeachclub.com/calendario-eventos/"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('a33a4fd9-1e6b-5ab1-8843-dbd78168f0b5', 'MIRACLE BONA GENT ONLY PLANTA 2', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-24T17:30:00.000Z', '2026-10-25T02:00:00.000Z', false, null,
  'b748dfd3-edda-57df-b4d2-0b5736191f04', 'VELES E VENTS', 'VELES E VENTS', 'Edificio Veles e Vents La Marina de València, 46024 València, Valencia, España', 'EL GRAU', 'València',
  'Valencia', 39.4608845, -0.3240626, 'source-coordinates', 'Techno', array['house', 'techno']::text[], 10,
  'from', 'MIRACLE BONA GENT ONLY', 'https://site.fourvenues.com/es/veles-e-vents-eventos/events/BGNV', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/8382fbcf-2909-4e46-3487-a5b9f21eeb00/w=1350', 'groove',
  '21', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:h5t4qmfib8edxlrl5rf8h1eppdi94fmf', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/nightlife-valencia"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/veles-e-vents-eventos/events/BGNV"},{"label":"Fourvenues","url":"https://site.fourvenues.com/es/veles-e-vents-eventos"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('afba66a1-2e70-5efa-b587-208de3a27028', 'BCCO invites: Future.666 + Fenim0re + Bixbita & Deriva Festival showcase', 'Evento publicado en Xceed. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-24T23:00:00+02:00', '2026-10-25T07:30:00+01:00', false, null,
  'cbe949b0-364d-5edf-a75d-8aab698e3a41', 'Spook Club', null, 'Carretera del Rio, 399, Pinedo', 'PINEDO', 'València',
  'Valencia', 39.410901, -0.33605499999999, 'source-coordinates', 'Sin clasificar', '{}'::text[], 25,
  'from', 'TICKET - TRAMO 2', 'https://xceed.me/es/valencia/event/bcco-invites-future666-fenim0re-bixbita-deriva-festival-showcase/241965', 'xceed', 'https://images.xceed.me/events/banners/bcco-invites-future666-fenim0re-bixbita-deriva-festival-showcase-valencia-xceed-square-df54.jpg?w=1920&h=1920&ar=1:1&fm=auto', 'groove',
  '18+', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'xceed:241965', '[{"label":"Xceed","url":"https://xceed.me/es/valencia/event/bcco-invites-future666-fenim0re-bixbita-deriva-festival-showcase/241965"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.event_artists (event_id, entity_id, position) values ('afba66a1-2e70-5efa-b587-208de3a27028', '8d8e38cc-90fb-545b-a9d7-52ce337c1f46', 0);
insert into public.event_artists (event_id, entity_id, position) values ('afba66a1-2e70-5efa-b587-208de3a27028', '16a96edd-801d-5038-a01e-592a0a8eedab', 1);
insert into public.event_artists (event_id, entity_id, position) values ('afba66a1-2e70-5efa-b587-208de3a27028', 'feacc8e2-bb9d-5ea3-9f71-ff6f05eea834', 2);
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('9351a132-9628-5eeb-9210-2528a6572c20', 'Sábado 24/10 ABDUCIDAS en PICCA', 'Evento publicado en Xceed. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-24T23:00:00+02:00', '2026-10-25T06:00:00+01:00', false, null,
  '3618cea4-5a50-53a2-803d-a95a3cd04084', 'PICCA', null, 'Carrer dels Tomassos, 14', 'RUSSAFA', 'València',
  'Valencia', 39.461619, -0.37232700000004, 'source-coordinates', 'Sin clasificar', '{}'::text[], 10,
  'from', 'ANTICIPADA 10€', 'https://xceed.me/es/valencia/event/sabado-24-10-abducidas-en-picca/245092', 'xceed', 'https://images.xceed.me/events/banners/sabado-24-10-abducidas-en-picca-valencia-xceed-square-6ad4.jpg?w=1920&h=1920&ar=1:1&fm=auto', 'groove',
  '18+', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'xceed:245092', '[{"label":"Xceed","url":"https://xceed.me/es/valencia/event/sabado-24-10-abducidas-en-picca/245092"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('abf476ba-96a4-572e-9b5e-e76eb44ad32b', 'S24/10  SARAH JANE // GIO PORZIO en LATEX', 'Evento publicado en Xceed. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-24T23:00:00+02:00', '2026-10-25T06:00:00+01:00', false, null,
  '3054c44b-27fc-5108-970d-bb78a087fb94', 'Latex Club', null, 'Carlos Cervera, 23', 'RUSSAFA', 'València',
  'Valencia', 39.4615073, -0.3727169, 'source-coordinates', 'Sin clasificar', '{}'::text[], 10,
  'from', 'ANTICIPADA 10€', 'https://xceed.me/es/valencia/event/s24-10-sarah-jane-gio-porzio-en-latex-1/245164', 'xceed', 'https://images.xceed.me/events/banners/s24-10-sarah-jane-gio-porzio-en-latex-1-valencia-xceed-square-138b.jpg?w=1920&h=1920&ar=1:1&fm=auto', 'groove',
  '18+', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'xceed:245164', '[{"label":"Xceed","url":"https://xceed.me/es/valencia/event/s24-10-sarah-jane-gio-porzio-en-latex-1/245164"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('a9a4397a-1e17-5b40-a529-76024bc54cf1', '24/10 - JUST FAM w/ MAXVLL +  GIGI + LUCÍA REINA', 'Evento publicado en Xceed. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-24T23:30:00+02:00', '2026-10-25T07:00:00+01:00', false, null,
  '3b708a01-87d9-5829-ad72-b123a9669368', 'ROTO CLUB', null, 'Av. d''Ausiàs March, 18', 'MALILLA', 'València',
  'Valencia', 39.454988, -0.3748483, 'source-coordinates', 'Sin clasificar', '{}'::text[], 10,
  'from', 'ANTICIPADA 10€', 'https://xceed.me/es/valencia/event/24-10-just-fam-w-maxvll-gigi-lucia-reina/244755', 'xceed', 'https://images.xceed.me/events/banners/24-10-just-fam-w-maxvll-lucia-reina-valencia-xceed-square-69bf.jpg?w=1920&h=1920&ar=1:1&fm=auto', 'groove',
  '18+', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'xceed:244755', '[{"label":"Xceed","url":"https://xceed.me/es/valencia/event/24-10-just-fam-w-maxvll-gigi-lucia-reina/244755"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('bc397c9c-b58f-56fd-9ac4-e1bfa2f113ad', 'Vértigo x Barraca | Lilly Palmer', 'Evento publicado en Xceed. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-24T23:59:00+02:00', '2026-10-25T07:30:00+01:00', false, null,
  '85d20105-2d60-5581-a35f-aede6e416dbc', 'Barraca', null, 'Calle Les Palmeres, Sueca, Valencia', '', 'Sueca',
  'Valencia', 39.254649, -0.26666, 'source-coordinates', 'Sin clasificar', '{}'::text[], 9,
  'from', 'Entrada Grupal (5 Personas)', 'https://xceed.me/es/valencia/event/vertigo-x-barraca-lilly-palmer/235838', 'xceed', 'https://images.xceed.me/events/banners/vertigo-x-barraca-valencia-xceed-e20e.jpg?w=1920&h=1920&ar=1:1&fm=auto', 'groove',
  '18+', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'xceed:235838', '[{"label":"Xceed","url":"https://xceed.me/es/valencia/event/vertigo-x-barraca-lilly-palmer/235838"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.event_artists (event_id, entity_id, position) values ('bc397c9c-b58f-56fd-9ac4-e1bfa2f113ad', '1ea3f9fb-60bd-545f-ba3e-63cacf23edbf', 0);
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('8f87c1e2-fbb9-5498-b88b-34a0c01d3349', 'WE ARE GOING TO PARRANDA: HIT ME BABY', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-24T22:00:00.000Z', '2026-10-25T04:30:00.000Z', false, null,
  '91f2ebc6-3c7a-520c-a2d9-037b7d469d68', 'Havana Valencia', 'Canovas', 'Plaza Cánovas del Castillo, 6, 46005 Valencia (Valencia), España', 'LA GRAN VIA', 'València',
  'Valencia', 39.46783, -0.36564, 'source-coordinates', 'House', array['pop', 'hits', 'reggaeton', 'house']::text[], 12,
  'from', 'TICKET GENERAL ', 'https://site.fourvenues.com/es/havana-canovas/events/JG8V', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/8dd7aa59-844a-4d71-47bc-6e45af7dfe00/w=1350', 'groove',
  '24', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:h0zvxxq9goju5neu5vwy72n21kjiotry', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/nightlife-valencia"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/havana-canovas/events/JG8V"},{"label":"Fourvenues","url":"https://site.fourvenues.com/es/havana-canovas"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('e3dcea45-4900-56cc-9c94-9788cebd8ea7', 'PLAYA PALAPA: NOCHE ANIMAS', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-24T22:00:00.000Z', '2026-10-25T02:30:00.000Z', false, null,
  '726aaac7-561a-5edd-a55d-78f78013af54', 'Marina Beach Club', 'Marina Beach', 'C. Marina Real Juan Carlos I, s/n, 46011 Valencia, España', 'EL GRAU', 'València',
  'Valencia', 39.4629916, -0.3216705, 'source-coordinates', 'Sin clasificar', '{}'::text[], 10,
  'from', 'ENTRADA ANTICIPADA sin concumición.', 'https://site.fourvenues.com/es/marina-beach-club/events/5K2K', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/b7a927fc-234d-4bde-8539-9bb0f4c3c000/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:oglvj9y4j42becbkpfv3hq3ar8u2tk4l', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/marina-beach-club"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/marina-beach-club/events/5K2K"},{"label":"Marina Beach Club","url":"https://marinabeachclub.com/calendario-eventos/"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('d8bb790f-c99c-514a-aba1-16104423fc63', 'Miércoles Noche R144 | ERASMUS PARTY', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-27T23:30:00.000Z', '2026-10-29T06:30:00.000Z', false, 'La fuente publica una duración superior a 24 horas. Horario pendiente de contrastar.',
  'dc75fbbf-4710-5740-ab6c-520120ae0d33', 'Rumbo 144', 'Rumbo 144', 'Avenida Blasco Ibáñez, 144, 46022 Valencia (Valencia), España', 'CIUTAT JARDI', 'València',
  'Valencia', 39.47245, -0.3447, 'source-coordinates', 'Sin clasificar', '{}'::text[], 12,
  'from', 'OFERTA ENTRADA CON 1 COPA', 'https://site.fourvenues.com/es/rumbo144/events/KBVL', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/7d761883-0e26-44a1-872b-44d64c92f900/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:uyjagv3skr7vdxsa1j4aj73d84vkvdj3', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/nightlife-valencia"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/rumbo144/events/KBVL"},{"label":"Fourvenues","url":"https://site.fourvenues.com/es/rumbo144"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('74531e4d-79a8-54c6-ac4f-ec8abf11dfb6', 'MARINA: TARDE TARDEOS AL MAR', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-28T16:30:00.000Z', '2026-10-28T21:30:00.000Z', false, null,
  '726aaac7-561a-5edd-a55d-78f78013af54', 'Marina Beach Club', 'Marina Beach', 'C. Marina Real Juan Carlos I, s/n, 46011 Valencia, España', 'EL GRAU', 'València',
  'Valencia', 39.4629916, -0.3216705, 'source-coordinates', 'Sin clasificar', '{}'::text[], null,
  'unknown', 'Consultar entradas y disponibilidad en origen', 'https://site.fourvenues.com/es/marina-beach-club/events/BAWL', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/f58e536d-387b-4cc0-2902-97bc0d7fc300/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:sei67gp797mcdttqk46wk5wupbrj2upc', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/marina-beach-club"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/marina-beach-club/events/BAWL"},{"label":"Marina Beach Club","url":"https://marinabeachclub.com/calendario-eventos/"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('4269adc7-30c1-5328-91e3-a125e6ab1d25', 'MARINA: NOCHE JIPJOP CLOSING', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-28T21:30:00.000Z', '2026-10-29T02:30:00.000Z', false, null,
  '726aaac7-561a-5edd-a55d-78f78013af54', 'Marina Beach Club', 'Marina Beach', 'C. Marina Real Juan Carlos I, s/n, 46011 Valencia, España', 'EL GRAU', 'València',
  'Valencia', 39.4629916, -0.3216705, 'source-coordinates', 'Sin clasificar', '{}'::text[], 12,
  'from', 'ENTRADA ANTICIPADA  sin consumición.', 'https://site.fourvenues.com/es/marina-beach-club/events/YHUX', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/c6419799-814c-4a6e-f3a2-7d5b8b2f1200/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:g3yupb380rx4u8bxa97y81pnr4c3fokp', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/marina-beach-club"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/marina-beach-club/events/YHUX"},{"label":"Marina Beach Club","url":"https://marinabeachclub.com/calendario-eventos/"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('f4ddcc3e-49ad-5939-8b02-4f1137ff2d62', 'Jueves Noche R144 | HALLOWEEN UNIVERSITARIO', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-28T23:30:00.000Z', '2026-10-30T06:30:00.000Z', false, 'La fuente publica una duración superior a 24 horas. Horario pendiente de contrastar.',
  'dc75fbbf-4710-5740-ab6c-520120ae0d33', 'Rumbo 144', 'Rumbo 144', 'Avenida Blasco Ibáñez, 144, 46022 Valencia (Valencia), España', 'CIUTAT JARDI', 'València',
  'Valencia', 39.47245, -0.3447, 'source-coordinates', 'Sin clasificar', '{}'::text[], 12,
  'from', 'OFERTA ENTRADA CON 1 COPA', 'https://site.fourvenues.com/es/rumbo144/events/EHXB', 'fourvenues', null, 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:nsvhd1jjka1pns2mfo69b7k1htdjuiwj', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/nightlife-valencia"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/rumbo144/events/EHXB"},{"label":"Fourvenues","url":"https://site.fourvenues.com/es/rumbo144"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('b151eaf8-4b82-5a02-9923-f898d0ee96fa', 'MARINA: TARDE TARDEOS AL MAR', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-29T16:30:00.000Z', '2026-10-29T21:30:00.000Z', false, null,
  '726aaac7-561a-5edd-a55d-78f78013af54', 'Marina Beach Club', 'Marina Beach', 'C. Marina Real Juan Carlos I, s/n, 46011 Valencia, España', 'EL GRAU', 'València',
  'Valencia', 39.4629916, -0.3216705, 'source-coordinates', 'Sin clasificar', '{}'::text[], null,
  'unknown', 'Consultar entradas y disponibilidad en origen', 'https://site.fourvenues.com/es/marina-beach-club/events/SSVJ', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/f58e536d-387b-4cc0-2902-97bc0d7fc300/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:vjp2edskggvx2th64deqe1ltbqimp8ws', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/marina-beach-club"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/marina-beach-club/events/SSVJ"},{"label":"Marina Beach Club","url":"https://marinabeachclub.com/calendario-eventos/"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('e9bf4b94-c1f8-5d42-b94a-d128d55873a5', 'MARINA: NOCHE HITS CLOSING', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-29T21:30:00.000Z', '2026-10-30T02:30:00.000Z', false, null,
  '726aaac7-561a-5edd-a55d-78f78013af54', 'Marina Beach Club', 'Marina Beach', 'C. Marina Real Juan Carlos I, s/n, 46011 Valencia, España', 'EL GRAU', 'València',
  'Valencia', 39.4629916, -0.3216705, 'source-coordinates', 'Sin clasificar', '{}'::text[], 1,
  'from', 'ENTRADA ANTICIPADA sin consumición. ENTRANDO ANTES DE LAS 00:00H', 'https://site.fourvenues.com/es/marina-beach-club/events/PUQC', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/41933abf-719c-430b-75a4-e67eb01dfd00/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:jnfakzojjot43z5y1r2plqz8j763r3k9', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/marina-beach-club"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/marina-beach-club/events/PUQC"},{"label":"Marina Beach Club","url":"https://marinabeachclub.com/calendario-eventos/"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('674e3741-dcc6-5543-8f3b-5f7eddf4ba44', 'LOS JUEVES DE HAVANA x ESN | HALLOWEEKEND', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-29T23:00:00.000Z', '2026-10-30T05:30:00.000Z', false, null,
  '91f2ebc6-3c7a-520c-a2d9-037b7d469d68', 'Havana Valencia', 'Canovas', 'Plaza Cánovas del Castillo, 6, 46005 Valencia (Valencia), España', 'LA GRAN VIA', 'València',
  'Valencia', 39.46783, -0.36564, 'source-coordinates', 'House', array['pop', 'hits', 'reggaeton', 'house']::text[], 10,
  'from', 'TICKET GENERAL ', 'https://site.fourvenues.com/es/havana-canovas/events/VIOC', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/dc176498-e7a6-4269-392a-5e3fb07f1300/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:oltrwatk2vm9i04m53xgh21k279r55j5', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/nightlife-valencia"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/havana-canovas/events/VIOC"},{"label":"Fourvenues","url":"https://site.fourvenues.com/es/havana-canovas"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('6e0cbfa0-29b2-5bef-82cb-6e832ec3d0da', 'Viernes Noche R144 | HALLOWEEKEND', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-30T00:00:00.000Z', '2026-10-31T06:30:00.000Z', false, 'La fuente publica una duración superior a 24 horas. Horario pendiente de contrastar.',
  'dc75fbbf-4710-5740-ab6c-520120ae0d33', 'Rumbo 144', 'Rumbo 144', 'Avenida Blasco Ibáñez, 144, 46022 Valencia (Valencia), España', 'CIUTAT JARDI', 'València',
  'Valencia', 39.47245, -0.3447, 'source-coordinates', 'Sin clasificar', '{}'::text[], 12,
  'from', 'OFERTA ENTRADA CON 1 COPA', 'https://site.fourvenues.com/es/rumbo144/events/LG2I', 'fourvenues', null, 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:gknckwjgsftekloqfbno75sm8rl3cqqj', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/nightlife-valencia"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/rumbo144/events/LG2I"},{"label":"Fourvenues","url":"https://site.fourvenues.com/es/rumbo144"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('e0725f00-ebeb-58a3-a244-8cd68b5de27c', 'MARINA: TARDE TARDEOS AL MAR', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-30T16:30:00.000Z', '2026-10-30T21:30:00.000Z', false, null,
  '726aaac7-561a-5edd-a55d-78f78013af54', 'Marina Beach Club', 'Marina Beach', 'C. Marina Real Juan Carlos I, s/n, 46011 Valencia, España', 'EL GRAU', 'València',
  'Valencia', 39.4629916, -0.3216705, 'source-coordinates', 'Sin clasificar', '{}'::text[], null,
  'unknown', 'Consultar entradas y disponibilidad en origen', 'https://site.fourvenues.com/es/marina-beach-club/events/WH9W', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/f58e536d-387b-4cc0-2902-97bc0d7fc300/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:nvx1jdlx11v4tg4guo6y7kkfmiopl9da', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/marina-beach-club"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/marina-beach-club/events/WH9W"},{"label":"Marina Beach Club","url":"https://marinabeachclub.com/calendario-eventos/"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('09937c44-243b-5a53-9eaa-71aa2779d2c8', 'Deeplomat & Dublatov Live', 'Evento publicado en Xceed. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-30T20:30:00+01:00', '2026-10-30T23:00:00+01:00', false, null,
  '4b42156b-76dc-5243-8d85-6464efd681a0', 'HIFI Valencia', null, 'Calle Jesús 91, 46007', 'LA RAIOSA', 'València',
  'Valencia', 39.4616791, -0.3870305, 'source-coordinates', 'Sin clasificar', '{}'::text[], 8,
  'from', 'Deeplomat & Dublatov Live: dúo valenciano de musica electrónica basado en hardware', 'https://xceed.me/es/valencia/event/deeplomat-dublatov-live/247788', 'xceed', 'https://images.xceed.me/events/banners/deeplomat-dublatov-live-valencia-xceed-square-d220.png?w=1920&h=1920&ar=1:1&fm=auto', 'groove',
  null, 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'xceed:247788', '[{"label":"Xceed","url":"https://xceed.me/es/valencia/event/deeplomat-dublatov-live/247788"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('8021ccae-c537-57ce-ac43-68442fc764e0', '🎃 ВАЛЕНСИЯ, ГОТОВЫ К САМОЙ СТРАШНО ГЛАМУРНОЙ НОЧИ? 💜', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-30T21:00:00.000Z', '2026-10-31T02:30:00.000Z', false, null,
  'b748dfd3-edda-57df-b4d2-0b5736191f04', 'VELES E VENTS', 'VELES E VENTS', 'Edificio Veles e Vents La Marina de València, 46024 València, Valencia, España', 'EL GRAU', 'València',
  'Valencia', 39.4608845, -0.3240626, 'source-coordinates', 'Sin clasificar', '{}'::text[], 18,
  'from', '1ST RELEASE', 'https://site.fourvenues.com/es/veles-e-vents-eventos/events/8V7A', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/a6974351-9c64-4233-44c4-090c73dc2100/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:zpnm2kjahsv7spfea2zf0hsygpm50z3f', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/veles-e-vents-eventos"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/veles-e-vents-eventos/events/8V7A"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('05bbd9ca-c172-5df9-ae4d-8fc10648fff5', 'MARINA: NOCHE  ELIAS SAN MARTIN', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-30T21:30:00.000Z', '2026-10-31T02:30:00.000Z', false, null,
  '726aaac7-561a-5edd-a55d-78f78013af54', 'Marina Beach Club', 'Marina Beach', 'C. Marina Real Juan Carlos I, s/n, 46011 Valencia, España', 'EL GRAU', 'València',
  'Valencia', 39.4629916, -0.3216705, 'source-coordinates', 'Sin clasificar', '{}'::text[], 12,
  'from', 'ENTRADA ANTICIPADA  con consumición.', 'https://site.fourvenues.com/es/marina-beach-club/events/EUTX', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/c52119ec-45f4-4460-f4fe-8698d6402400/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:jdxd8y6pows464ozvg9mnkbcndvjhpu9', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/marina-beach-club"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/marina-beach-club/events/EUTX"},{"label":"Marina Beach Club","url":"https://marinabeachclub.com/calendario-eventos/"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('936757cf-bf32-53ea-bf5e-3b56879c02e5', '30/10 - HALLOWEEN w/ CHZTER (SHOWCASE) + CABRA + ELNUEVE!', 'Evento publicado en Xceed. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-30T23:30:00+01:00', '2026-10-31T07:00:00+01:00', false, null,
  '3b708a01-87d9-5829-ad72-b123a9669368', 'ROTO CLUB', null, 'Av. d''Ausiàs March, 18', 'MALILLA', 'València',
  'Valencia', 39.454988, -0.3748483, 'source-coordinates', 'Sin clasificar', '{}'::text[], 10,
  'from', 'ANTICIPADA 10€', 'https://xceed.me/es/valencia/event/30-10-halloween-w-chzter-showcase-cabra-elnueve/244756', 'xceed', 'https://images.xceed.me/events/banners/30-10-halloween-w-chzster-showcase-cabra-elnueve-valencia-xceed-square-be7b.jpg?w=1920&h=1920&ar=1:1&fm=auto', 'groove',
  '18+', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'xceed:244756', '[{"label":"Xceed","url":"https://xceed.me/es/valencia/event/30-10-halloween-w-chzter-showcase-cabra-elnueve/244756"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.event_artists (event_id, entity_id, position) values ('936757cf-bf32-53ea-bf5e-3b56879c02e5', '817c6ccc-bc99-5529-b4be-bf883240e963', 0);
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('be57d88d-f726-5ae0-a30e-054742f8d05a', 'PRE HALLOWEEN - SCARY HITS', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-30T23:00:00.000Z', '2026-10-31T05:30:00.000Z', false, null,
  '91f2ebc6-3c7a-520c-a2d9-037b7d469d68', 'Havana Valencia', 'Canovas', 'Plaza Cánovas del Castillo, 6, 46005 Valencia (Valencia), España', 'LA GRAN VIA', 'València',
  'Valencia', 39.46783, -0.36564, 'source-coordinates', 'House', array['pop', 'hits', 'reggaeton', 'house']::text[], 12,
  'from', 'TICKET GENERAL ', 'https://site.fourvenues.com/es/havana-canovas/events/ZTWK', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/8dd7aa59-844a-4d71-47bc-6e45af7dfe00/w=1350', 'groove',
  '21', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:bdp964jb4qz4gar2pd1gxlci0wdzwq4p', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/nightlife-valencia"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/havana-canovas/events/ZTWK"},{"label":"Fourvenues","url":"https://site.fourvenues.com/es/havana-canovas"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('3787404d-4474-5cd4-b9de-56db000852eb', 'HALLOWEEN AFRODISIAK - ÁTICO', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-31T15:30:00.000Z', '2026-11-01T03:30:00.000Z', false, null,
  'b748dfd3-edda-57df-b4d2-0b5736191f04', 'VELES E VENTS', 'VELES E VENTS', 'Edificio Veles e Vents La Marina de València, 46024 València, Valencia, España', 'EL GRAU', 'València',
  'Valencia', 39.4608845, -0.3240626, 'source-coordinates', 'House', array['house', 'afro-house', 'tech-house']::text[], 12,
  'from', 'GENERAL TICKET ', 'https://site.fourvenues.com/es/veles-e-vents-eventos/events/5QH7', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/3ad7b13a-135d-4981-6d26-be706a61be00/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:hbmksosn6gicri9fmm6nag8tb06m2ltt', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/nightlife-valencia"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/veles-e-vents-eventos/events/5QH7"},{"label":"Fourvenues","url":"https://site.fourvenues.com/es/veles-e-vents-eventos"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('09ba19ab-4176-57ef-9470-f192f0e07822', 'TARDEOS SÓLO HITS - HALLOWEEN', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-31T16:00:00.000Z', '2026-10-31T22:30:00.000Z', false, null,
  '91f2ebc6-3c7a-520c-a2d9-037b7d469d68', 'Havana Valencia', 'Canovas', 'Plaza Cánovas del Castillo, 6, 46005 Valencia (Valencia), España', 'LA GRAN VIA', 'València',
  'Valencia', 39.46783, -0.36564, 'source-coordinates', 'House', array['pop', 'house', 'comercial', 'hits']::text[], 10,
  'from', 'TICKET GENERAL ', 'https://site.fourvenues.com/es/havana-canovas/events/J3S3', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/b5ff087b-61be-45b0-5fbb-9ca8ea704d00/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:i8pb9wke3j159arhh6x0i6g9dmfhb3zs', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/nightlife-valencia"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/havana-canovas/events/J3S3"},{"label":"Fourvenues","url":"https://site.fourvenues.com/es/havana-canovas"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('de933678-fa70-5fca-997e-309df817633b', 'Tardeo Sábado | FUNK FARRONES en Concierto', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-31T16:00:00.000Z', '2026-10-31T22:45:00.000Z', false, null,
  'dc75fbbf-4710-5740-ab6c-520120ae0d33', 'Rumbo 144', 'Rumbo 144', 'Avenida Blasco Ibáñez, 144, 46022 Valencia (Valencia), España', 'CIUTAT JARDI', 'València',
  'Valencia', 39.47245, -0.3447, 'source-coordinates', 'En directo', array['indie', 'rock', 'pop']::text[], 5,
  'from', 'Entrada CONCIERTO y TARDEO', 'https://site.fourvenues.com/es/rumbo144/events/KHL9', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/3429a49d-f046-440a-3010-2d87c30f8b00/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:vuhavr42h3y1klg68gojo3pdt3atax48', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/nightlife-valencia"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/rumbo144/events/KHL9"},{"label":"Fourvenues","url":"https://site.fourvenues.com/es/rumbo144"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('338f822b-494d-55de-8aec-631bf14f2ade', 'Halloween | Barraca & theBasement', 'Evento publicado en Xceed. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-31T17:00:00+01:00', '2026-11-01T08:00:00+01:00', false, null,
  '85d20105-2d60-5581-a35f-aede6e416dbc', 'Barraca', null, 'Calle Les Palmeres, Sueca, Valencia', '', 'Sueca',
  'Valencia', 39.254649, -0.26666, 'source-coordinates', 'Sin clasificar', '{}'::text[], 12.5,
  'from', 'HALLOWEEN PROMO GRUPOS 4 X 3', 'https://xceed.me/es/valencia/event/halloween-barraca-thebasement/241177', 'xceed', 'https://images.xceed.me/events/banners/halloween-barraca-thebasement-valencia-xceed-square-3091.jpg?w=1920&h=1920&ar=1:1&fm=auto', 'groove',
  '18+', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'xceed:241177', '[{"label":"Xceed","url":"https://xceed.me/es/valencia/event/halloween-barraca-thebasement/241177"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.event_artists (event_id, entity_id, position) values ('338f822b-494d-55de-8aec-631bf14f2ade', 'a8c34e8a-e323-5250-a66a-e6ebb9ff0bf9', 0);
insert into public.event_artists (event_id, entity_id, position) values ('338f822b-494d-55de-8aec-631bf14f2ade', '89a5bea0-c7cb-5f69-840e-7c7480723b9e', 1);
insert into public.event_artists (event_id, entity_id, position) values ('338f822b-494d-55de-8aec-631bf14f2ade', '2be7d40d-bd36-543e-9ed7-b3f8d11fd15a', 2);
insert into public.event_artists (event_id, entity_id, position) values ('338f822b-494d-55de-8aec-631bf14f2ade', '2d8f5d1d-db5c-5735-989b-e11e80fbf59d', 3);
insert into public.event_artists (event_id, entity_id, position) values ('338f822b-494d-55de-8aec-631bf14f2ade', 'bb27b34a-2f6d-5f0d-ad62-c96b502095f0', 4);
insert into public.event_artists (event_id, entity_id, position) values ('338f822b-494d-55de-8aec-631bf14f2ade', '3171c5a6-5684-55ca-9b56-3b0b495b4c59', 5);
insert into public.event_artists (event_id, entity_id, position) values ('338f822b-494d-55de-8aec-631bf14f2ade', '4ccfef75-16ab-522d-a3b9-6529f109dc94', 6);
insert into public.event_artists (event_id, entity_id, position) values ('338f822b-494d-55de-8aec-631bf14f2ade', '842a2cfa-7210-50db-aa2c-30b0c883628b', 7);
insert into public.event_artists (event_id, entity_id, position) values ('338f822b-494d-55de-8aec-631bf14f2ade', '92d75c1f-8808-5d6a-adac-94f3c5cad9a0', 8);
insert into public.event_artists (event_id, entity_id, position) values ('338f822b-494d-55de-8aec-631bf14f2ade', 'f1e8ba91-1d93-53bd-970a-4c4b61aa2035', 9);
insert into public.event_artists (event_id, entity_id, position) values ('338f822b-494d-55de-8aec-631bf14f2ade', '81700985-74c9-5933-adc1-be7d1f51d9b0', 10);
insert into public.event_artists (event_id, entity_id, position) values ('338f822b-494d-55de-8aec-631bf14f2ade', '103fe896-1718-56c5-bda8-c745b25287ba', 11);
insert into public.event_artists (event_id, entity_id, position) values ('338f822b-494d-55de-8aec-631bf14f2ade', '6ceefd11-cd3f-59fe-a6b9-9aac18acd348', 12);
insert into public.event_artists (event_id, entity_id, position) values ('338f822b-494d-55de-8aec-631bf14f2ade', '69e12d48-9832-5efd-95cf-3b0498cc8c7f', 13);
insert into public.event_artists (event_id, entity_id, position) values ('338f822b-494d-55de-8aec-631bf14f2ade', 'e2a1578e-5714-551d-b3d5-24a052ba308c', 14);
insert into public.event_artists (event_id, entity_id, position) values ('338f822b-494d-55de-8aec-631bf14f2ade', 'ce9bc856-c52c-5eb9-9fb6-985066389943', 15);
insert into public.event_artists (event_id, entity_id, position) values ('338f822b-494d-55de-8aec-631bf14f2ade', 'd6a87e3f-59a8-55c8-85a4-ddd50d5ebb74', 16);
insert into public.event_artists (event_id, entity_id, position) values ('338f822b-494d-55de-8aec-631bf14f2ade', 'f1acca12-1364-5a62-98ae-3dad4fbe682e', 17);
insert into public.event_artists (event_id, entity_id, position) values ('338f822b-494d-55de-8aec-631bf14f2ade', '710bb82a-cb36-503d-b410-5de207d7727b', 18);
insert into public.event_artists (event_id, entity_id, position) values ('338f822b-494d-55de-8aec-631bf14f2ade', '4cce3d20-feb9-5e78-91e3-b77c7a0643a6', 19);
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('d9053db0-3409-57d6-99d8-105e7cc635f7', 'MARINA: TARDE Y NOCHE HALLOWEEN FREYJA - LUIGI NIETO - SALDIVAR', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-31T20:00:00.000Z', '2026-11-01T04:00:00.000Z', false, null,
  '726aaac7-561a-5edd-a55d-78f78013af54', 'Marina Beach Club', 'Marina Beach', 'C. Marina Real Juan Carlos I, s/n, 46011 Valencia, España', 'EL GRAU', 'València',
  'Valencia', 39.4629916, -0.3216705, 'source-coordinates', 'Sin clasificar', '{}'::text[], 15,
  'from', 'ENTRADA ANTICIPADA sin consumición. ENTRANDO ANTES DE LAS 22:30h', 'https://site.fourvenues.com/es/marina-beach-club/events/6TF1', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/224af1b6-0296-482f-c362-f151eaf8b500/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:gg42230jp5349ze4fl55m9t5189d0bns', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/marina-beach-club"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/marina-beach-club/events/6TF1"},{"label":"Marina Beach Club","url":"https://marinabeachclub.com/calendario-eventos/"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('65f6646b-9fc3-5cde-a9f0-ff91b94eae24', 'ERASMUS HALLOWEEN', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-31T22:00:00.000Z', '2026-11-01T03:30:00.000Z', true, null,
  'b748dfd3-edda-57df-b4d2-0b5736191f04', 'VELES E VENTS', 'VELES E VENTS', 'Edificio Veles e Vents La Marina de València, 46024 València, Valencia, España', 'EL GRAU', 'València',
  'Valencia', 39.4608845, -0.3240626, 'source-coordinates', 'Sin clasificar', '{}'::text[], 12,
  'from', 'PROMO ', 'https://site.fourvenues.com/es/veles-e-vents-eventos/events/PX4U', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/397c85db-b905-4c43-be94-8df5dc7ad000/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:oh4es70d55iurvrs610ncktrd67f6m17', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/nightlife-valencia"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/veles-e-vents-eventos/events/PX4U"},{"label":"Fourvenues","url":"https://site.fourvenues.com/es/veles-e-vents-eventos"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('68a509e9-01e1-5ce1-9236-141aa5c65177', 'Halloween: Cassie Raptor + DYEN + A.N.I. & Total w/ Ines Isla & Special-k w/ Laia + Sugar Free', 'Evento publicado en Xceed. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-31T23:00:00+01:00', '2026-11-01T08:00:00+01:00', false, null,
  'cbe949b0-364d-5edf-a75d-8aab698e3a41', 'Spook Club', null, 'Carretera del Rio, 399, Pinedo', 'PINEDO', 'València',
  'Valencia', 39.410901, -0.33605499999999, 'source-coordinates', 'Sin clasificar', '{}'::text[], 45,
  'from', 'últimos tickets', 'https://xceed.me/es/valencia/event/halloween-cassie-raptor-dyen-ani-total-w-ines-isla-special-k-w-laia-sugar-free/240814', 'xceed', 'https://images.xceed.me/events/banners/halloween-cassie-raptor-dyen-ani-total-w-ines-isla-special-k-w-laia-sugar-free-valencia-xceed-square-c947.jpg?w=1920&h=1920&ar=1:1&fm=auto', 'groove',
  '18+', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'xceed:240814', '[{"label":"Xceed","url":"https://xceed.me/es/valencia/event/halloween-cassie-raptor-dyen-ani-total-w-ines-isla-special-k-w-laia-sugar-free/240814"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.event_artists (event_id, entity_id, position) values ('68a509e9-01e1-5ce1-9236-141aa5c65177', '1ac304f6-6b70-5593-ac53-18885ed43b6d', 0);
insert into public.event_artists (event_id, entity_id, position) values ('68a509e9-01e1-5ce1-9236-141aa5c65177', 'f0edcc13-6afc-5f78-8802-4fa58d0c1cee', 1);
insert into public.event_artists (event_id, entity_id, position) values ('68a509e9-01e1-5ce1-9236-141aa5c65177', 'ca35afc1-6d19-5c38-9bf5-e041583f5ee1', 2);
insert into public.event_artists (event_id, entity_id, position) values ('68a509e9-01e1-5ce1-9236-141aa5c65177', '4a6c9ea1-2b18-5b76-ae6b-c88744df661e', 3);
insert into public.event_artists (event_id, entity_id, position) values ('68a509e9-01e1-5ce1-9236-141aa5c65177', '40b5dc2b-ff20-586c-8831-cd822b2de717', 4);
insert into public.event_artists (event_id, entity_id, position) values ('68a509e9-01e1-5ce1-9236-141aa5c65177', 'fb58c7b1-61f3-5b0e-af44-27e795285cde', 5);
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('d908a96b-2e9c-5f89-8e06-be4ede5e3e51', 'HALLOWEEN | PORT ELECTRONIC | AFTER ROW', 'Evento publicado en Xceed. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-31T23:00:00+01:00', '2026-11-01T07:30:00+01:00', false, null,
  'd92928f1-5f3b-5d43-a03b-d62591ef5e12', 'Cocoa Beach Club', null, 'Av. Mediterraneo, 44 Puerto De Sagunto', '', 'Sagunt',
  'Valencia', 39.6601318, -0.21153419999996, 'source-coordinates', 'Sin clasificar', '{}'::text[], 19,
  'from', 'PACK 4x3', 'https://xceed.me/es/valencia/event/halloween-port-electronic-after-row/243575', 'xceed', 'https://images.xceed.me/events/banners/halloween-port-electronic-after-row-valencia-xceed-17d9.jpg?w=1920&h=1920&ar=1:1&fm=auto', 'groove',
  '18+', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'xceed:243575', '[{"label":"Xceed","url":"https://xceed.me/es/valencia/event/halloween-port-electronic-after-row/243575"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('fb55da7c-f4ba-5d21-a1bb-0c43716a6d5f', 'Sábado 31/10 HALLOWEEN en PICCA', 'Evento publicado en Xceed. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-31T23:00:00+01:00', '2026-11-01T06:00:00+01:00', false, null,
  '3618cea4-5a50-53a2-803d-a95a3cd04084', 'PICCA', null, 'Carrer dels Tomassos, 14', 'RUSSAFA', 'València',
  'Valencia', 39.461619, -0.37232700000004, 'source-coordinates', 'Sin clasificar', '{}'::text[], 10,
  'from', 'ANTICIPADA 10€', 'https://xceed.me/es/valencia/event/sabado-31-10-halloween-en-picca/244473', 'xceed', 'https://images.xceed.me/events/banners/sabado-31-10-halloween-en-picca-valencia-xceed-square-83c1.jpg?w=1920&h=1920&ar=1:1&fm=auto', 'groove',
  '18+', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'xceed:244473', '[{"label":"Xceed","url":"https://xceed.me/es/valencia/event/sabado-31-10-halloween-en-picca/244473"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('4b1f193e-8a23-53e2-b277-d1f0f1368753', '31/10 - HALLOWEEN w/ DISOBEY SOUND SYSTEM + ROOMTRASH', 'Evento publicado en Xceed. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-31T23:30:00+01:00', '2026-11-01T07:00:00+01:00', false, null,
  '3b708a01-87d9-5829-ad72-b123a9669368', 'ROTO CLUB', null, 'Av. d''Ausiàs March, 18', 'MALILLA', 'València',
  'Valencia', 39.454988, -0.3748483, 'source-coordinates', 'Sin clasificar', '{}'::text[], 25,
  'from', 'ANTICIPADA 25€', 'https://xceed.me/es/valencia/event/31-10-halloween-w-disobey-sound-system-roomtrash/244757', 'xceed', 'https://images.xceed.me/events/banners/30-10-halloween-w-chzster-showcase-cabra-elnueve-valencia-xceed-square-be7b.jpg?w=1920&h=1920&ar=1:1&fm=auto', 'groove',
  '18+', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'xceed:244757', '[{"label":"Xceed","url":"https://xceed.me/es/valencia/event/31-10-halloween-w-disobey-sound-system-roomtrash/244757"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.event_artists (event_id, entity_id, position) values ('4b1f193e-8a23-53e2-b277-d1f0f1368753', '5c448e67-fa17-54e1-af10-fcb8f7a6f696', 0);
insert into public.event_artists (event_id, entity_id, position) values ('4b1f193e-8a23-53e2-b277-d1f0f1368753', '21c922b1-4544-5e4d-8290-2be9968ee916', 1);
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('0f762e79-223d-51e1-a984-13b8327e2f02', 'SÁBADO 31 | HALLOWEEN EN LA3 | TUTI + 17BEATS + CENCII', 'Evento publicado en Xceed. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-31T23:59:00+01:00', '2026-11-01T07:00:00+01:00', false, null,
  '9f967428-1d45-565d-ad58-d9f65a8604ee', 'La3', null, 'Avenida Blasco Ibanez 111', 'CIUTAT JARDI', 'València',
  'Valencia', 39.473577, -0.34458459999996, 'source-coordinates', 'Sin clasificar', '{}'::text[], 25,
  'from', 'Entrada', 'https://xceed.me/es/valencia/event/sabado-31-halloween-en-la3-tuti-17beats-cencii/245446', 'xceed', 'https://images.xceed.me/events/banners/sabado-31-halloween-en-la3-tuti-17beats-cencii-valencia-xceed-square-9c8d.png?w=1920&h=1920&ar=1:1&fm=auto', 'groove',
  '18+', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'xceed:245446', '[{"label":"Xceed","url":"https://xceed.me/es/valencia/event/sabado-31-halloween-en-la3-tuti-17beats-cencii/245446"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.event_artists (event_id, entity_id, position) values ('0f762e79-223d-51e1-a984-13b8327e2f02', '086d9781-3463-531e-8e33-96792e9bb4c2', 0);
insert into public.event_artists (event_id, entity_id, position) values ('0f762e79-223d-51e1-a984-13b8327e2f02', 'e561a33b-218d-5fc8-a8b8-ef21b116f795', 1);
insert into public.event_artists (event_id, entity_id, position) values ('0f762e79-223d-51e1-a984-13b8327e2f02', '6bbedc6e-0ab2-5657-9392-d026d3a8a0dc', 2);
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('aa63c502-b6ff-594a-8da5-2edcb912f84b', 'HALLOWPINK - ESPECIAL HALLOWEEN', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-31T23:30:00.000Z', '2026-11-01T06:30:00.000Z', false, null,
  '91f2ebc6-3c7a-520c-a2d9-037b7d469d68', 'Havana Valencia', 'Canovas', 'Plaza Cánovas del Castillo, 6, 46005 Valencia (Valencia), España', 'LA GRAN VIA', 'València',
  'Valencia', 39.46783, -0.36564, 'source-coordinates', 'House', array['pop', 'hits', 'reggaeton', 'house']::text[], 15,
  'from', 'TICKET GENERAL ', 'https://site.fourvenues.com/es/havana-canovas/events/K7ET', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/7b4cd9fa-743c-4924-ab3c-a02f3fa9f500/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:k4yu0fn23vmi2laglyh6k80cvgyd1d7v', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/nightlife-valencia"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/havana-canovas/events/K7ET"},{"label":"Fourvenues","url":"https://site.fourvenues.com/es/havana-canovas"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('c87144c9-8a12-5b6a-9d23-5355a3abe66a', 'HALLOWEEN Rumbo144', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-10-31T23:45:00.000Z', '2026-11-01T06:30:00.000Z', false, null,
  'dc75fbbf-4710-5740-ab6c-520120ae0d33', 'Rumbo 144', 'Rumbo 144', 'Avenida Blasco Ibáñez, 144, 46022 Valencia (Valencia), España', 'CIUTAT JARDI', 'València',
  'Valencia', 39.47245, -0.3447, 'source-coordinates', 'Sin clasificar', '{}'::text[], 25,
  'from', 'ENTRADA CON 1 COPA', 'https://site.fourvenues.com/es/rumbo144/events/M2W7', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/eb48e4b5-5e07-43a8-ed08-a5792e4f8500/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:fhuq25tx97elwkb60ej24llu9j23trg7', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/nightlife-valencia"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/rumbo144/events/M2W7"},{"label":"Fourvenues","url":"https://site.fourvenues.com/es/rumbo144"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('650a60c4-4323-5da2-afed-cd4998bc17b8', 'PLAYA PALAPA: NOCHE KATHY K', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-11-06T21:30:00.000Z', '2026-11-07T02:30:00.000Z', false, null,
  '726aaac7-561a-5edd-a55d-78f78013af54', 'Marina Beach Club', 'Marina Beach', 'C. Marina Real Juan Carlos I, s/n, 46011 Valencia, España', 'EL GRAU', 'València',
  'Valencia', 39.4629916, -0.3216705, 'source-coordinates', 'Sin clasificar', '{}'::text[], 10,
  'from', 'ENTRADA ANTICIPADA sin consumición', 'https://site.fourvenues.com/es/marina-beach-club/events/OIYV', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/23b1ff7f-e8d4-40cf-5ab4-d0d6e9dda400/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:leuvcj6l5anfoe41khvogrfc0zix64nx', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/marina-beach-club"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/marina-beach-club/events/OIYV"},{"label":"Marina Beach Club","url":"https://marinabeachclub.com/calendario-eventos/"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('b170790b-4038-5709-9730-b99a7cd33fbb', 'House Arena presented by ELENCO & THEBASEMENT', 'Evento publicado en Xceed. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-11-07T15:00:00+01:00', '2026-11-08T01:00:00+01:00', false, null,
  '258c3ba4-fb0d-5980-ac34-b92ff9ee893a', 'Roig Arena', null, 'C/ del Bomber Ramon Duart, 12, Quatre Carreres, 46013', 'CIUTAT DE LES ARTS I DE LES CIENCIES', 'València',
  'Valencia', 39.4490862, -0.3642708, 'source-coordinates', 'Sin clasificar', '{}'::text[], 35,
  'from', 'Third Release', 'https://xceed.me/es/valencia/event/house-arena-presented-by-elenco-thebasement/245828', 'xceed', 'https://images.xceed.me/events/banners/house-arena-presented-by-elenco-thebasement-valencia-xceed-square-16f5.png?w=1920&h=1920&ar=1:1&fm=auto', 'groove',
  '18+', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'xceed:245828', '[{"label":"Xceed","url":"https://xceed.me/es/valencia/event/house-arena-presented-by-elenco-thebasement/245828"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.event_artists (event_id, entity_id, position) values ('b170790b-4038-5709-9730-b99a7cd33fbb', 'e8474119-02f7-5273-8bc1-48caa65a9c0f', 0);
insert into public.event_artists (event_id, entity_id, position) values ('b170790b-4038-5709-9730-b99a7cd33fbb', 'ca7fc685-71b8-53b8-86f3-37bb9cd0afa9', 1);
insert into public.event_artists (event_id, entity_id, position) values ('b170790b-4038-5709-9730-b99a7cd33fbb', 'e46bd73e-bf76-54d2-a91c-e46bdf894ddc', 2);
insert into public.event_artists (event_id, entity_id, position) values ('b170790b-4038-5709-9730-b99a7cd33fbb', 'c6c1d288-52cb-5511-80d0-67421473ae05', 3);
insert into public.event_artists (event_id, entity_id, position) values ('b170790b-4038-5709-9730-b99a7cd33fbb', '077d5842-1c9b-5acd-9a30-e7c9d1366a9c', 4);
insert into public.event_artists (event_id, entity_id, position) values ('b170790b-4038-5709-9730-b99a7cd33fbb', '4cce3d20-feb9-5e78-91e3-b77c7a0643a6', 5);
insert into public.event_artists (event_id, entity_id, position) values ('b170790b-4038-5709-9730-b99a7cd33fbb', 'a8c34e8a-e323-5250-a66a-e6ebb9ff0bf9', 6);
insert into public.event_artists (event_id, entity_id, position) values ('b170790b-4038-5709-9730-b99a7cd33fbb', 'bb27b34a-2f6d-5f0d-ad62-c96b502095f0', 7);
insert into public.event_artists (event_id, entity_id, position) values ('b170790b-4038-5709-9730-b99a7cd33fbb', '4289771f-47cb-5a26-af43-e56ddc1fafc4', 8);
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('528b3bd4-2ed3-51cd-a9c2-a2969183cd22', 'MARINA: TARDE Y NOCHE MATINAL', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-11-07T15:30:00.000Z', '2026-11-08T02:30:00.000Z', false, null,
  '726aaac7-561a-5edd-a55d-78f78013af54', 'Marina Beach Club', 'Marina Beach', 'C. Marina Real Juan Carlos I, s/n, 46011 Valencia, España', 'EL GRAU', 'València',
  'Valencia', 39.4629916, -0.3216705, 'source-coordinates', 'Sin clasificar', '{}'::text[], 1,
  'from', 'ENTRADA GRATUITA ENTRANDO ANTES DE LAS 17:30H', 'https://site.fourvenues.com/es/marina-beach-club/events/G4NU', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/85bdfcb3-2a05-491e-116b-fa68a7372700/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:pnbuj2fukkdmgfhw5o0rwfcaysnrm8x3', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/marina-beach-club"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/marina-beach-club/events/G4NU"},{"label":"Marina Beach Club","url":"https://marinabeachclub.com/calendario-eventos/"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('a07e476e-47ff-5cd5-93bd-17b1d1a618de', 'Tarde_On Indie | LA PLAYLIST en Concierto', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-11-07T16:00:00.000Z', '2026-11-07T22:45:00.000Z', false, null,
  'dc75fbbf-4710-5740-ab6c-520120ae0d33', 'Rumbo 144', 'Rumbo 144', 'Avenida Blasco Ibáñez, 144, 46022 Valencia (Valencia), España', 'CIUTAT JARDI', 'València',
  'Valencia', 39.47245, -0.3447, 'source-coordinates', 'En directo', array['indie', 'rock', 'pop']::text[], 5,
  'from', 'Entrada CONCIERTO y TARDEO', 'https://site.fourvenues.com/es/rumbo144/events/6EQT', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/af473d15-7247-4a1e-18bc-05236ad05a00/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:vi0zqavkap65qadazis39tkigyj7m4kx', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/nightlife-valencia"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/rumbo144/events/6EQT"},{"label":"Fourvenues","url":"https://site.fourvenues.com/es/rumbo144"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('138f8f12-7963-501e-8a78-cbf01f746d3b', 'Tardeo Sábado | LOS RADIADORES en Concierto', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-11-07T16:00:00.000Z', '2026-11-07T22:45:00.000Z', false, null,
  'dc75fbbf-4710-5740-ab6c-520120ae0d33', 'Rumbo 144', 'Rumbo 144', 'Avenida Blasco Ibáñez, 144, 46022 Valencia (Valencia), España', 'CIUTAT JARDI', 'València',
  'Valencia', 39.47245, -0.3447, 'source-coordinates', 'En directo', array['indie', 'rock', 'pop']::text[], 5,
  'from', 'Entrada CONCIERTO y TARDEO', 'https://site.fourvenues.com/es/rumbo144/events/SWI4', 'fourvenues', null, 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:kkyl0alzjndelpzpjz81y1ew6so50ehm', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/nightlife-valencia"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/rumbo144/events/SWI4"},{"label":"Fourvenues","url":"https://site.fourvenues.com/es/rumbo144"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('51e800f6-ab39-5628-bcd2-1c9303b429e8', 'PLAYA PALAPA: TARDE Y NOCHE ELBIO & DENNIS', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-11-07T17:30:00.000Z', '2026-11-08T02:30:00.000Z', false, null,
  '726aaac7-561a-5edd-a55d-78f78013af54', 'Marina Beach Club', 'Marina Beach', 'C. Marina Real Juan Carlos I, s/n, 46011 Valencia, España', 'EL GRAU', 'València',
  'Valencia', 39.4629916, -0.3216705, 'source-coordinates', 'Sin clasificar', '{}'::text[], 10,
  'from', 'ENTRADA ANTICIPADA sin concumición', 'https://site.fourvenues.com/es/marina-beach-club/events/PM3I', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/65648b1f-8043-493d-b487-4d1aee47dd00/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:xghbok8y4wdtvnaxupajfzix8devbnxb', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/marina-beach-club"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/marina-beach-club/events/PM3I"},{"label":"Marina Beach Club","url":"https://marinabeachclub.com/calendario-eventos/"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('3b941a55-6015-5324-839d-384ea749682c', 'SPOOK presents Héctor Oaks all night long (La Línea De La Vida) + Egyptian Lover', 'Evento publicado en Xceed. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-11-07T23:00:00+01:00', '2026-11-08T07:30:00+01:00', false, null,
  'cbe949b0-364d-5edf-a75d-8aab698e3a41', 'Spook Club', null, 'Carretera del Rio, 399, Pinedo', 'PINEDO', 'València',
  'Valencia', 39.410901, -0.33605499999999, 'source-coordinates', 'Sin clasificar', '{}'::text[], 30,
  'from', 'TICKET - TRAMO 2', 'https://xceed.me/es/valencia/event/spook-presents-hector-oaks-all-night-long-la-linea-de-la-vida-egyptian-lover-1/241967', 'xceed', 'https://images.xceed.me/events/banners/spook-presents-hector-oaks-all-night-long-la-linea-de-la-vida-egyptian-lover-1-valencia-xceed-square-8f69.jpg?w=1920&h=1920&ar=1:1&fm=auto', 'groove',
  '18+', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'xceed:241967', '[{"label":"Xceed","url":"https://xceed.me/es/valencia/event/spook-presents-hector-oaks-all-night-long-la-linea-de-la-vida-egyptian-lover-1/241967"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.event_artists (event_id, entity_id, position) values ('3b941a55-6015-5324-839d-384ea749682c', '64225be8-2c65-5020-b316-0a77deed07ac', 0);
insert into public.event_artists (event_id, entity_id, position) values ('3b941a55-6015-5324-839d-384ea749682c', 'f72316e4-b058-500e-87c9-e06869f186ab', 1);
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('5bf3ea97-5411-5c74-94ba-47f55d2f0d51', 'PLAYA PALAPA: NOCHE DE LA SUR', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-11-13T21:30:00.000Z', '2026-11-14T02:30:00.000Z', false, null,
  '726aaac7-561a-5edd-a55d-78f78013af54', 'Marina Beach Club', 'Marina Beach', 'C. Marina Real Juan Carlos I, s/n, 46011 Valencia, España', 'EL GRAU', 'València',
  'Valencia', 39.4629916, -0.3216705, 'source-coordinates', 'Sin clasificar', '{}'::text[], 10,
  'from', 'ENTRADA  ANTICIPADA  sin consumición', 'https://site.fourvenues.com/es/marina-beach-club/events/OFF2', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/d7a73a75-407a-48ca-f492-628956394b00/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:wqtsbexils5otsivvxmhhd9g9ajs5c1a', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/marina-beach-club"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/marina-beach-club/events/OFF2"},{"label":"Marina Beach Club","url":"https://marinabeachclub.com/calendario-eventos/"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('ba13ab90-30fc-5b75-b66d-9efc9eaa3137', 'MARINA: TARDE Y NOCHE FRANKY RIZARDO', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-11-14T15:30:00.000Z', '2026-11-15T02:30:00.000Z', false, null,
  '726aaac7-561a-5edd-a55d-78f78013af54', 'Marina Beach Club', 'Marina Beach', 'C. Marina Real Juan Carlos I, s/n, 46011 Valencia, España', 'EL GRAU', 'València',
  'Valencia', 39.4629916, -0.3216705, 'source-coordinates', 'Sin clasificar', '{}'::text[], 36,
  'from', 'ENTRADA ANTICIPADA con consumición ENTRANDO ANTES DE LAS 18:00H', 'https://site.fourvenues.com/es/marina-beach-club/events/TLS0', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/2e08bfb8-8b2c-49aa-3472-8e00c1bd2700/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:gwqmr43sjfcvli6w3lmjcbdo49hlhzm4', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/marina-beach-club"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/marina-beach-club/events/TLS0"},{"label":"Marina Beach Club","url":"https://marinabeachclub.com/calendario-eventos/"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('fd5ca4ef-cc9c-5e46-93d9-75c9694ae5b6', 'TARDE_ON INDIE | LOS IMPRESCINDIBLES en Concierto', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-11-14T16:00:00.000Z', '2026-11-14T22:45:00.000Z', false, null,
  'dc75fbbf-4710-5740-ab6c-520120ae0d33', 'Rumbo 144', 'Rumbo 144', 'Avenida Blasco Ibáñez, 144, 46022 Valencia (Valencia), España', 'CIUTAT JARDI', 'València',
  'Valencia', 39.47245, -0.3447, 'source-coordinates', 'En directo', array['indie', 'rock', 'pop']::text[], 5,
  'from', 'Entrada CONCIERTO y TARDEO', 'https://site.fourvenues.com/es/rumbo144/events/ADTV', 'fourvenues', null, 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:wn2v7pw4rt8h404wd66sq4zviwxogtdj', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/nightlife-valencia"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/rumbo144/events/ADTV"},{"label":"Fourvenues","url":"https://site.fourvenues.com/es/rumbo144"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('b0edbec0-44b4-519f-94f8-dd5fc70f3ad4', 'Tardeo Sábado | PHARNALS en Concierto', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-11-14T16:00:00.000Z', '2026-11-14T22:45:00.000Z', false, null,
  'dc75fbbf-4710-5740-ab6c-520120ae0d33', 'Rumbo 144', 'Rumbo 144', 'Avenida Blasco Ibáñez, 144, 46022 Valencia (Valencia), España', 'CIUTAT JARDI', 'València',
  'Valencia', 39.47245, -0.3447, 'source-coordinates', 'En directo', array['indie', 'rock', 'pop']::text[], 5,
  'from', 'Entrada CONCIERTO y TARDEO', 'https://site.fourvenues.com/es/rumbo144/events/C0M1', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/18546942-0c94-4e13-ae16-3d4f31dd6800/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:p5l6x22aj6q9uy2gr0xb57qzuyet1huk', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/nightlife-valencia"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/rumbo144/events/C0M1"},{"label":"Fourvenues","url":"https://site.fourvenues.com/es/rumbo144"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('f5bf1c54-94fc-59ca-92db-9c2ab805e256', 'PLAYA PALAPA: TARDE Y NOCHE MUSIC TO TAKE AWAY', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-11-14T17:00:00.000Z', '2026-11-15T02:30:00.000Z', false, null,
  '726aaac7-561a-5edd-a55d-78f78013af54', 'Marina Beach Club', 'Marina Beach', 'C. Marina Real Juan Carlos I, s/n, 46011 Valencia, España', 'EL GRAU', 'València',
  'Valencia', 39.4629916, -0.3216705, 'source-coordinates', 'Sin clasificar', '{}'::text[], 35,
  'from', 'ENTRADA ANTICIPADA sin consumición ', 'https://site.fourvenues.com/es/marina-beach-club/events/57G2', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/86001fa1-5e54-4475-5869-a09a5b840300/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:y944jkv78ro65enuhzibpmps6tzw5ddd', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/marina-beach-club"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/marina-beach-club/events/57G2"},{"label":"Marina Beach Club","url":"https://marinabeachclub.com/calendario-eventos/"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('33f145b6-9e71-5789-9d41-9c807e7e59de', 'Vendex + Djs invitados & Total x Keep Hush w/ M8NSE b2b ENGALANAN', 'Evento publicado en Xceed. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-11-14T23:00:00+01:00', '2026-11-15T07:30:00+01:00', false, null,
  'cbe949b0-364d-5edf-a75d-8aab698e3a41', 'Spook Club', null, 'Carretera del Rio, 399, Pinedo', 'PINEDO', 'València',
  'Valencia', 39.410901, -0.33605499999999, 'source-coordinates', 'Sin clasificar', '{}'::text[], 25,
  'from', 'TICKET - TRAMO 2', 'https://xceed.me/es/valencia/event/vendex-djs-invitados-total-x-keep-hush-w-m8nse-b2b-engalanan/241968', 'xceed', 'https://images.xceed.me/events/banners/vendex-djs-invitados-total-x-keep-hush-w-m8nse-b2b-engalanan-valencia-xceed-square-dd12.png?w=1920&h=1920&ar=1:1&fm=auto', 'groove',
  '18+', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'xceed:241968', '[{"label":"Xceed","url":"https://xceed.me/es/valencia/event/vendex-djs-invitados-total-x-keep-hush-w-m8nse-b2b-engalanan/241968"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.event_artists (event_id, entity_id, position) values ('33f145b6-9e71-5789-9d41-9c807e7e59de', 'b7da4801-6aab-5db7-8a78-deaf38e45623', 0);
insert into public.event_artists (event_id, entity_id, position) values ('33f145b6-9e71-5789-9d41-9c807e7e59de', 'ef5bdee4-fbf6-5a4c-936c-37051d5abc6b', 1);
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('52ce0c2f-3ad7-5f40-bc59-1fe7d942f13e', 'Barraca pres. TECHNOLOGY', 'Evento publicado en Xceed. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-11-14T23:59:00+01:00', '2026-11-15T07:30:00+01:00', false, null,
  '85d20105-2d60-5581-a35f-aede6e416dbc', 'Barraca', null, 'Calle Les Palmeres, Sueca, Valencia', '', 'Sueca',
  'Valencia', 39.254649, -0.26666, 'source-coordinates', 'Sin clasificar', '{}'::text[], 17,
  'from', 'Entrada (Sin Copa)', 'https://xceed.me/es/valencia/event/barraca-pres-technology-2/244477', 'xceed', 'https://images.xceed.me/events/banners/barraca-pres-technology-2-valencia-xceed-square-a385.jpg?w=1920&h=1920&ar=1:1&fm=auto', 'groove',
  '18+', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'xceed:244477', '[{"label":"Xceed","url":"https://xceed.me/es/valencia/event/barraca-pres-technology-2/244477"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.event_artists (event_id, entity_id, position) values ('52ce0c2f-3ad7-5f40-bc59-1fe7d942f13e', '14cc8db0-b58b-5966-8862-e70a320fab36', 0);
insert into public.event_artists (event_id, entity_id, position) values ('52ce0c2f-3ad7-5f40-bc59-1fe7d942f13e', 'ff0901d6-747b-540e-8dee-d1232bdf19c3', 1);
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('6851ea59-582f-5e6c-82d7-251093406b32', 'PLAYA PALAPA: NOCHE AFROSPLASH', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-11-20T21:30:00.000Z', '2026-11-21T02:30:00.000Z', false, null,
  '726aaac7-561a-5edd-a55d-78f78013af54', 'Marina Beach Club', 'Marina Beach', 'C. Marina Real Juan Carlos I, s/n, 46011 Valencia, España', 'EL GRAU', 'València',
  'Valencia', 39.4629916, -0.3216705, 'source-coordinates', 'Sin clasificar', '{}'::text[], 10,
  'from', 'ENTRADA ANTICIPADA sin consumición ', 'https://site.fourvenues.com/es/marina-beach-club/events/YVK7', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/f11c7485-995a-4f50-2ce4-8b3ba7530900/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:shf5dqgj58noob81lsu96lcqs7dunhuz', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/marina-beach-club"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/marina-beach-club/events/YVK7"},{"label":"Marina Beach Club","url":"https://marinabeachclub.com/calendario-eventos/"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('577c40e7-bc33-5486-a0a8-98548a1b8c5c', 'Tardeo Sábado | RINCÓN CLANDESTINO en Concierto', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-11-21T16:00:00.000Z', '2026-11-21T22:45:00.000Z', false, null,
  'dc75fbbf-4710-5740-ab6c-520120ae0d33', 'Rumbo 144', 'Rumbo 144', 'Avenida Blasco Ibáñez, 144, 46022 Valencia (Valencia), España', 'CIUTAT JARDI', 'València',
  'Valencia', 39.47245, -0.3447, 'source-coordinates', 'En directo', array['indie', 'rock', 'pop']::text[], 5,
  'from', 'Entrada CONCIERTO y TARDEO', 'https://site.fourvenues.com/es/rumbo144/events/4Y3I', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/ef3a5b81-91bb-4c51-8f94-a555d7b2de00/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:ajklz8ac1xmuy28m4em1eyvoiihskph2', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/nightlife-valencia"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/rumbo144/events/4Y3I"},{"label":"Fourvenues","url":"https://site.fourvenues.com/es/rumbo144"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('cf4b5da7-90c7-5615-81ef-63dcec843c24', 'Tarde_On Indie | HIMNÓTICOS en Concierto', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-11-21T16:00:00.000Z', '2026-11-21T22:45:00.000Z', false, null,
  'dc75fbbf-4710-5740-ab6c-520120ae0d33', 'Rumbo 144', 'Rumbo 144', 'Avenida Blasco Ibáñez, 144, 46022 Valencia (Valencia), España', 'CIUTAT JARDI', 'València',
  'Valencia', 39.47245, -0.3447, 'source-coordinates', 'En directo', array['indie', 'rock', 'pop']::text[], 5,
  'from', 'Entrada CONCIERTO y TARDEO', 'https://site.fourvenues.com/es/rumbo144/events/EEB3', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/0d7e386b-131f-4adf-ef15-35ca46541600/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:bkivltlrhawr0ir689lo48h87z74feg1', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/nightlife-valencia"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/rumbo144/events/EEB3"},{"label":"Fourvenues","url":"https://site.fourvenues.com/es/rumbo144"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('84cd69dc-41f4-5892-bb2e-b8292512a2f9', 'PLAYA PALAPA: NOCHE PARAFERNALIA', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-11-21T21:30:00.000Z', '2026-11-22T02:30:00.000Z', false, null,
  '726aaac7-561a-5edd-a55d-78f78013af54', 'Marina Beach Club', 'Marina Beach', 'C. Marina Real Juan Carlos I, s/n, 46011 Valencia, España', 'EL GRAU', 'València',
  'Valencia', 39.4629916, -0.3216705, 'source-coordinates', 'Sin clasificar', '{}'::text[], 10,
  'from', 'ENTRADA ANTICIPADA sin consumición ', 'https://site.fourvenues.com/es/marina-beach-club/events/1YLZ', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/f36d1f8c-0d6f-4dc8-edf6-819f80076e00/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:v25ww0lzbeu5wx9fttzwj6cvnr0tt8us', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/marina-beach-club"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/marina-beach-club/events/1YLZ"},{"label":"Marina Beach Club","url":"https://marinabeachclub.com/calendario-eventos/"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('54ab410a-1021-5bd3-a373-00c66c474e94', 'PLAYA PALAPA: NOCHE HITS', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-11-27T21:30:00.000Z', '2026-11-28T02:30:00.000Z', false, null,
  '726aaac7-561a-5edd-a55d-78f78013af54', 'Marina Beach Club', 'Marina Beach', 'C. Marina Real Juan Carlos I, s/n, 46011 Valencia, España', 'EL GRAU', 'València',
  'Valencia', 39.4629916, -0.3216705, 'source-coordinates', 'Sin clasificar', '{}'::text[], 10,
  'from', 'ENTRADA ANTICIPADA sin consumición', 'https://site.fourvenues.com/es/marina-beach-club/events/4SW9', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/3c6e4a70-0209-4613-1c3b-03efb390f900/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:vka2kwzbiht49sdg63hhbsaaplkhzq81', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/marina-beach-club"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/marina-beach-club/events/4SW9"},{"label":"Marina Beach Club","url":"https://marinabeachclub.com/calendario-eventos/"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('2e81fbf6-58cc-5575-80dc-dde637188375', 'Tardeo Sábado | PONTE KARAOKE en Concierto', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-11-28T16:00:00.000Z', '2026-11-28T22:45:00.000Z', false, null,
  'dc75fbbf-4710-5740-ab6c-520120ae0d33', 'Rumbo 144', 'Rumbo 144', 'Avenida Blasco Ibáñez, 144, 46022 Valencia (Valencia), España', 'CIUTAT JARDI', 'València',
  'Valencia', 39.47245, -0.3447, 'source-coordinates', 'En directo', array['indie', 'rock', 'pop']::text[], 5,
  'from', 'Entrada CONCIERTO y TARDEO', 'https://site.fourvenues.com/es/rumbo144/events/LCLB', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/ff3aacfe-2cf8-455a-878e-273df8110000/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:tuu1mysc51a7vjxnnf6hc1jac9tpx217', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/nightlife-valencia"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/rumbo144/events/LCLB"},{"label":"Fourvenues","url":"https://site.fourvenues.com/es/rumbo144"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('57562f6d-0270-5127-acf0-2b4466507a38', 'Tardeo Sábado | LOS RÍTMICOS en Concierto', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-11-28T16:00:00.000Z', '2026-11-28T22:45:00.000Z', false, null,
  'dc75fbbf-4710-5740-ab6c-520120ae0d33', 'Rumbo 144', 'Rumbo 144', 'Avenida Blasco Ibáñez, 144, 46022 Valencia (Valencia), España', 'CIUTAT JARDI', 'València',
  'Valencia', 39.47245, -0.3447, 'source-coordinates', 'En directo', array['indie', 'rock', 'pop']::text[], 5,
  'from', 'Entrada CONCIERTO y TARDEO', 'https://site.fourvenues.com/es/rumbo144/events/EORL', 'fourvenues', null, 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:ab22af4k0c5jkf8fdktoa48h06zkqd2g', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/nightlife-valencia"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/rumbo144/events/EORL"},{"label":"Fourvenues","url":"https://site.fourvenues.com/es/rumbo144"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('57e70689-d84c-50ec-83b0-124a918731bf', 'INVADERS "TRIP TO JAPAN"', 'Evento publicado en Xceed. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-11-28T20:00:00+01:00', '2026-11-29T07:30:00+01:00', false, null,
  'cbe949b0-364d-5edf-a75d-8aab698e3a41', 'Spook Club', null, 'Carretera del Rio, 399, Pinedo', 'PINEDO', 'València',
  'Valencia', 39.410901, -0.33605499999999, 'source-coordinates', 'Sin clasificar', '{}'::text[], 28,
  'from', 'Entrada Tramo 3', 'https://xceed.me/es/valencia/event/invaders-trip-to-japan-1/238242', 'xceed', 'https://images.xceed.me/events/banners/invaders-trip-to-japan-1-valencia-xceed-square-0d92.jpg?w=1920&h=1920&ar=1:1&fm=auto', 'groove',
  '18+', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'xceed:238242', '[{"label":"Xceed","url":"https://xceed.me/es/valencia/event/invaders-trip-to-japan-1/238242"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.event_artists (event_id, entity_id, position) values ('57e70689-d84c-50ec-83b0-124a918731bf', '4e747646-e5a3-5606-9d18-328c38ae89f6', 0);
insert into public.event_artists (event_id, entity_id, position) values ('57e70689-d84c-50ec-83b0-124a918731bf', 'b38bea1f-3eff-5bf6-bcda-02e5310d5a05', 1);
insert into public.event_artists (event_id, entity_id, position) values ('57e70689-d84c-50ec-83b0-124a918731bf', '4f5b8aff-27ae-57fd-a685-c229330f3e3b', 2);
insert into public.event_artists (event_id, entity_id, position) values ('57e70689-d84c-50ec-83b0-124a918731bf', 'ce532ebf-992e-56da-b8d0-27afbdc0827a', 3);
insert into public.event_artists (event_id, entity_id, position) values ('57e70689-d84c-50ec-83b0-124a918731bf', '1ca0f06c-2805-5814-a6a1-9aae0e545eaf', 4);
insert into public.event_artists (event_id, entity_id, position) values ('57e70689-d84c-50ec-83b0-124a918731bf', '12938f7d-b5e7-53c7-a866-6717c7554fd5', 5);
insert into public.event_artists (event_id, entity_id, position) values ('57e70689-d84c-50ec-83b0-124a918731bf', '4b91c672-8be2-5cab-83d9-7c8a96fb42b2', 6);
insert into public.event_artists (event_id, entity_id, position) values ('57e70689-d84c-50ec-83b0-124a918731bf', 'fd6a0f8c-8342-5e12-b470-2a3267c7e9f4', 7);
insert into public.event_artists (event_id, entity_id, position) values ('57e70689-d84c-50ec-83b0-124a918731bf', 'fe71e859-f403-50d1-8be6-fed44fc9106a', 8);
insert into public.event_artists (event_id, entity_id, position) values ('57e70689-d84c-50ec-83b0-124a918731bf', '7a05b721-01ac-5d52-bd68-bfb0be26e6da', 9);
insert into public.event_artists (event_id, entity_id, position) values ('57e70689-d84c-50ec-83b0-124a918731bf', 'aaf902d3-c546-5bd6-8ca9-7f66dcaaeb38', 10);
insert into public.event_artists (event_id, entity_id, position) values ('57e70689-d84c-50ec-83b0-124a918731bf', '535351f8-2ece-5f4f-a395-d7c1c3ae7ce9', 11);
insert into public.event_artists (event_id, entity_id, position) values ('57e70689-d84c-50ec-83b0-124a918731bf', 'd23f7dd7-fe8d-50c0-b606-d3ab2309ee82', 12);
insert into public.event_artists (event_id, entity_id, position) values ('57e70689-d84c-50ec-83b0-124a918731bf', '90cc4922-1d68-5b9e-9df8-766aa865ad2f', 13);
insert into public.event_artists (event_id, entity_id, position) values ('57e70689-d84c-50ec-83b0-124a918731bf', '89882fd6-b8e0-5a6f-99db-8023782c41a3', 14);
insert into public.event_artists (event_id, entity_id, position) values ('57e70689-d84c-50ec-83b0-124a918731bf', '3ad47757-769f-554e-9e88-844af81c14a6', 15);
insert into public.event_artists (event_id, entity_id, position) values ('57e70689-d84c-50ec-83b0-124a918731bf', '54d54317-8b2a-5917-b0c9-846eeff96215', 16);
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('b765b159-77a6-5a8a-95e9-4407e2e2a533', 'PLAYA PALAPA: NOCHE MIKE MIROUX', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-11-28T21:30:00.000Z', '2026-11-29T02:30:00.000Z', false, null,
  '726aaac7-561a-5edd-a55d-78f78013af54', 'Marina Beach Club', 'Marina Beach', 'C. Marina Real Juan Carlos I, s/n, 46011 Valencia, España', 'EL GRAU', 'València',
  'Valencia', 39.4629916, -0.3216705, 'source-coordinates', 'Sin clasificar', '{}'::text[], 10,
  'from', 'ENTRADA ANTICIPADA sin consumición', 'https://site.fourvenues.com/es/marina-beach-club/events/AREB', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/2044042e-e5ed-4d31-5ca4-c73fa8842b00/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:trn3fzlb1u8qxekzs73wqybh1fvix83w', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/marina-beach-club"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/marina-beach-club/events/AREB"},{"label":"Marina Beach Club","url":"https://marinabeachclub.com/calendario-eventos/"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('32dc30fd-3701-543d-af5e-ea098f08ab2a', '42 ANIVERSARIO:  80s 90s', 'Evento publicado en Xceed. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-12-04T18:00:00+01:00', '2026-12-05T07:30:00+01:00', false, null,
  'cbe949b0-364d-5edf-a75d-8aab698e3a41', 'Spook Club', null, 'Carretera del Rio, 399, Pinedo', 'PINEDO', 'València',
  'Valencia', 39.410901, -0.33605499999999, 'source-coordinates', 'Sin clasificar', '{}'::text[], 25,
  'from', 'TICKETS - TRAMO 1', 'https://xceed.me/es/valencia/event/42-aniversario-80s-90s/244341', 'xceed', 'https://images.xceed.me/events/banners/42-aniversario-80s-90s-valencia-xceed-square-fed0.jpg?w=1920&h=1920&ar=1:1&fm=auto', 'groove',
  '18+', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'xceed:244341', '[{"label":"Xceed","url":"https://xceed.me/es/valencia/event/42-aniversario-80s-90s/244341"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('2950dcf6-e544-53a5-904d-a36cac5c9b8f', 'PLAYA PALAPA: NOCHE DARK PLACES', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-12-04T21:30:00.000Z', '2026-12-05T02:30:00.000Z', false, null,
  '726aaac7-561a-5edd-a55d-78f78013af54', 'Marina Beach Club', 'Marina Beach', 'C. Marina Real Juan Carlos I, s/n, 46011 Valencia, España', 'EL GRAU', 'València',
  'Valencia', 39.4629916, -0.3216705, 'source-coordinates', 'Sin clasificar', '{}'::text[], 10,
  'from', 'ENTRADA  ANTICIPADA  sin consumición', 'https://site.fourvenues.com/es/marina-beach-club/events/95DF', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/540638f6-fb3a-4d68-d3d7-4adab7692400/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:elsquewwex2z8r0et7wnl88gwasdj0uh', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/marina-beach-club"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/marina-beach-club/events/95DF"},{"label":"Marina Beach Club","url":"https://marinabeachclub.com/calendario-eventos/"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('c5389b2d-42d0-55a3-a3c8-9d53d36a598d', 'Sound Factory - 26º Aniversario', 'Evento publicado en Xceed. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-12-05T18:00:00+01:00', '2026-12-06T07:00:00+01:00', false, null,
  '074cb32b-b2e1-58ad-a650-568910faca86', 'Sound Factory', null, 'Carrera del Riu, 399', 'PINEDO', 'València',
  'Valencia', 39.4105911, -0.3351692, 'source-coordinates', 'Sin clasificar', '{}'::text[], 20,
  'from', 'Segundo tramo', 'https://xceed.me/es/valencia/event/sound-factory-26-aniversario/240811', 'xceed', 'https://images.xceed.me/events/banners/sound-factory-26-aniversario-valencia-xceed-square-c3b7.png?w=1920&h=1920&ar=1:1&fm=auto', 'groove',
  null, 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'xceed:240811', '[{"label":"Xceed","url":"https://xceed.me/es/valencia/event/sound-factory-26-aniversario/240811"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('2d979b8d-3e4a-5e1b-a87e-2e21f53c5d87', 'PLAYA PALAPA: NOCHE TORRIONE', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-12-05T22:00:00.000Z', '2026-12-06T02:30:00.000Z', false, null,
  '726aaac7-561a-5edd-a55d-78f78013af54', 'Marina Beach Club', 'Marina Beach', 'C. Marina Real Juan Carlos I, s/n, 46011 Valencia, España', 'EL GRAU', 'València',
  'Valencia', 39.4629916, -0.3216705, 'source-coordinates', 'Sin clasificar', '{}'::text[], 10,
  'from', 'ENTRADA  ANTICIPADA sin consumición', 'https://site.fourvenues.com/es/marina-beach-club/events/LW46', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/42293e1f-7eb0-41ca-8c95-78f1d7227c00/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:pi8bp8xg3elunfnzv4gl27javr3ntsjo', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/marina-beach-club"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/marina-beach-club/events/LW46"},{"label":"Marina Beach Club","url":"https://marinabeachclub.com/calendario-eventos/"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('56d33e79-9d3c-56b4-98c6-d5ce49a6a0d6', 'PLAYA PALAPA: NOCHE HITS', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-12-06T22:00:00.000Z', '2026-12-07T02:30:00.000Z', false, null,
  '726aaac7-561a-5edd-a55d-78f78013af54', 'Marina Beach Club', 'Marina Beach', 'C. Marina Real Juan Carlos I, s/n, 46011 Valencia, España', 'EL GRAU', 'València',
  'Valencia', 39.4629916, -0.3216705, 'source-coordinates', 'Sin clasificar', '{}'::text[], 10,
  'from', 'ENTRADA  ANTICIPADA  sin consumición', 'https://site.fourvenues.com/es/marina-beach-club/events/VJ26', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/cc519a92-9208-4adf-5bfb-032eede4fb00/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:jj5mjcwtqksm36gw7uuy4n26nz9uzepg', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/marina-beach-club"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/marina-beach-club/events/VJ26"},{"label":"Marina Beach Club","url":"https://marinabeachclub.com/calendario-eventos/"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('a7401569-26eb-578c-a159-2bdd878fac56', 'PLAYA PALAPA: NOCHE HITS', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-12-07T22:00:00.000Z', '2026-12-08T02:30:00.000Z', false, null,
  '726aaac7-561a-5edd-a55d-78f78013af54', 'Marina Beach Club', 'Marina Beach', 'C. Marina Real Juan Carlos I, s/n, 46011 Valencia, España', 'EL GRAU', 'València',
  'Valencia', 39.4629916, -0.3216705, 'source-coordinates', 'Sin clasificar', '{}'::text[], 10,
  'from', 'ENTRADA  ANTICIPADA  sin consumición', 'https://site.fourvenues.com/es/marina-beach-club/events/0SYQ', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/a2fc86e5-4746-44a4-363a-03b630c74700/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:tac2i3s3yhafjv0um5umt24yvm64bv3x', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/marina-beach-club"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/marina-beach-club/events/0SYQ"},{"label":"Marina Beach Club","url":"https://marinabeachclub.com/calendario-eventos/"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('8d1e22fd-fc13-55e8-b4f6-3d0aa0e1c897', '42 anniversary: Onlynumbers + invitados', 'Evento publicado en Xceed. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-12-07T23:00:00+01:00', '2026-12-08T07:30:00+01:00', false, null,
  'cbe949b0-364d-5edf-a75d-8aab698e3a41', 'Spook Club', null, 'Carretera del Rio, 399, Pinedo', 'PINEDO', 'València',
  'Valencia', 39.410901, -0.33605499999999, 'source-coordinates', 'Sin clasificar', '{}'::text[], 25,
  'from', 'TICKET - TRAMO 1', 'https://xceed.me/es/valencia/event/42-anniversary-onlynumbers-invitados/241971', 'xceed', 'https://images.xceed.me/events/banners/42-anniversary-onlynumbers-invitados-valencia-xceed-square-b186.png?w=1920&h=1920&ar=1:1&fm=auto', 'groove',
  '18+', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'xceed:241971', '[{"label":"Xceed","url":"https://xceed.me/es/valencia/event/42-anniversary-onlynumbers-invitados/241971"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.event_artists (event_id, entity_id, position) values ('8d1e22fd-fc13-55e8-b4f6-3d0aa0e1c897', 'aff81e43-b778-537b-b711-de48358f8aba', 0);
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('f83b0351-a123-5d6f-a961-f300ed0c1cbf', 'MARINA: TARDE STARS', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-12-11T15:30:00.000Z', '2026-12-12T02:30:00.000Z', false, null,
  '726aaac7-561a-5edd-a55d-78f78013af54', 'Marina Beach Club', 'Marina Beach', 'C. Marina Real Juan Carlos I, s/n, 46011 Valencia, España', 'EL GRAU', 'València',
  'Valencia', 39.4629916, -0.3216705, 'source-coordinates', 'Sin clasificar', '{}'::text[], 10,
  'from', 'ENTRADA ANTICIPADA sin consumición', 'https://site.fourvenues.com/es/marina-beach-club/events/1Q8E', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/4951500d-3e9a-4904-06df-cfb2573d1d00/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:vkps0qlz5j00qjw860odj8d5uimtt9hz', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/marina-beach-club"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/marina-beach-club/events/1Q8E"},{"label":"Marina Beach Club","url":"https://marinabeachclub.com/calendario-eventos/"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('6a7cc23f-f80e-5b0a-97cd-a786e907c71d', 'PLAYA PALAPA: NOCHE CHRISTMAS PARTY', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-12-11T22:00:00.000Z', '2026-12-12T02:30:00.000Z', false, null,
  '726aaac7-561a-5edd-a55d-78f78013af54', 'Marina Beach Club', 'Marina Beach', 'C. Marina Real Juan Carlos I, s/n, 46011 Valencia, España', 'EL GRAU', 'València',
  'Valencia', 39.4629916, -0.3216705, 'source-coordinates', 'Sin clasificar', '{}'::text[], 10,
  'from', 'ENTRADA  ANTICIPADA  sin consumición', 'https://site.fourvenues.com/es/marina-beach-club/events/QSGL', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/01691c2e-3982-490a-fc85-4f0306137f00/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:bqxla25ww7iboym2xerap7ovx39jca45', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/marina-beach-club"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/marina-beach-club/events/QSGL"},{"label":"Marina Beach Club","url":"https://marinabeachclub.com/calendario-eventos/"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('c4789f23-feeb-558c-aa6e-aff56bd50b33', 'MARINA: TARDE BEACHOUSE', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-12-12T15:30:00.000Z', '2026-12-13T02:30:00.000Z', false, null,
  '726aaac7-561a-5edd-a55d-78f78013af54', 'Marina Beach Club', 'Marina Beach', 'C. Marina Real Juan Carlos I, s/n, 46011 Valencia, España', 'EL GRAU', 'València',
  'Valencia', 39.4629916, -0.3216705, 'source-coordinates', 'Sin clasificar', '{}'::text[], 10,
  'from', 'ENTRADA ANTICIPADA sin consumición', 'https://site.fourvenues.com/es/marina-beach-club/events/M78N', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/e71a3ce7-a9da-4ba2-f746-df6771b2e200/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:rtsbj3zsqqw2k57l5pgzqmvvzdg7bvjt', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/marina-beach-club"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/marina-beach-club/events/M78N"},{"label":"Marina Beach Club","url":"https://marinabeachclub.com/calendario-eventos/"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('dda6dda8-2692-510e-a5aa-0c5a5b2cf951', 'PLAYA PALAPA: NOCHE BUGANVILLA', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-12-12T22:00:00.000Z', '2026-12-13T02:30:00.000Z', false, null,
  '726aaac7-561a-5edd-a55d-78f78013af54', 'Marina Beach Club', 'Marina Beach', 'C. Marina Real Juan Carlos I, s/n, 46011 Valencia, España', 'EL GRAU', 'València',
  'Valencia', 39.4629916, -0.3216705, 'source-coordinates', 'Sin clasificar', '{}'::text[], 10,
  'from', 'ENTRADA  ANTICIPADA  sin consumición', 'https://site.fourvenues.com/es/marina-beach-club/events/UUSX', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/26125450-b27f-4e8a-c0a4-c44454e24500/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:wt3848izc38j47oxhri1m8y00uil7eag', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/marina-beach-club"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/marina-beach-club/events/UUSX"},{"label":"Marina Beach Club","url":"https://marinabeachclub.com/calendario-eventos/"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('1f6c84a3-136e-5d99-b434-cdc8c7f8bb5c', 'Richie Hawtin + invitados & Cartulis w/ Unai Trotti + Vass', 'Evento publicado en Xceed. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-12-12T23:00:00+01:00', '2026-12-13T07:30:00+01:00', false, null,
  'cbe949b0-364d-5edf-a75d-8aab698e3a41', 'Spook Club', null, 'Carretera del Rio, 399, Pinedo', 'PINEDO', 'València',
  'Valencia', 39.410901, -0.33605499999999, 'source-coordinates', 'Sin clasificar', '{}'::text[], 30,
  'from', 'TICKET - TRAMO 2', 'https://xceed.me/es/valencia/event/richie-hawtin-invitados-cartulis-w-unai-trotti-vass/241972', 'xceed', 'https://images.xceed.me/events/banners/richie-hawtin-invitados-cartulis-w-unai-trotti-vass-valencia-xceed-square-fdb6.png?w=1920&h=1920&ar=1:1&fm=auto', 'groove',
  '18+', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'xceed:241972', '[{"label":"Xceed","url":"https://xceed.me/es/valencia/event/richie-hawtin-invitados-cartulis-w-unai-trotti-vass/241972"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.event_artists (event_id, entity_id, position) values ('1f6c84a3-136e-5d99-b434-cdc8c7f8bb5c', 'ef7d7dce-0627-5d93-bf85-8cd5747ba851', 0);
insert into public.event_artists (event_id, entity_id, position) values ('1f6c84a3-136e-5d99-b434-cdc8c7f8bb5c', 'e38ff22a-414d-505a-8151-b9d97186869f', 1);
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('299144e8-7e0b-5bc2-a2ba-4dd2f817c7c1', 'MARINA: TARDE STARS', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-12-18T15:30:00.000Z', '2026-12-19T02:30:00.000Z', false, null,
  '726aaac7-561a-5edd-a55d-78f78013af54', 'Marina Beach Club', 'Marina Beach', 'C. Marina Real Juan Carlos I, s/n, 46011 Valencia, España', 'EL GRAU', 'València',
  'Valencia', 39.4629916, -0.3216705, 'source-coordinates', 'Sin clasificar', '{}'::text[], 10,
  'from', 'ENTRADA ANTICIPADA sin consumición', 'https://site.fourvenues.com/es/marina-beach-club/events/1J07', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/4951500d-3e9a-4904-06df-cfb2573d1d00/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:m9z983r9yiixqvcrq2jbtj1ito490vqq', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/marina-beach-club"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/marina-beach-club/events/1J07"},{"label":"Marina Beach Club","url":"https://marinabeachclub.com/calendario-eventos/"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('eca6bdf0-55ff-596b-a76e-b14a1766b3da', 'PLAYA PALAPA: NOCHE CHRISTMAS PARTY', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-12-18T22:00:00.000Z', '2026-12-19T02:30:00.000Z', false, null,
  '726aaac7-561a-5edd-a55d-78f78013af54', 'Marina Beach Club', 'Marina Beach', 'C. Marina Real Juan Carlos I, s/n, 46011 Valencia, España', 'EL GRAU', 'València',
  'Valencia', 39.4629916, -0.3216705, 'source-coordinates', 'Sin clasificar', '{}'::text[], 10,
  'from', 'ENTRADA  ANTICIPADA  sin consumición', 'https://site.fourvenues.com/es/marina-beach-club/events/PIO6', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/b1d2159e-c1c0-479a-63e7-0f4ddfcd3d00/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:d1z3hrokblle8x1eeid3aek6n6ojt6us', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/marina-beach-club"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/marina-beach-club/events/PIO6"},{"label":"Marina Beach Club","url":"https://marinabeachclub.com/calendario-eventos/"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('2a3bd2bf-62ab-528b-bd33-f789bcee4043', 'INVADERS pres. OGALLA ALL NIGHT LONG', 'Evento publicado en Xceed. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-12-18T23:00:00+01:00', '2026-12-19T07:30:00+01:00', false, null,
  'cbe949b0-364d-5edf-a75d-8aab698e3a41', 'Spook Club', null, 'Carretera del Rio, 399, Pinedo', 'PINEDO', 'València',
  'Valencia', 39.410901, -0.33605499999999, 'source-coordinates', 'Sin clasificar', '{}'::text[], 20,
  'from', 'Entrada Tramo 1', 'https://xceed.me/es/valencia/event/invaders-pres-ogalla-all-night-long-1/238770', 'xceed', 'https://images.xceed.me/events/banners/invaders-pres-ogalla-all-night-long-1-valencia-xceed-square-441b.png?w=1920&h=1920&ar=1:1&fm=auto', 'groove',
  '18+', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'xceed:238770', '[{"label":"Xceed","url":"https://xceed.me/es/valencia/event/invaders-pres-ogalla-all-night-long-1/238770"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.event_artists (event_id, entity_id, position) values ('2a3bd2bf-62ab-528b-bd33-f789bcee4043', '716bd3fa-a498-51d5-8dce-6e5ecda1176f', 0);
insert into public.event_artists (event_id, entity_id, position) values ('2a3bd2bf-62ab-528b-bd33-f789bcee4043', 'cacaa8a9-7056-5f9c-a077-dc8a0f1d5c9a', 1);
insert into public.event_artists (event_id, entity_id, position) values ('2a3bd2bf-62ab-528b-bd33-f789bcee4043', '3e5a39ae-0cb9-50ca-9a5a-92a2dc4155dd', 2);
insert into public.event_artists (event_id, entity_id, position) values ('2a3bd2bf-62ab-528b-bd33-f789bcee4043', 'a742a47b-1647-5e2a-a894-33cf9c11460f', 3);
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('40f520ed-3038-5657-9d8d-4ac9a25449ee', 'MARINA: NOCHE GORDO', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-12-19T22:00:00.000Z', '2026-12-20T05:00:00.000Z', false, null,
  '726aaac7-561a-5edd-a55d-78f78013af54', 'Marina Beach Club', 'Marina Beach', 'C. Marina Real Juan Carlos I, s/n, 46011 Valencia, España', 'EL GRAU', 'València',
  'Valencia', 39.4629916, -0.3216705, 'source-coordinates', 'Sin clasificar', '{}'::text[], 20,
  'from', 'ENTRADA ANTICIPADA con consumición ENTRANDO ANTES DE LAS 00:000H', 'https://site.fourvenues.com/es/marina-beach-club/events/M1CW', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/53563810-c41b-453f-7cdd-c91c55df3e00/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:vkxegs9d9uiplkex8oq88csy5hh2gxho', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/marina-beach-club"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/marina-beach-club/events/M1CW"},{"label":"Marina Beach Club","url":"https://marinabeachclub.com/calendario-eventos/"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('9fe36c2b-d210-582c-926d-49d74f535b38', 'PLAYA PALAPA: NOCHE APAGÓN', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-12-19T22:00:00.000Z', '2026-12-20T06:00:00.000Z', false, null,
  '726aaac7-561a-5edd-a55d-78f78013af54', 'Marina Beach Club', 'Marina Beach', 'C. Marina Real Juan Carlos I, s/n, 46011 Valencia, España', 'EL GRAU', 'València',
  'Valencia', 39.4629916, -0.3216705, 'source-coordinates', 'Sin clasificar', '{}'::text[], 10,
  'from', 'ENTRADA  ANTICIPADA  sin consumición', 'https://site.fourvenues.com/es/marina-beach-club/events/2ZOL', 'fourvenues', null, 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:ph8m1aec7xmbnzam12fly5fmpcol6vx6', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/marina-beach-club"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/marina-beach-club/events/2ZOL"},{"label":"Marina Beach Club","url":"https://marinabeachclub.com/calendario-eventos/"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('010da37f-027f-5288-a1b0-80c27e47af99', 'Andres Campo (extended set)  + invitados', 'Evento publicado en Xceed. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-12-19T23:00:00+01:00', '2026-12-20T07:30:00+01:00', false, null,
  'cbe949b0-364d-5edf-a75d-8aab698e3a41', 'Spook Club', null, 'Carretera del Rio, 399, Pinedo', 'PINEDO', 'València',
  'Valencia', 39.410901, -0.33605499999999, 'source-coordinates', 'Sin clasificar', '{}'::text[], 25,
  'from', 'TICKET - TRAMO 1', 'https://xceed.me/es/valencia/event/andres-campo-extended-set-invitados/248515', 'xceed', 'https://images.xceed.me/events/banners/andres-campo-extended-set-invitados-valencia-xceed-square-0e22.png?w=1920&h=1920&ar=1:1&fm=auto', 'groove',
  '18+', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'xceed:248515', '[{"label":"Xceed","url":"https://xceed.me/es/valencia/event/andres-campo-extended-set-invitados/248515"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.event_artists (event_id, entity_id, position) values ('010da37f-027f-5288-a1b0-80c27e47af99', '70fefd92-e15f-5c67-8eaa-21dccd428853', 0);
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('b3a26b40-8b4e-584a-af28-7762d9cf7e68', 'PLAYA PALAPA: NOCHE ZIUR', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-12-25T22:00:00.000Z', '2026-12-26T02:30:00.000Z', false, null,
  '726aaac7-561a-5edd-a55d-78f78013af54', 'Marina Beach Club', 'Marina Beach', 'C. Marina Real Juan Carlos I, s/n, 46011 Valencia, España', 'EL GRAU', 'València',
  'Valencia', 39.4629916, -0.3216705, 'source-coordinates', 'Sin clasificar', '{}'::text[], 10,
  'from', 'ENTRADA  ANTICIPADA  sin consumición', 'https://site.fourvenues.com/es/marina-beach-club/events/AW01', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/c5150b8a-49ce-4309-ccbe-2fc0f1ecb100/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:u39vgrv41l5237zbew7kts4pk436bris', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/marina-beach-club"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/marina-beach-club/events/AW01"},{"label":"Marina Beach Club","url":"https://marinabeachclub.com/calendario-eventos/"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('be071208-0276-57c9-97f3-954a3573836d', 'TARDE_VIEJA | SR.ALIAGA CONCIERTO', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-12-26T16:30:00.000Z', '2026-12-26T22:45:00.000Z', false, null,
  'dc75fbbf-4710-5740-ab6c-520120ae0d33', 'Rumbo 144', 'Rumbo 144', 'Avenida Blasco Ibáñez, 144, 46022 Valencia (Valencia), España', 'CIUTAT JARDI', 'València',
  'Valencia', 39.47245, -0.3447, 'source-coordinates', 'Sin clasificar', array['indie', 'rock', 'pop']::text[], 15,
  'from', 'ENTRADA ANTICIPADA', 'https://site.fourvenues.com/es/rumbo144/events/OLGH', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/58f21ece-96e5-4771-aac1-9314bd808c00/w=1350', 'groove',
  '21', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:ekkaatdzpq9ukqaqxyf9bn39kgkmnlj9', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/nightlife-valencia"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/rumbo144/events/OLGH"},{"label":"Fourvenues","url":"https://site.fourvenues.com/es/rumbo144"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('9b279578-e59d-579e-adbe-747ee0440a70', 'MARINA: NOCHE AFROSPLASH', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-12-26T21:30:00.000Z', '2026-12-27T02:30:00.000Z', false, null,
  '726aaac7-561a-5edd-a55d-78f78013af54', 'Marina Beach Club', 'Marina Beach', 'C. Marina Real Juan Carlos I, s/n, 46011 Valencia, España', 'EL GRAU', 'València',
  'Valencia', 39.4629916, -0.3216705, 'source-coordinates', 'Sin clasificar', '{}'::text[], 10,
  'from', 'ENTRADA ANTICIPADA sin consumición ', 'https://site.fourvenues.com/es/marina-beach-club/events/2CFC', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/f11c7485-995a-4f50-2ce4-8b3ba7530900/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:uyxnw4b8nd7yztgo3qb7y5r40vx31oi2', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/marina-beach-club"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/marina-beach-club/events/2CFC"},{"label":"Marina Beach Club","url":"https://marinabeachclub.com/calendario-eventos/"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('676af911-0ec0-5453-9c4f-71ef576a7de9', 'PLAYA PALAPA: NOCHE DALE FUNK', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-12-26T21:30:00.000Z', '2026-12-27T02:30:00.000Z', false, null,
  '726aaac7-561a-5edd-a55d-78f78013af54', 'Marina Beach Club', 'Marina Beach', 'C. Marina Real Juan Carlos I, s/n, 46011 Valencia, España', 'EL GRAU', 'València',
  'Valencia', 39.4629916, -0.3216705, 'source-coordinates', 'Sin clasificar', '{}'::text[], 10,
  'from', 'ENTRADA  ANTICIPADA  sin consumición', 'https://site.fourvenues.com/es/marina-beach-club/events/8718', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/1f31307e-43f0-4559-624b-3ba7c580e200/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:gklyhxf8mh4r97k1dbdsycuenwfupe4k', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/marina-beach-club"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/marina-beach-club/events/8718"},{"label":"Marina Beach Club","url":"https://marinabeachclub.com/calendario-eventos/"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('d437a655-e489-51d1-a8cc-56007d2e192b', 'MARINA Y PLAYA PALAPA: NOCHE ALEXANDER SOM - LUIGI MAZZALI - MANUEL RIBECA - SALDIVAR', 'Evento publicado en Fourvenues / Fourvenues · entrada. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-12-31T22:00:00.000Z', '2027-01-01T05:00:00.000Z', false, null,
  '726aaac7-561a-5edd-a55d-78f78013af54', 'Marina Beach Club', 'Marina Beach', 'C. Marina Real Juan Carlos I, s/n, 46011 Valencia, España', 'EL GRAU', 'València',
  'Valencia', 39.4629916, -0.3216705, 'source-coordinates', 'Sin clasificar', '{}'::text[], 30,
  'from', 'ENTRADA ANTICIPADA sin consumición ', 'https://site.fourvenues.com/es/marina-beach-club/events/WDG8', 'fourvenues', 'https://fourvenues.com/cdn-cgi/imagedelivery/kWuoTchaMsk7Xnc_FNem7A/57ffc837-b874-460f-a42b-88c7c63fe300/w=1350', 'groove',
  '18', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'fourvenues:b5x0mdo2t7zy9uha2sc1fk0v9pxbfups', '[{"label":"Fourvenues","url":"https://site.fourvenues.com/es/marina-beach-club"},{"label":"Fourvenues · entrada","url":"https://site.fourvenues.com/es/marina-beach-club/events/WDG8"},{"label":"Marina Beach Club","url":"https://marinabeachclub.com/calendario-eventos/"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values ('bbbbca76-d37d-5ffa-a0f0-1bbc9e08ceee', 'NYE 31 + 1: Serafina + Zwilling & Total & Special-k w/ José + Olga korol  + The ghost', 'Evento publicado en Xceed. Consulta la plataforma de origen para disponibilidad, condiciones de acceso, horarios y posibles cambios.', '2026-12-31T23:59:00+01:00', '2027-01-01T09:30:00+01:00', false, null,
  'cbe949b0-364d-5edf-a75d-8aab698e3a41', 'Spook Club', null, 'Carretera del Rio, 399, Pinedo', 'PINEDO', 'València',
  'Valencia', 39.410901, -0.33605499999999, 'source-coordinates', 'Sin clasificar', '{}'::text[], 30,
  'from', 'PRIMEROS TICKETS', 'https://xceed.me/es/valencia/event/nye-31-1-serafina-zwilling-total-special-k-w-jose-olga-korol-the-ghost/248518', 'xceed', 'https://images.xceed.me/events/banners/nye-31-1-serafina-zwilling-total-special-k-w-jose-olga-korol-the-ghost-valencia-xceed-square-1117.png?w=1920&h=1920&ar=1:1&fm=auto', 'groove',
  '18+', 'published', 'imported',
  'ce8fe60d-eb93-5fd0-b1c4-748dd4bdf5b2', 'xceed:248518', '[{"label":"Xceed","url":"https://xceed.me/es/valencia/event/nye-31-1-serafina-zwilling-total-special-k-w-jose-olga-korol-the-ghost/248518"}]'::jsonb, '2026-10-19T08:31:12.206Z');
insert into public.event_artists (event_id, entity_id, position) values ('bbbbca76-d37d-5ffa-a0f0-1bbc9e08ceee', '5df41e11-3be8-546a-b60f-4ecd92329d9f', 0);
insert into public.event_artists (event_id, entity_id, position) values ('bbbbca76-d37d-5ffa-a0f0-1bbc9e08ceee', '702f4d19-769a-52b7-88af-dafe599d5a86', 1);
insert into public.event_artists (event_id, entity_id, position) values ('bbbbca76-d37d-5ffa-a0f0-1bbc9e08ceee', '26a0af12-7081-51fe-bc00-606a41d77a53', 2);
insert into public.event_artists (event_id, entity_id, position) values ('bbbbca76-d37d-5ffa-a0f0-1bbc9e08ceee', 'b6a964c8-20b7-5798-95e4-4268ad72e503', 3);
insert into public.event_artists (event_id, entity_id, position) values ('bbbbca76-d37d-5ffa-a0f0-1bbc9e08ceee', '1170fcf9-03e5-5d27-ace4-27ecbc379c8a', 4);
insert into public.event_artists (event_id, entity_id, position) values ('bbbbca76-d37d-5ffa-a0f0-1bbc9e08ceee', '902089a0-e79a-5e65-a36d-88a481eb3079', 5);
insert into public.event_artists (event_id, entity_id, position) values ('bbbbca76-d37d-5ffa-a0f0-1bbc9e08ceee', 'b270a436-640d-546b-aa06-da593287174c', 6);
commit;
