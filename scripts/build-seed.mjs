#!/usr/bin/env node
// Genera los datos de prueba de Supabase a partir de:
//   * data/demo/demo-data.mjs (datos ficticios de demostración, data_origin = 'demo')
//   * data/import/pilot-ticketing-snapshot-2026-10-19.json (importación puntual del piloto,
//     data_origin = 'imported', con fuentes y fecha de consulta)
// Salida: supabase/seeds/01_demo.sql y supabase/seeds/02_imported.sql
//
// Uso: node scripts/build-seed.mjs

import { createHash } from 'node:crypto';
import { readFileSync, writeFileSync, mkdirSync } from 'node:fs';
import { dirname, join } from 'node:path';
import { fileURLToPath } from 'node:url';
import { demo } from '../data/demo/demo-data.mjs';
import { validateImportedEvent, validateImportedProfile } from './import-validation.mjs';

const root = join(dirname(fileURLToPath(import.meta.url)), '..');
const snapshot = JSON.parse(readFileSync(join(root, 'data/import/pilot-ticketing-snapshot-2026-10-19.json'), 'utf8'));

// UUID estable a partir de una clave (formato v5 sin depender de librerías).
export function stableUuid(key) {
  const h = createHash('sha1').update('youin:' + key).digest();
  h[6] = (h[6] & 0x0f) | 0x50;
  h[8] = (h[8] & 0x3f) | 0x80;
  const x = h.subarray(0, 16).toString('hex');
  return `${x.slice(0, 8)}-${x.slice(8, 12)}-${x.slice(12, 16)}-${x.slice(16, 20)}-${x.slice(20)}`;
}

const q = (v) => (v === null || v === undefined ? 'null' : `'${String(v).replace(/'/g, "''")}'`);
const num = (v) => (v === null || v === undefined || !Number.isFinite(Number(v)) ? 'null' : String(Number(v)));
const bool = (v) => (v ? 'true' : 'false');
const arr = (a) => (a && a.length ? `array[${a.map(q).join(', ')}]::text[]` : `'{}'::text[]`);
const json = (v) => `${q(JSON.stringify(v ?? null))}::jsonb`;

export function slugify(text) {
  return String(text || '')
    .normalize('NFD').replace(/[̀-ͯ]/g, '')
    .toLowerCase().replace(/[^a-z0-9]+/g, '-').replace(/^-+|-+$/g, '')
    .slice(0, 60) || 'perfil';
}
const usedSlugs = new Set();
function uniqueSlug(name) {
  let base = slugify(name);
  if (base.length < 2) base = 'perfil-' + base;
  let slug = base;
  let n = 1;
  while (usedSlugs.has(slug)) slug = `${base}-${++n}`;
  usedSlugs.add(slug);
  return slug;
}

// Fecha relativa a "hoy" en Madrid, calculada por Postgres al sembrar.
const madrid = (dayOffset, hhmm) =>
  `((date_trunc('day', now() at time zone 'Europe/Madrid') + interval '${dayOffset} days' + time '${hhmm}') at time zone 'Europe/Madrid')`;

// ---------------------------------------------------------------------------
// 01_demo.sql
// ---------------------------------------------------------------------------
function buildDemo() {
  const out = [];
  out.push('-- DATOS DE DEMOSTRACIÓN · ficticios · generados por scripts/build-seed.mjs');
  out.push('-- Cuentas de prueba: correo @demo.youin.local · contraseña común indicada en README.');
  out.push('begin;');

  for (const u of demo.users) {
    const id = stableUuid('user:' + u.key);
    out.push(`insert into auth.users (instance_id, id, aud, role, email, encrypted_password, email_confirmed_at,
  raw_app_meta_data, raw_user_meta_data, created_at, updated_at, confirmation_token, recovery_token,
  email_change_token_new, email_change, email_change_token_current, phone_change, phone_change_token, reauthentication_token)
values ('00000000-0000-0000-0000-000000000000', ${q(id)}, 'authenticated', 'authenticated', ${q(u.email)},
  extensions.crypt(${q(demo.password)}, extensions.gen_salt('bf')), now(),
  '{"provider":"email","providers":["email"]}'::jsonb, ${json({ display_name: u.name })}, now(), now(), '', '', '', '', '', '', '', '');`);
    out.push(`insert into auth.identities (id, user_id, provider_id, identity_data, provider, last_sign_in_at, created_at, updated_at)
values (${q(id)}, ${q(id)}, ${q(id)}, ${json({ sub: id, email: u.email, email_verified: true })}, 'email', now(), now(), now());`);
  }

  for (const e of demo.entities) {
    const id = stableUuid('entity:' + e.key);
    const userId = e.kind === 'dj' && e.owner ? stableUuid('user:' + e.owner) : null;
    out.push(`insert into public.entities (id, kind, slug, name, tagline, bio, genres, area, municipality, province, address, lat, lng,
  initials, color, accent, profile_font, links, data_origin, user_id)
values (${q(id)}, ${q(e.kind)}, ${q(uniqueSlug(e.name))}, ${q(e.name)}, ${q(e.tagline)}, ${q(e.bio)}, ${arr(e.genres)}, ${q(e.area)},
  ${q(e.municipality ?? 'València')}, ${q(e.province ?? 'Valencia')}, ${q(e.address)}, ${num(e.lat)}, ${num(e.lng)},
  ${q(e.initials)}, ${q(e.color)}, ${q(e.accent ?? '#765466')}, ${q(e.font ?? 'Manrope')}, ${json(e.links ?? {})}, 'demo', ${q(userId)});`);
    for (const admin of e.admins ?? []) {
      out.push(`insert into public.entity_admins (entity_id, user_id, role) values (${q(id)}, ${q(stableUuid('user:' + admin.user))}, ${q(admin.role)});`);
    }
  }

  for (const c of demo.communities) {
    const id = stableUuid('community:' + c.key);
    out.push(`insert into public.communities (id, entity_id, slug, name, description, genres, free_benefits, welcome_message, rules, is_demo)
values (${q(id)}, ${q(stableUuid('entity:' + c.entity))}, ${q(c.slug)}, ${q(c.name)}, ${q(c.description)}, ${arr(c.genres)},
  ${arr(c.benefits)}, ${q(c.welcome)}, ${q(c.rules)}, true);`);
    if (c.club) {
      out.push(`insert into public.clubs (community_id, name, description, price_cents, billing_interval, benefits, status)
values (${q(id)}, ${q(c.club.name)}, ${q(c.club.description)}, ${num(c.club.priceCents)}, 'month', ${arr(c.club.benefits)}, 'preview');`);
    }
    for (const m of c.members ?? []) {
      out.push(`insert into public.community_members (community_id, user_id) values (${q(id)}, ${q(stableUuid('user:' + m))});`);
    }
    for (const msg of c.messages ?? []) {
      out.push(`insert into public.messages (community_id, channel, author_id, body, created_at)
values (${q(id)}, ${q(msg.channel)}, ${q(stableUuid('user:' + msg.author))}, ${q(msg.body)}, now());`);
    }
  }

  for (const ev of demo.events) {
    const id = stableUuid('event:' + ev.key);
    out.push(`insert into public.events (id, title, description, starts_at, ends_at, venue_entity_id, venue_name, address, area, municipality,
  province, lat, lng, location_precision, genre, price, price_kind, ticket_url, poster_style, organizer_entity_id, status, data_origin)
values (${q(id)}, ${q(ev.title)}, ${q(ev.description)}, ${madrid(ev.day, ev.start)}, ${madrid(ev.endDay ?? ev.day, ev.end)},
  ${ev.venue ? q(stableUuid('entity:' + ev.venue)) : 'null'}, ${q(ev.venueName)}, ${q(ev.address)}, ${q(ev.area)},
  ${q(ev.municipality ?? 'València')}, ${q(ev.province ?? 'Valencia')}, ${num(ev.lat)}, ${num(ev.lng)}, 'organizer-pin',
  ${q(ev.genre)}, ${num(ev.price)}, 'fixed', null, ${q(ev.poster)}, ${q(stableUuid('entity:' + ev.organizer))}, 'published', 'demo');`);
    (ev.djs ?? []).forEach((dj, i) => {
      out.push(`insert into public.event_artists (event_id, entity_id, position) values (${q(id)}, ${q(stableUuid('entity:' + dj))}, ${i});`);
    });
  }

  for (const camp of demo.campaigns) {
    const id = stableUuid('campaign:' + camp.key);
    out.push(`insert into public.referral_campaigns (id, community_id, event_id, name, description, mode, status, starts_at, ends_at, is_demo, created_by)
values (${q(id)}, ${q(stableUuid('community:' + camp.community))}, ${camp.event ? q(stableUuid('event:' + camp.event)) : 'null'},
  ${q(camp.name)}, ${q(camp.description)}, 'simulation', 'active', now() - interval '1 day', ${madrid(camp.endsInDays, '23:59')}, true,
  ${q(stableUuid('user:' + camp.createdBy))});`);
    out.push(`insert into public.campaign_rules (campaign_id, version, base_threshold, step_size, max_extra, conditions, created_by)
values (${q(id)}, 1, ${num(camp.base)}, ${num(camp.step)}, null, ${q(camp.conditions)}, ${q(stableUuid('user:' + camp.createdBy))});`);
  }

  out.push('commit;');
  return out.join('\n') + '\n';
}

// ---------------------------------------------------------------------------
// 02_imported.sql
// ---------------------------------------------------------------------------
function buildImported() {
  const { meta, events, profiles } = snapshot;
  const out = [];
  const batchId = stableUuid('import:' + meta.revision);
  out.push('-- IMPORTACIÓN PUNTUAL del piloto (You-in-piloto-4.html) · NO es una integración activa.');
  out.push(`-- Consulta: ${meta.retrievedAt} · revisión ${meta.revision} · ${meta.total} eventos.`);
  out.push('begin;');
  out.push(`insert into public.import_batches (id, label, revision, retrieved_at, coverage, window_info, stats, automatic_sync)
values (${q(batchId)}, 'Eventos anunciados en Fourvenues, Marina Beach Club y Xceed', ${q(meta.revision)}, ${q(meta.retrievedAt)},
  ${q(meta.coverage)}, ${json(meta.window)}, ${json({ total: meta.total, byProvider: meta.byProvider, duplicatesRemoved: meta.duplicatesRemoved, unknownPrices: meta.unknownPrices, withoutCoordinates: meta.withoutCoordinates, sourcePages: ['https://marinabeachclub.com/calendario-eventos/', 'https://xceed.me/es/valencia/events', 'https://site.fourvenues.com/es/nightlife-valencia'] })}, false);`);

  const rejected = [];
  const entityId = new Map();
  for (const p of profiles) {
    const problem = validateImportedProfile(p);
    if (problem) { rejected.push(`perfil ${p.id}: ${problem}`); continue; }
    const id = stableUuid('imported-entity:' + p.id);
    entityId.set(p.id, id);
    const kind = p.role === 'Sala' ? 'venue' : 'dj';
    const genres = p.genre && p.genre !== 'Programación publicada' ? [p.genre] : [];
    out.push(`insert into public.entities (id, kind, slug, name, bio, genres, area, municipality, province, address, lat, lng, image_url,
  initials, color, data_origin, source_url, source_key)
values (${q(id)}, ${q(kind)}, ${q(uniqueSlug(p.name))}, ${q(p.name)}, ${q(p.bio)}, ${arr(genres)}, ${q(p.area)}, ${kind === 'venue' ? "'València'" : 'null'},
  ${kind === 'venue' ? "'Valencia'" : 'null'}, ${q(p.address)}, ${num(p.lat)}, ${num(p.lng)}, ${q(p.imageURL || null)},
  ${q(p.initials)}, ${q(p.color)}, 'imported', ${q(p.sourceURL || null)}, ${q('pilot:' + p.id)});`);
  }

  for (const e of events) {
    const problem = validateImportedEvent(e);
    if (problem) { rejected.push(`evento ${e.id}: ${problem}`); continue; }
    const id = stableUuid('imported-event:' + e.sourceEventKey);
    const provider = e.sourceEventKey.startsWith('xceed:') ? 'xceed' : 'fourvenues';
    const priceKind = e.price === null || e.price === undefined ? 'unknown' : e.priceKind;
    out.push(`insert into public.events (id, title, description, starts_at, ends_at, until_late, time_warning, venue_entity_id, venue_name, room,
  address, area, municipality, province, lat, lng, location_precision, genre, source_genres, price, price_kind, price_note, ticket_url,
  ticket_provider_id, poster_url, poster_style, age, status, data_origin, import_batch_id, source_event_key, sources, verified_at)
values (${q(id)}, ${q(e.title)}, ${q(e.description)}, ${q(e.start)}, ${q(e.end)}, ${bool(e.isUntilLate)}, ${q(e.timeWarning)},
  ${q(entityId.get(e.venueId) ?? null)}, ${q(e.venue)}, ${q(e.room || null)}, ${q(e.address)}, ${q(e.area)}, ${q(e.municipality)},
  ${q(e.province)}, ${num(e.lat)}, ${num(e.lng)}, 'source-coordinates', ${q(e.genre)}, ${arr(e.sourceGenres)}, ${num(e.price)},
  ${q(priceKind)}, ${q(e.priceNote)}, ${q(e.ticket || null)}, ${q(provider)}, ${q(e.posterURL || null)}, ${q(e.poster || 'groove')},
  ${q(e.age === null || e.age === undefined ? null : String(e.age))}, ${e.cancelled ? "'cancelled'" : "'published'"}, 'imported',
  ${q(batchId)}, ${q(e.sourceEventKey)}, ${json(e.sources)}, ${q(e.verifiedAt || meta.retrievedAt)});`);
    (e.djs || []).forEach((dj, i) => {
      if (entityId.has(dj)) {
        out.push(`insert into public.event_artists (event_id, entity_id, position) values (${q(id)}, ${q(entityId.get(dj))}, ${i});`);
      }
    });
  }
  out.push('commit;');
  if (rejected.length) {
    console.warn(`Registros descartados por validación (${rejected.length}):\n  ` + rejected.join('\n  '));
  }
  return out.join('\n') + '\n';
}

const seedsDir = join(root, 'supabase/seeds');
mkdirSync(seedsDir, { recursive: true });
const demoSql = buildDemo();
const importedSql = buildImported();
writeFileSync(join(seedsDir, '01_demo.sql'), demoSql);
writeFileSync(join(seedsDir, '02_imported.sql'), importedSql);
console.log(`Escrito supabase/seeds/01_demo.sql (${demoSql.length} B) y 02_imported.sql (${importedSql.length} B)`);
