'use client';
import Link from 'next/link';
import { usePathname } from 'next/navigation';
import type { ReactNode } from 'react';
import { Icon, type IconName } from '@/components/ui/Icon';
import { useSession } from '@/components/providers/SessionProvider';

const NAV: { href: string; icon: IconName; label: string }[] = [
  { href: '/', icon: 'map', label: 'Mapa' },
  { href: '/explorar', icon: 'search', label: 'Explorar' },
  { href: '/favoritos', icon: 'heart', label: 'Favoritos' },
  { href: '/comunidades', icon: 'chat', label: 'Comunidades' },
  { href: '/perfil', icon: 'user', label: 'Perfil' },
];

function isActive(pathname: string, href: string) {
  if (href === '/') return pathname === '/' || pathname.startsWith('/eventos');
  if (href === '/perfil') return pathname.startsWith('/perfil') || pathname.startsWith('/panel') || pathname.startsWith('/recompensas');
  if (href === '/explorar') return pathname.startsWith('/explorar') || pathname.startsWith('/p/');
  return pathname.startsWith(href);
}

function Nav({ type }: { type: 'desktop-nav' | 'bottom-nav' }) {
  const pathname = usePathname();
  const { unreadTotal } = useSession();
  return (
    <nav className={type} aria-label="Navegación principal">
      {NAV.map((item) => {
        const active = isActive(pathname, item.href);
        return (
          <Link key={item.href} href={item.href} className={active ? 'active' : ''} aria-current={active ? 'page' : undefined}>
            <span className="nav-icon"><Icon name={item.icon} /></span>
            <span>{item.label}</span>
            {item.href === '/comunidades' && unreadTotal > 0 && (
              <span className="unread-dot" aria-label={`${unreadTotal} mensajes sin leer`}>{unreadTotal > 99 ? '99+' : unreadTotal}</span>
            )}
          </Link>
        );
      })}
    </nav>
  );
}

export function AppShell({ children }: { children: ReactNode }) {
  const { user, profile, configured, entities } = useSession();
  return (
    <>
      <a className="skip" href="#main">Saltar al contenido</a>
      <header className="topbar">
        <div className="brandline">
          <Link className="brand" href="/" aria-label="YOU IN? · Inicio">
            {/* Logotipo original del piloto */}
            { }
            <img className="wordmark" src="/brand/logo.svg" alt="You In" />
          </Link>
          <span className="location"><Icon name="pin" size={16} /> Valencia y alrededores</span>
        </div>
        <Nav type="desktop-nav" />
        <div className="toplinks">
          <span className={`demo-badge ${configured ? '' : 'warn'}`} title={configured ? 'Primera versión compartida' : 'Sin servidor configurado'}>
            {configured ? 'Beta · prueba' : 'Demo sin servidor'}
          </span>
          {user && entities.some((e) => e.kind !== 'dj' || e.community_id) && (
            <Link className="text-button panel-link" href="/panel"><Icon name="settings" size={15} /> Panel</Link>
          )}
          {configured && (
            <Link className="pill dark" href={user ? '/perfil' : '/entrar'}>
              {user ? (profile?.display_name.split(' ')[0] ?? 'Tu perfil') : 'Entrar'} <Icon name="arrow" size={14} />
            </Link>
          )}
        </div>
      </header>
      <main id="main" className="shell" tabIndex={-1}>
        {children}
        <footer className="footer">
          <span>Hecho para encontrarnos. &nbsp; Valencia, primer capítulo.</span>
          <span>
            Datos importados y demo etiquetados · <Link href="/acerca">Sobre YOU IN? y las fuentes</Link>
          </span>
        </footer>
      </main>
      <Nav type="bottom-nav" />
    </>
  );
}
