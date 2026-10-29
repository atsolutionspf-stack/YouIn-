import { type EmailOtpType } from '@supabase/supabase-js';
import { NextResponse, type NextRequest } from 'next/server';
import { getServerClient } from '@/lib/supabase/server';

// Enlace de confirmación de correo (cuando la confirmación está activada en Supabase).
export async function GET(request: NextRequest) {
  const { searchParams, origin } = new URL(request.url);
  const token_hash = searchParams.get('token_hash');
  const type = searchParams.get('type') as EmailOtpType | null;
  const nextParam = searchParams.get('next') ?? '/perfil';
  const next = nextParam.startsWith('/') && !nextParam.startsWith('//') ? nextParam : '/perfil';
  const db = await getServerClient();
  if (db && token_hash && type) {
    const { error } = await db.auth.verifyOtp({ type, token_hash });
    if (!error) return NextResponse.redirect(new URL(next, origin));
  }
  return NextResponse.redirect(new URL('/entrar?error=confirmacion', origin));
}
