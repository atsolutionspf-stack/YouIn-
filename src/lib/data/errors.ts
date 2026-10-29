// Traduce errores de Supabase/PostgREST a mensajes comprensibles.
type PgError = { message?: string; code?: string; details?: string | null; hint?: string | null } | null | undefined;

export function friendlyError(error: PgError | Error | unknown, fallback = 'Algo ha fallado. Inténtalo de nuevo.'): string {
  if (!error) return fallback;
  const e = error as PgError & { status?: number };
  const msg = e?.message ?? '';
  if (e?.code === '42501' || /row-level security|permission denied/i.test(msg)) {
    return 'No tienes permisos para hacer esto.';
  }
  if (e?.code === '28000' || /JWT|not authenticated|Auth session missing/i.test(msg)) return 'Necesitas iniciar sesión.';
  if (e?.code === '23505') return 'Ese registro ya existe.';
  if (e?.code === '23514') return 'Hay datos que no cumplen las reglas (revisa fechas, coordenadas o longitudes).';
  if (/Failed to fetch|NetworkError|fetch failed/i.test(msg)) return 'Sin conexión con el servidor. Comprueba tu red.';
  if (/Invalid login credentials/i.test(msg)) return 'Correo o contraseña incorrectos.';
  if (/User already registered/i.test(msg)) return 'Ya existe una cuenta con ese correo.';
  if (/Password should be/i.test(msg)) return 'La contraseña debe tener al menos 8 caracteres.';
  if (/Email not confirmed/i.test(msg)) return 'Confirma tu correo antes de entrar (revisa tu bandeja).';
  // Los mensajes propios de las funciones SQL ya están en español.
  return msg || fallback;
}

export function isPermissionError(error: PgError): boolean {
  return Boolean(error && (error.code === '42501' || /row-level security|permission/i.test(error.message ?? '')));
}
