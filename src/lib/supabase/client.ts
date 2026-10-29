'use client';
import { createBrowserClient } from '@supabase/ssr';
import type { SupabaseClient } from '@supabase/supabase-js';
import type { Database } from '@/lib/database.types';
import { SUPABASE_PUBLISHABLE_KEY, SUPABASE_URL, isSupabaseConfigured } from '@/lib/config';

let client: SupabaseClient<Database> | null = null;

/** Cliente del navegador (singleton). Devuelve null en modo demo sin servidor. */
export function getBrowserClient(): SupabaseClient<Database> | null {
  if (!isSupabaseConfigured) return null;
  client ??= createBrowserClient<Database>(SUPABASE_URL, SUPABASE_PUBLISHABLE_KEY);
  return client;
}
