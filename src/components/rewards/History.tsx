import { formatDateTime } from '@/lib/domain/time';
import type { RewardEventRow } from '@/lib/types';

const LABELS: Record<string, string> = {
  tickets_valid: 'Entradas válidas',
  tickets_refunded: 'Reembolso',
  tickets_cancelled: 'Cancelación',
  reward_granted: 'Invitación conseguida',
  reward_revoked: 'Invitación retirada',
  reward_redeemed: 'Invitación canjeada',
  reward_deficit: 'Déficit por invitación ya canjeada',
  rules_changed: 'Cambio de reglas',
  duplicate_ignored: 'Operación duplicada ignorada',
};

export function History({ rows, showUser }: { rows: (RewardEventRow & { display_name?: string })[]; showUser?: boolean }) {
  if (!rows.length) return <p className="muted">Sin movimientos todavía.</p>;
  return (
    <ul className="history">
      {rows.map((h) => (
        <li key={h.id}>
          <span className={`delta ${h.ticket_delta > 0 ? 'plus' : h.ticket_delta < 0 ? 'minus' : ''}`}>{h.ticket_delta > 0 ? `+${h.ticket_delta}` : h.ticket_delta < 0 ? h.ticket_delta : '·'}</span>
          <span style={{ flex: 1 }}>
            <strong>{LABELS[h.type] ?? h.type}</strong>{h.is_simulated && <span className="status-badge sim" style={{ marginLeft: 6 }}>Sim.</span>}
            {showUser && h.display_name && <span className="muted"> · {h.display_name}</span>}
            <br /><span className="muted">{h.detail}</span>
            {h.valid_tickets_after !== null && h.valid_tickets_after !== undefined && <span className="muted"> · total válidas: {h.valid_tickets_after}</span>}
          </span>
          <time className="muted-small" dateTime={h.created_at}>{formatDateTime(h.created_at)}</time>
        </li>
      ))}
    </ul>
  );
}
