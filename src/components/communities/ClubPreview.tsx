import { Icon } from '@/components/ui/Icon';
import type { ClubRow } from '@/lib/types';

export const formatCents = (c: number) => new Intl.NumberFormat('es-ES', { style: 'currency', currency: 'EUR' }).format(c / 100);

/** Vista previa del club de pago. No hay cobros ni acceso simulado. */
export function ClubPreview({ club, communityName }: { club: ClubRow | null; communityName: string }) {
  if (!club) {
    return (
      <div className="club-preview">
        <span className="tag">Espacio separado</span>
        <h3>Club de pago</h3>
        <p className="muted">{communityName} aún no ha configurado su club. Cada comunidad decide si lo ofrece, su precio y sus ventajas.</p>
      </div>
    );
  }
  return (
    <div className="club-preview">
      <div className="row"><span className="tag">Espacio separado</span><span className="status-badge off">Vista previa · sin cobros</span></div>
      <h3 style={{ marginBottom: 4 }}>{club.name}</h3>
      <div className="club-price">{formatCents(club.price_cents)}<span className="muted-small"> / {club.billing_interval === 'month' ? 'mes' : 'año'}</span></div>
      {club.description && <p className="muted">{club.description}</p>}
      <ul className="benefits">{club.benefits.map((b) => <li key={b}>{b}</li>)}</ul>
      <button className="primary" disabled aria-disabled="true"><Icon name="lock" size={15} /> Suscripción próximamente</button>
      <div className="notice" style={{ marginTop: 14 }}>
        Pagos aún no conectados: no se realizan cobros ni se activa ninguna suscripción, y nadie tiene acceso premium simulado.
        Cuando se active, cada comunidad tendrá su propia suscripción y YOU IN? podrá aplicar una comisión.
      </div>
    </div>
  );
}
