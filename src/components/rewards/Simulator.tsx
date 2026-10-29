'use client';
// Simulador de compras: SOLO para campañas en modo simulación. Todo lo que
// registra queda marcado como simulado y nunca se mezcla con el flujo real.
import { useState } from 'react';
import { useSession } from '@/components/providers/SessionProvider';
import { useToast } from '@/components/ui/Toast';
import { Icon } from '@/components/ui/Icon';
import { simulatePurchase, simulateReversal } from '@/lib/data/rewards';
import { formatDateTime } from '@/lib/domain/time';

type Order = { id: string; external_order_id: string; purchased_at: string; ticket_items: { status: string }[] };

export function Simulator({ campaignId, code, orders, onChange, admin }: { campaignId: string; code: string; orders: Order[]; onChange: () => void; admin?: boolean }) {
  const { db } = useSession();
  const toast = useToast();
  const [qty, setQty] = useState(1);
  const [busy, setBusy] = useState(false);
  const [last, setLast] = useState<{ key: string; qty: number } | null>(null);
  const [result, setResult] = useState('');

  async function run(fn: () => Promise<Record<string, unknown>>, label: string) {
    setBusy(true);
    try {
      const r = await fn();
      setResult(`${label}\n${JSON.stringify(r, null, 2)}`);
      if (r.replayed) toast('Operación repetida: se devolvió el resultado anterior sin duplicar nada.');
      else if (r.status === 'duplicate_order') toast('Pedido ya registrado: no se cuenta dos veces.');
      onChange();
    } catch (e) {
      setResult(`${label}\nError: ${(e as Error).message}`);
      toast((e as Error).message);
    } finally { setBusy(false); }
  }

  function buy() {
    const key = crypto.randomUUID();
    setLast({ key, qty });
    void run(() => simulatePurchase(db!, campaignId, code, qty, key), `Compra simulada de ${qty} entrada(s) · clave ${key.slice(0, 8)}…`);
  }
  function replay() {
    if (!last) return;
    void run(() => simulatePurchase(db!, campaignId, code, last.qty, last.key), `Reenvío de la MISMA operación · clave ${last.key.slice(0, 8)}…`);
  }

  return (
    <section className="simulator" aria-label="Simulador de compras">
      <h3 style={{ marginTop: 0 }}><Icon name="ticket" size={18} /> Simulador de compras {admin ? `· enlace ${code}` : ''}</h3>
      <p className="muted" style={{ fontSize: 12 }}>
        Registra compras de prueba atribuidas a {admin ? 'este enlace' : 'tu enlace'}, varias entradas por compra, reembolsos y cancelaciones.
        Cada operación lleva una clave única: reenviarla no duplica entradas ni invitaciones.
      </p>
      <div className="row">
        <label style={{ margin: 0 }}>Entradas en la compra
          <input type="number" min={1} max={50} value={qty} onChange={(e) => setQty(Math.max(1, Math.min(50, Number(e.target.value) || 1)))} style={{ width: 110 }} />
        </label>
        <button className="primary" onClick={buy} disabled={busy || !db}>Registrar compra de prueba</button>
        <button className="secondary" onClick={replay} disabled={busy || !last} title="Envía otra vez exactamente la misma operación">Repetir la última operación</button>
      </div>
      {orders.length > 0 && (
        <>
          <h4>Compras simuladas</h4>
          <div className="table-wrap">
            <table className="data">
              <thead><tr><th>Pedido</th><th>Fecha</th><th>Válidas</th><th>Revertidas</th><th>Acciones</th></tr></thead>
              <tbody>
                {orders.map((o) => {
                  const valid = o.ticket_items.filter((i) => i.status === 'valid').length;
                  return (
                    <tr key={o.id}>
                      <td><code>{o.external_order_id.slice(0, 16)}…</code></td>
                      <td>{formatDateTime(o.purchased_at)}</td>
                      <td>{valid}</td>
                      <td>{o.ticket_items.length - valid}</td>
                      <td className="row">
                        <button className="secondary small" disabled={busy || !valid} onClick={() => run(() => simulateReversal(db!, o.id, 1, 'refunded', crypto.randomUUID()), 'Reembolso de 1 entrada')}>Reembolsar 1</button>
                        <button className="secondary small" disabled={busy || !valid} onClick={() => run(() => simulateReversal(db!, o.id, valid, 'cancelled', crypto.randomUUID()), `Cancelación de ${valid} entrada(s)`)}>Cancelar todo</button>
                      </td>
                    </tr>
                  );
                })}
              </tbody>
            </table>
          </div>
        </>
      )}
      {result && <pre className="sim-result" aria-live="polite">{result}</pre>}
      <p className="help" style={{ marginTop: 12, marginBottom: 0 }}>
        Política de reembolsos: si una entrada se reembolsa o cancela, se retiran solo invitaciones aún no canjeadas. Si ya se canjeó, no se anula:
        queda un déficit que cubren las siguientes entradas válidas antes de generar nuevas invitaciones. El canje en puerta lo hace la organización y solo una vez.
      </p>
    </section>
  );
}
