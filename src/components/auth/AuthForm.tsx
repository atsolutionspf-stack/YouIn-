'use client';
import { useState, type FormEvent } from 'react';
import { useRouter, useSearchParams } from 'next/navigation';
import { useSession } from '@/components/providers/SessionProvider';
import { Intro, NoBackend } from '@/components/ui/States';
import { Icon } from '@/components/ui/Icon';
import { friendlyError } from '@/lib/data/errors';
import { SITE_URL } from '@/lib/config';

function safeNext(v: string | null) {
  return v && v.startsWith('/') && !v.startsWith('//') ? v : '/perfil';
}

export function AuthForm() {
  const { db, configured, user } = useSession();
  const router = useRouter();
  const params = useSearchParams();
  const [mode, setMode] = useState<'login' | 'registro'>(params.get('modo') === 'registro' ? 'registro' : 'login');
  const [busy, setBusy] = useState(false);
  const [error, setError] = useState(params.get('error') === 'confirmacion' ? 'El enlace de confirmación no es válido o ha caducado.' : '');
  const [info, setInfo] = useState('');
  const next = safeNext(params.get('next'));

  if (!configured || !db) return <NoBackend feature="Las cuentas" />;

  async function submit(e: FormEvent<HTMLFormElement>) {
    e.preventDefault();
    if (!db) return;
    const form = new FormData(e.currentTarget);
    const email = String(form.get('email') ?? '').trim();
    const password = String(form.get('password') ?? '');
    setBusy(true);
    setError('');
    setInfo('');
    try {
      if (mode === 'registro') {
        const name = String(form.get('name') ?? '').trim();
        if (!name) throw new Error('Indica tu nombre o alias.');
        if (password.length < 8) throw new Error('La contraseña debe tener al menos 8 caracteres.');
        const { data, error } = await db.auth.signUp({
          email, password,
          options: { data: { display_name: name }, emailRedirectTo: `${SITE_URL}/auth/confirm?next=${encodeURIComponent(next)}` },
        });
        if (error) throw error;
        if (!data.session) {
          setInfo('Te hemos enviado un correo para confirmar tu cuenta. Ábrelo y vuelve a entrar.');
          return;
        }
      } else {
        const { error } = await db.auth.signInWithPassword({ email, password });
        if (error) throw error;
      }
      router.push(next);
      router.refresh();
    } catch (err) {
      setError(friendlyError(err));
    } finally {
      setBusy(false);
    }
  }

  return (
    <>
      <Intro kicker="Aquí también estás tú" title={<>Una cuenta.<br /><em>Muchas formas de vivirlo.</em></>}
        sub="Tu perfil de usuario y DJ, juntos. Tus salas y colectivos, por separado." />
      <section className="panel auth-card">
        {user && <div className="notice" style={{ marginBottom: 16 }}>Ya has iniciado sesión. <a className="link" href="/perfil">Ir a tu perfil</a></div>}
        <div className="segmented auth-switch" role="tablist">
          <button role="tab" aria-selected={mode === 'login'} className={mode === 'login' ? 'active' : ''} onClick={() => setMode('login')} type="button">Entrar</button>
          <button role="tab" aria-selected={mode === 'registro'} className={mode === 'registro' ? 'active' : ''} onClick={() => setMode('registro')} type="button">Crear cuenta</button>
        </div>
        <form onSubmit={submit} noValidate={false}>
          {mode === 'registro' && (
            <label>Tu nombre o alias<input name="name" required maxLength={50} autoComplete="nickname" placeholder="¿Cómo te llamas?" /></label>
          )}
          <label>Correo electrónico<input name="email" type="email" required autoComplete="email" /></label>
          <label>Contraseña<input name="password" type="password" required minLength={8} autoComplete={mode === 'login' ? 'current-password' : 'new-password'} /></label>
          {mode === 'registro' && <p className="help">Mínimo 8 caracteres. Podrás activar tu perfil de DJ o crear salas y colectivos después.</p>}
          <div className="form-error" role="alert">{error}</div>
          {info && <div className="notice" role="status" style={{ marginBottom: 14 }}>{info}</div>}
          <button className="primary full" disabled={busy}>
            {busy ? 'Un momento…' : mode === 'login' ? 'Entrar' : 'Crear mi cuenta'} <Icon name="arrow" size={16} />
          </button>
        </form>
        <hr className="divider" />
        <details className="demo-accounts">
          <summary>Cuentas de prueba (datos de demostración)</summary>
          <p className="help" style={{ marginTop: 10 }}>
            Solo existen si has sembrado la base de datos con los datos demo. Contraseña común: <code>demo-youin-2026</code>
          </p>
          <ul className="benefits">
            <li><code>ana@demo.youin.local</code> y <code>leo@demo.youin.local</code> · usuarias</li>
            <li><code>arena@demo.youin.local</code> · administra House Arena (referidos)</li>
            <li><code>casagroove@demo.youin.local</code> · administra Casa Groove y El Patio Club</li>
            <li><code>sala@demo.youin.local</code> · administra Nave 08 y Onda Libre</li>
            <li><code>luna@demo.youin.local</code> · DJ Luna Serra</li>
          </ul>
        </details>
      </section>
    </>
  );
}
