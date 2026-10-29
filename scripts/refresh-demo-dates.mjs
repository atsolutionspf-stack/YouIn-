#!/usr/bin/env node
// Desplaza las fechas de los eventos DEMO para que vuelvan a empezar hoy
// (útil si el entorno lleva días encendido). Usa la clave secreta de servidor.
// Uso: node --env-file=.env.local scripts/refresh-demo-dates.mjs
import { createClient } from '@supabase/supabase-js';

const url = process.env.NEXT_PUBLIC_SUPABASE_URL;
const key = process.env.SUPABASE_SECRET_KEY;
if (!url || !key) {
  console.error('Faltan NEXT_PUBLIC_SUPABASE_URL o SUPABASE_SECRET_KEY.');
  process.exit(1);
}
const db = createClient(url, key, { auth: { persistSession: false } });
const { data, error } = await db.rpc('refresh_demo_event_dates');
if (error) { console.error(error.message); process.exit(1); }
console.log(`Eventos demo actualizados: ${data}`);
