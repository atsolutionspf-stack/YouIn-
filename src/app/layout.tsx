import type { Metadata, Viewport } from 'next';
import './pilot.css';
import './youin.css';
import 'leaflet/dist/leaflet.css';
import 'leaflet.markercluster/dist/MarkerCluster.css';
import { ToastProvider } from '@/components/ui/Toast';
import { SessionProvider } from '@/components/providers/SessionProvider';
import { DiscoveryProvider } from '@/components/providers/DiscoveryProvider';
import { AppShell } from '@/components/layout/AppShell';
import { SITE_URL } from '@/lib/config';

export const metadata: Metadata = {
  metadataBase: new URL(SITE_URL),
  title: { default: 'YOU IN? — Encuentra tu gente', template: '%s · YOU IN?' },
  description: 'Encuentra tu música y tu gente en Valencia. Eventos en el mapa, artistas, salas, colectivos y sus comunidades.',
  icons: { icon: '/brand/icon.svg' },
};

export const viewport: Viewport = { themeColor: '#FBF4EA', width: 'device-width', initialScale: 1, viewportFit: 'cover' };

export default function RootLayout({ children }: { children: React.ReactNode }) {
  return (
    <html lang="es">
      <head>
        {/* Tipografías del piloto (DM Sans + Manrope). Si no cargan, hay alternativas del sistema. */}
        <link rel="preconnect" href="https://fonts.googleapis.com" />
        <link rel="preconnect" href="https://fonts.gstatic.com" crossOrigin="" />
        {/* eslint-disable-next-line @next/next/no-page-custom-font */}
        <link
          rel="stylesheet"
          href="https://fonts.googleapis.com/css2?family=DM+Sans:wght@400;450;500;550;600;650;700&family=Manrope:wght@400;500;600;650;700;750;800&display=swap"
        />
      </head>
      <body>
        <ToastProvider>
          <SessionProvider>
            <DiscoveryProvider>
              <AppShell>{children}</AppShell>
            </DiscoveryProvider>
          </SessionProvider>
        </ToastProvider>
      </body>
    </html>
  );
}
