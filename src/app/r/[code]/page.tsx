import type { Metadata } from 'next';
import Link from 'next/link';
import { getPublicServerClient } from '@/lib/supabase/public';
import { Empty, Intro } from '@/components/ui/States';
import { Icon } from '@/components/ui/Icon';
import { safeHttpsUrl } from '@/lib/domain/events';

export const metadata: Metadata = { title: 'Invitación' };

// Página del enlace personal. No registra nada: abrir este enlace o el del
// vendedor nunca cuenta como entrada vendida. La atribución real exigirá una
// confirmación verificable del proveedor de ticketing (no conectado).
export default async function Page({ params }: { params: Promise<{ code: string }> }) {
  const { code } = await params;
  const db = getPublicServerClient();
  const { data } = db ? await db.rpc('resolve_referral_code', { p_code: code }) : { data: null };
  const r = data?.[0];
  if (!r) return <Empty title="Este enlace no existe" icon="gift" action={<Link className="secondary" href="/">Ir al mapa</Link>} />;
  const ticket = safeHttpsUrl(r.ticket_url);
  return (
    <>
      <Intro kicker="Te han invitado" title={<>Alguien quiere que <em>vengas.</em></>} sub={`${r.campaign_name} · ${r.community_name}`} />
      <section className="lead-panel">
        <div>
          <h2>{r.event_title ?? r.campaign_name}</h2>
          {r.mode === 'simulation' ? (
            <p>Campaña de demostración: no hay entradas reales a la venta. Las compras de esta campaña solo se registran con el simulador.</p>
          ) : (
            <p>Compra tu entrada en el vendedor oficial. La atribución a este enlace la confirmará el vendedor.</p>
          )}
          <div className="actions">
            {r.event_id && <Link className="primary peach" href={`/eventos/${r.event_id}`}>Ver el evento <Icon name="arrow" size={16} /></Link>}
            {ticket && r.mode !== 'simulation' && <a className="pill on-dark" href={ticket} target="_blank" rel="noopener noreferrer">Entradas <Icon name="external" size={14} /></a>}
            <Link className="pill on-dark" href={`/comunidades/${r.community_slug}`}>Conocer la comunidad</Link>
          </div>
        </div>
        <div className="record-art"><img src="/brand/icon.svg" alt="" /></div>
      </section>
      <p className="help" style={{ marginTop: 16 }}>Abrir este enlace no cuenta como entrada vendida. Solo cuentan las entradas válidas confirmadas por el vendedor.</p>
    </>
  );
}
