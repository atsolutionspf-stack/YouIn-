import 'server-only';
import { createClient } from '@supabase/supabase-js';
import type { Database } from '@/lib/database.types';
import { SUPABASE_PUBLISHABLE_KEY, SUPABASE_URL, isSupabaseConfigured } from '@/lib/config';

/** Cliente de servidor sin sesión: solo datos públicos (p. ej. metadatos para compartir). */
export function getPublicServerClient() {
  if (!isSupabaseConfigured) return null;
  return createClient<Database>(SUPABASE_URL, SUPABASE_PUBLISHABLE_KEY, { auth: { persistSession: false, autoRefreshToken: false } });
}
