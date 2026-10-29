// Configuración pública. Si falta Supabase, la app funciona en "modo demo sin
// servidor": solo descubrimiento de eventos con los datos incluidos, sin
// cuentas, comunidades ni recompensas (y se indica claramente en la interfaz).

export const SUPABASE_URL = process.env.NEXT_PUBLIC_SUPABASE_URL ?? '';
export const SUPABASE_PUBLISHABLE_KEY = process.env.NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY ?? '';
export const SITE_URL = process.env.NEXT_PUBLIC_SITE_URL ?? 'http://localhost:3000';

export const isSupabaseConfigured = Boolean(SUPABASE_URL && SUPABASE_PUBLISHABLE_KEY);

// Teselas del mapa. Por defecto, OpenStreetMap estándar (solo apto para
// desarrollo y tráfico bajo según su política de uso). En producción, configura
// un proveedor con contrato o clave (ver README).
export const MAP_TILE_URL = process.env.NEXT_PUBLIC_MAP_TILE_URL || 'https://tile.openstreetmap.org/{z}/{x}/{y}.png';
export const MAP_ATTRIBUTION =
  process.env.NEXT_PUBLIC_MAP_ATTRIBUTION || '© <a href="https://www.openstreetmap.org/copyright" target="_blank" rel="noopener">OpenStreetMap</a>';
export const MAP_TILES_ARE_DEFAULT_OSM = !process.env.NEXT_PUBLIC_MAP_TILE_URL;

export const MEDIA_BUCKET = 'media';
