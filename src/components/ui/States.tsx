'use client';
import Link from 'next/link';
import type { ReactNode } from 'react';
import { Icon, type IconName } from './Icon';

/** Estados comunes: carga, error, vacío, permisos y sesión. */

export function Loading({ label = 'Cargando…' }: { label?: string }) {
  return (
    <div className="state-loading" role="status" aria-live="polite">
      <span className="spinner" aria-hidden="true" />
      <span>{label}</span>
    </div>
  );
}

export function Empty({
  title, children, icon = 'search', action,
}: { title: string; children?: ReactNode; icon?: IconName; action?: ReactNode }) {
  return (
    <div className="empty">
      <div className="icon-circle"><Icon name={icon} size={25} /></div>
      <h3>{title}</h3>
      {children && <p>{children}</p>}
      {action}
    </div>
  );
}

export function ErrorState({ message, onRetry }: { message: string; onRetry?: () => void }) {
  return (
    <div className="empty state-error" role="alert">
      <div className="icon-circle"><Icon name="close" size={22} /></div>
      <h3>No hemos podido cargar esto</h3>
      <p>{message}</p>
      {onRetry && <button className="secondary" onClick={onRetry}>Reintentar</button>}
    </div>
  );
}

export function PermissionDenied({ children }: { children?: ReactNode }) {
  return (
    <Empty title="No tienes permisos para ver esto" icon="lock">
      {children ?? 'Esta sección solo está disponible para su administración.'}
    </Empty>
  );
}

export function NeedsLogin({ next, children }: { next: string; children?: ReactNode }) {
  return (
    <section className="lead-panel">
      <div>
        <h2>Tu próxima conexión empieza aquí.</h2>
        <p>{children ?? 'Entra o crea tu cuenta para guardar eventos, seguir perfiles y unirte a comunidades.'}</p>
        <div className="actions">
          <Link className="primary peach" href={`/entrar?next=${encodeURIComponent(next)}`}>Entrar <Icon name="arrow" size={17} /></Link>
          <Link className="pill on-dark" href={`/entrar?modo=registro&next=${encodeURIComponent(next)}`}>Crear cuenta</Link>
        </div>
      </div>
      <div className="record-art"><img src="/brand/icon.svg" alt="" /></div>
    </section>
  );
}

export function NoBackend({ feature }: { feature: string }) {
  return (
    <Empty title={`${feature} necesita el servidor`} icon="lock">
      Esta instalación está en <strong>modo demo sin servidor</strong>: no hay cuentas ni datos compartidos. Configura Supabase
      (ver README) para usar {feature.toLowerCase()} con usuarios reales.
    </Empty>
  );
}

export function Intro({ kicker, title, sub, extra, compactOnMobile }: { kicker: string; title: ReactNode; sub?: ReactNode; extra?: ReactNode; compactOnMobile?: boolean }) {
  return (
    <div className={`intro ${compactOnMobile ? 'compact-mobile' : ''}`}>
      <div>
        <div className="eyebrow"><span className="dot" />{kicker}</div>
        <h1>{title}</h1>
        {sub && <p>{sub}</p>}
      </div>
      {extra ?? <div className="edition">TU CIUDAD. TU MÚSICA.<br />TU GENTE.</div>}
    </div>
  );
}
