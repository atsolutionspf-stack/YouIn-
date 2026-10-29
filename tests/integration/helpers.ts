import { createClient, type SupabaseClient } from '@supabase/supabase-js';
import { randomUUID } from 'node:crypto';

export const URL = process.env.NEXT_PUBLIC_SUPABASE_URL ?? 'http://127.0.0.1:54321';
export const KEY = process.env.NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY ?? 'sb_publishable_ACJWlzQHlZjBrEguHvfOxg_3BJgxAaH';
export const DEMO_PASSWORD = 'demo-youin-2026';

export function anon(): SupabaseClient {
  return createClient(URL, KEY, { auth: { persistSession: false, autoRefreshToken: false } });
}

/** Cliente con sesión de una cuenta de prueba sembrada. */
export async function demoUser(key: 'arena' | 'casagroove' | 'sala' | 'luna' | 'nico' | 'ana' | 'leo') {
  const c = anon();
  const { data, error } = await c.auth.signInWithPassword({ email: `${key}@demo.youin.local`, password: DEMO_PASSWORD });
  if (error) throw error;
  return { client: c, user: data.user! };
}

/** Registra una cuenta nueva (aislada por prueba). */
export async function freshUser(name = 'Prueba') {
  const c = anon();
  const email = `test-${randomUUID().slice(0, 8)}@example.test`;
  const password = 'test-password-123';
  const { data, error } = await c.auth.signUp({ email, password, options: { data: { display_name: name } } });
  if (error) throw error;
  if (!data.session) throw new Error('signUp sin sesión: desactiva la confirmación de email en local');
  return { client: c, user: data.user!, email, password };
}

export async function communityBySlug(c: SupabaseClient, slug: string) {
  const { data, error } = await c.from('communities').select('id, entity_id, name').eq('slug', slug).single();
  if (error) throw error;
  return data;
}

export const sleep = (ms: number) => new Promise((r) => setTimeout(r, ms));
export const opKey = () => randomUUID();
