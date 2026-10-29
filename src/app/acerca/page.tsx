import type { Metadata } from 'next';
import Link from 'next/link';
import { Intro } from '@/components/ui/States';
import { Icon } from '@/components/ui/Icon';
import snapshot from '../../../data/import/pilot-ticketing-snapshot-2026-10-19.json';

export const metadata: Metadata = { title: 'Sobre YOU IN? y las fuentes' };

const meta = snapshot.meta;
const consulted = new Intl.DateTimeFormat('es-ES', { timeZone: 'Europe/Madrid', day: '2-digit', month: '2-digit', year: 'numeric', hour: '2-digit', minute: '2-digit' }).format(new Date(meta.retrievedAt));

export default function Page() {
  return (
    <>
      <Intro kicker="YOU IN? · primera versión compartida" title={<>Tu música. Tu gente.<br /><em>Tu ciudad.</em></>}
        sub="Descubre un evento en el mapa, conoce a quien lo hace posible, síguelo, entra en su comunidad y vuelve." />
      <div className="profile-layout">
        <section className="panel">
          <h3 style={{ marginTop: 0 }}>Qué es real y qué es de prueba</h3>
          <ul className="benefits">
            <li><strong>Real:</strong> cuentas, favoritos, seguimiento, comunidades, chat en tiempo real entre personas, publicación de eventos y permisos, guardados en una base de datos compartida.</li>
            <li><strong>Importado:</strong> eventos y perfiles de una consulta puntual a páginas públicas de ticketing (ver abajo). Referencias informativas, sin reclamar.</li>
            <li><strong>Demo:</strong> perfiles, comunidades y eventos ficticios (incluida House Arena) marcados como tales.</li>
            <li><strong>Simulado:</strong> las compras de la campaña de referidos de House Arena y sus invitaciones.</li>
            <li><strong>Aún no disponible:</strong> cobros del club de pago, integraciones con vendedores y mensajes privados.</li>
          </ul>
          <h4>Privacidad</h4>
          <p className="muted" style={{ fontSize: 13 }}>
            La ubicación solo se pide al pulsar «Cerca de mí» y no se guarda. Tus favoritos y seguidos son privados. Tu nombre visible aparece junto a tus mensajes.
            El mapa carga teselas del proveedor configurado (por defecto OpenStreetMap) y las tipografías se sirven desde Google Fonts. Puedes exportar tus datos desde tu perfil.
          </p>
        </section>
        <section className="panel" id="fuentes">
          <h3 style={{ marginTop: 0 }}>Eventos anunciados · fuentes y cobertura</h3>
          <p className="muted" style={{ fontSize: 13 }}>
            Importación puntual consultada el <strong>{consulted}</strong> (revisión {meta.revision}) para eventos que empiezan del 19 de octubre al 31 de diciembre de 2026,
            en un radio de {meta.window.radiusKm} km desde el centro de Valencia. <strong>No se actualiza automáticamente</strong> y no es una integración activa.
          </p>
          <div className="list-row"><strong>Fourvenues / Marina Beach Club</strong><span>{meta.byProvider.fourvenues} eventos</span></div>
          <div className="list-row"><strong>Xceed</strong><span>{meta.byProvider.xceed} eventos</span></div>
          <div className="list-row"><span>Referencias repetidas unificadas</span><span>{meta.duplicatesRemoved}</span></div>
          <div className="list-row"><span>Precios desconocidos («Consultar»)</span><span>{meta.unknownPrices}</span></div>
          <p className="muted" style={{ fontSize: 13 }}>{meta.coverage}</p>
          <p className="muted" style={{ fontSize: 13 }}>
            «Desde» indica una entrada publicada en el momento de la consulta; gastos, condiciones y disponibilidad se comprueban en el vendedor. Los precios o la
            disponibilidad pueden haber cambiado: no se presentan como verificados hoy. Los horarios incoherentes se marcan para revisar.
          </p>
          <div className="actions">
            <a className="pill" href="https://marinabeachclub.com/calendario-eventos/" target="_blank" rel="noopener noreferrer">Marina Beach Club <Icon name="external" size={12} /></a>
            <a className="pill" href="https://xceed.me/es/valencia/events" target="_blank" rel="noopener noreferrer">Xceed Valencia <Icon name="external" size={12} /></a>
            <a className="pill" href="https://site.fourvenues.com/es/nightlife-valencia" target="_blank" rel="noopener noreferrer">Fourvenues <Icon name="external" size={12} /></a>
          </div>
          <h4>Mapa</h4>
          <p className="muted" style={{ fontSize: 13 }}>
            Barrios de València: Ajuntament de València, datos abiertos (CC BY 4.0). Teselas: OpenStreetMap y colaboradores (ODbL). Las coordenadas de los eventos
            importados son las publicadas por las fuentes; las de eventos creados en YOU IN? las fija el organizador. Nunca se inventan.
          </p>
        </section>
      </div>
      <p style={{ marginTop: 20 }}><Link className="link" href="/">Volver al mapa</Link></p>
    </>
  );
}
