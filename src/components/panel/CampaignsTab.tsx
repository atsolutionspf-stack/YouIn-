'use client';
import Link from 'next/link';
import { useCallback, useEffect, useState, type FormEvent } from 'react';
import { useSession } from '@/components/providers/SessionProvider';
import { useToast } from '@/components/ui/Toast';
import { Icon } from '@/components/ui/Icon';
import { Empty, ErrorState, Loading } from '@/components/ui/States';
import { History } from '@/components/rewards/History';
import { Simulator } from '@/components/rewards/Simulator';
import { REWARD_STATUS, rewardLabel } from '@/components/rewards/RewardsPage';
import { fetchCommunityByEntity } from '@/lib/data/communities';
import {
  createCampaign, fetchCampaignHistory, fetchCampaignResults, fetchCampaignRewards, fetchCommunityCampaigns, fetchLinkStatus,
  redeemReward, setCampaignStatus, toRule, updateRules,
} from '@/lib/data/rewards';
import { describeRule } from '@/lib/domain/rewards';
import { formatDateTime, madridToUtcIso } from '@/lib/domain/time';
import type { CampaignRow, CampaignRuleRow, EntityRow, RewardEventRow, RewardRow } from '@/lib/types';

type Campaign = CampaignRow & { campaign_rules: CampaignRuleRow[] };
type Result = Awaited<ReturnType<typeof fetchCampaignResults>>[number];

export function CampaignsTab({ entity }: { entity: EntityRow }) {
  const { db } = useSession();
  const toast = useToast();
  const [communityId, setCommunityId] = useState<string | null | undefined>(undefined);
  const [campaigns, setCampaigns] = useState<Campaign[]>([]);
  const [selected, setSelected] = useState<string | null>(null);
  const [creating, setCreating] = useState(false);
  const [error, setError] = useState('');

  const load = useCallback(async () => {
    if (!db) return;
    try {
      const c = await fetchCommunityByEntity(db, entity.id);
      setCommunityId(c?.id ?? null);
      if (c) {
        const list = (await fetchCommunityCampaigns(db, c.id)) as Campaign[];
        setCampaigns(list);
        setSelected((s) => s ?? list[0]?.id ?? null);
      }
    } catch (e) { setError((e as Error).message); }
  }, [db, entity.id]);
  useEffect(() => { void load(); }, [load]);

  if (error) return <ErrorState message={error} onRetry={load} />;
  if (communityId === undefined) return <Loading />;
  if (!communityId) return <Empty title="Primero abre tu comunidad" icon="people">Las campañas de invitaciones pertenecen a una comunidad.</Empty>;

  async function create(e: FormEvent<HTMLFormElement>) {
    e.preventDefault();
    if (!db || !communityId) return;
    const f = new FormData(e.currentTarget);
    const base = Number(f.get('base'));
    const step = Number(f.get('step'));
    const maxExtra = String(f.get('maxExtra') ?? '').trim() ? Number(f.get('maxExtra')) : null;
    if (!(base >= 1 && step >= 1 && base <= step)) { toast('El umbral debe ser ≥ 1 y no mayor que el bloque.'); return; }
    try {
      const endsDate = String(f.get('ends') ?? '');
      const id = await createCampaign(db, {
        communityId, name: String(f.get('name')).trim(), description: String(f.get('description') ?? '').trim(), base, step, maxExtra,
        conditions: String(f.get('conditions') ?? '').trim(), eventId: null, endsAt: endsDate ? madridToUtcIso(`${endsDate}T23:59`) : null,
      });
      toast('Campaña creada en modo simulación');
      setCreating(false);
      setSelected(id);
      await load();
    } catch (err) { toast((err as Error).message); }
  }

  const campaign = campaigns.find((c) => c.id === selected);

  return (
    <div className="stack">
      <section className="panel">
        <div className="row"><h3 style={{ margin: 0 }}>Campañas de invitaciones</h3><span className="spacer" />
          <button className="secondary" onClick={() => setCreating((v) => !v)}><Icon name="plus" size={15} /> Nueva campaña</button>
        </div>
        <p className="muted-small">Cada persona de la comunidad obtiene un enlace personal. Cuentan entradas válidas, no clics ni pedidos. Sin integración con vendedores, las campañas funcionan en modo simulación.</p>
        {creating && (
          <form onSubmit={create} style={{ marginTop: 14 }}>
            <label>Nombre<input name="name" required maxLength={100} placeholder="Trae a tu gente" /></label>
            <label>Descripción<textarea name="description" maxLength={1500} /></label>
            <div className="form-grid">
              <label>Invitación propia desde (entradas)<input name="base" type="number" min={1} max={1000} defaultValue={5} required /></label>
              <label>+1 adicional por cada bloque de<input name="step" type="number" min={1} max={1000} defaultValue={10} required /></label>
            </div>
            <div className="form-grid">
              <label>Máximo de adicionales (vacío = sin límite)<input name="maxExtra" type="number" min={0} max={1000} /></label>
              <label>Termina el (opcional)<input name="ends" type="date" /></label>
            </div>
            <label>Condiciones<textarea name="conditions" maxLength={1500} defaultValue="Solo cuentan entradas válidas confirmadas. Los reembolsos y cancelaciones restan." /></label>
            <button className="primary">Crear campaña (simulación)</button>
          </form>
        )}
        {campaigns.length > 0 && (
          <div className="chips" style={{ marginTop: 14 }}>
            {campaigns.map((c) => (
              <button key={c.id} className={`chip ${c.id === selected ? 'active' : ''}`} onClick={() => setSelected(c.id)}>
                {c.name} · {c.status === 'active' ? 'activa' : c.status === 'closed' ? 'cerrada' : 'borrador'}
              </button>
            ))}
          </div>
        )}
      </section>
      {campaign ? <CampaignDetail key={campaign.id} campaign={campaign} onChanged={load} /> : !creating && <Empty title="Sin campañas" icon="gift">Crea una para probar enlaces personales e invitaciones.</Empty>}
    </div>
  );
}

function CampaignDetail({ campaign, onChanged }: { campaign: Campaign; onChanged: () => void }) {
  const { db } = useSession();
  const toast = useToast();
  const [results, setResults] = useState<Result[] | null>(null);
  const [rewards, setRewards] = useState<RewardRow[]>([]);
  const [history, setHistory] = useState<RewardEventRow[]>([]);
  const [simLink, setSimLink] = useState<Result | null>(null);
  const [simOrders, setSimOrders] = useState<Awaited<ReturnType<typeof fetchLinkStatus>>['orders']>([]);
  const [code, setCode] = useState('');
  const current = campaign.campaign_rules.find((r) => r.version === campaign.current_rule_version) ?? campaign.campaign_rules[0];
  const rule = toRule(current);

  const load = useCallback(async () => {
    if (!db) return;
    const [r, rw, h] = await Promise.all([fetchCampaignResults(db, campaign.id), fetchCampaignRewards(db, campaign.id), fetchCampaignHistory(db, campaign.id)]);
    setResults(r);
    setRewards(rw);
    setHistory(h);
    if (simLink) setSimOrders((await fetchLinkStatus(db, simLink.referral_link_id)).orders);
  }, [db, campaign.id, simLink]);
  useEffect(() => { void load(); }, [load]);

  async function redeem(c: string) {
    if (!db || !c.trim()) return;
    try {
      const r = await redeemReward(db, c);
      toast(`Invitación canjeada (${r.kind === 'own' ? 'propia' : 'adicional'})`);
      setCode('');
      await load();
    } catch (e) { toast((e as Error).message); }
  }

  async function saveRules(e: FormEvent<HTMLFormElement>) {
    e.preventDefault();
    if (!db) return;
    const f = new FormData(e.currentTarget);
    const base = Number(f.get('base'));
    const step = Number(f.get('step'));
    const maxExtra = String(f.get('maxExtra') ?? '').trim() ? Number(f.get('maxExtra')) : null;
    if (!(base >= 1 && step >= 1 && base <= step)) { toast('El umbral debe ser ≥ 1 y no mayor que el bloque.'); return; }
    if (!confirm('Se creará una nueva versión de la regla. Las invitaciones ya concedidas se mantienen; si la regla es más generosa, se concederán las que falten. ¿Continuar?')) return;
    try {
      const v = await updateRules(db, campaign.id, base, step, maxExtra, String(f.get('conditions') ?? '').trim());
      toast(`Regla v${v} guardada`);
      onChanged();
    } catch (err) { toast((err as Error).message); }
  }

  const totals = (results ?? []).reduce((t, r) => ({ valid: t.valid + Number(r.valid_tickets), avail: t.avail + Number(r.rewards_available), red: t.red + Number(r.rewards_redeemed) }), { valid: 0, avail: 0, red: 0 });
  const names = Object.fromEntries((results ?? []).map((r) => [r.referral_link_id, r.display_name]));

  return (
    <>
      <section className="panel">
        <div className="row">
          <h3 style={{ margin: 0 }}>{campaign.name}</h3>
          {campaign.mode === 'simulation' && <span className="status-badge sim">Simulación</span>}
          <span className={`status-badge ${campaign.status === 'active' ? 'ok' : 'off'}`}>{campaign.status === 'active' ? 'Activa' : campaign.status === 'closed' ? 'Cerrada' : 'Borrador'}</span>
          <span className="spacer" />
          <Link className="pill" href={`/recompensas/${campaign.id}`}>Vista del participante</Link>
          <button className="pill" onClick={async () => { if (!db) return; await setCampaignStatus(db, campaign.id, campaign.status === 'active' ? 'closed' : 'active'); onChanged(); }}>
            {campaign.status === 'active' ? 'Cerrar campaña' : 'Reactivar'}
          </button>
        </div>
        <div className="metrics" style={{ marginTop: 14 }}>
          <div className="metric"><strong>{results?.length ?? 0}</strong><span>Enlaces personales</span></div>
          <div className="metric"><strong>{totals.valid}</strong><span>Entradas válidas</span></div>
          <div className="metric"><strong>{totals.avail}</strong><span>Invitaciones por canjear</span></div>
          <div className="metric"><strong>{totals.red}</strong><span>Invitaciones canjeadas</span></div>
        </div>
      </section>

      <section className="panel">
        <h3 style={{ marginTop: 0 }}>Canjear invitación en puerta</h3>
        <form className="row" onSubmit={(e) => { e.preventDefault(); void redeem(code); }}>
          <input aria-label="Código de invitación" value={code} onChange={(e) => setCode(e.target.value.toUpperCase())} placeholder="INV-XXXXXXXXXX" style={{ flex: 1, minWidth: 180, border: '1px solid var(--line)', borderRadius: 10, padding: 12, background: '#fffdf9' }} />
          <button className="primary" disabled={!code.trim()}>Canjear</button>
        </form>
        <p className="help" style={{ marginTop: 8 }}>Cada código se canjea una sola vez; un segundo intento se rechaza indicando cuándo se usó.</p>
      </section>

      <section className="panel">
        <h3 style={{ marginTop: 0 }}>Resultados por enlace</h3>
        {!results ? <Loading /> : results.length ? (
          <div className="table-wrap">
            <table className="data">
              <thead><tr><th>Persona</th><th>Código</th><th>Válidas</th><th>Revertidas</th><th>Pedidos</th><th>Disponibles</th><th>Canjeadas</th><th>Retiradas</th><th></th></tr></thead>
              <tbody>
                {results.map((r) => (
                  <tr key={r.referral_link_id}>
                    <td>{r.display_name}</td><td><code>{r.code}</code></td><td>{Number(r.valid_tickets)}</td><td>{Number(r.reversed_tickets)}</td>
                    <td>{Number(r.orders)}</td><td>{Number(r.rewards_available)}</td><td>{Number(r.rewards_redeemed)}</td><td>{Number(r.rewards_revoked)}</td>
                    <td>{campaign.mode === 'simulation' && <button className="secondary small" onClick={async () => { setSimLink(r); if (db) setSimOrders((await fetchLinkStatus(db, r.referral_link_id)).orders); }}>Simular</button>}</td>
                  </tr>
                ))}
              </tbody>
            </table>
          </div>
        ) : <p className="muted">Aún nadie ha generado su enlace. Los miembros lo obtienen desde la página de la campaña.</p>}
      </section>

      {simLink && campaign.mode === 'simulation' && (
        <Simulator admin campaignId={campaign.id} code={simLink.code} orders={simOrders} onChange={load} />
      )}

      <section className="panel">
        <h3 style={{ marginTop: 0 }}>Invitaciones</h3>
        {rewards.length ? rewards.map((r) => (
          <div key={r.id} className="list-row">
            <div><strong>{rewardLabel(r)}</strong><p>{names[r.referral_link_id] ?? '—'} · {formatDateTime(r.granted_at)} · regla v{r.rule_version}{r.redeemed_at ? ` · canjeada ${formatDateTime(r.redeemed_at)}` : ''}</p></div>
            <div className="row">
              <span className={`status-badge ${r.status === 'available' ? 'ok' : r.status === 'redeemed' ? 'off' : 'warn'}`}>{REWARD_STATUS[r.status as keyof typeof REWARD_STATUS]}</span>
              {r.status === 'available' && <button className="pill" onClick={() => redeem(r.code)}>Canjear</button>}
            </div>
          </div>
        )) : <p className="muted">Todavía no se ha concedido ninguna invitación.</p>}
      </section>

      <section className="panel">
        <h3 style={{ marginTop: 0 }}>Reglas · versión {current.version}</h3>
        <p className="muted" style={{ fontSize: 13 }}>{describeRule(rule)}</p>
        <form onSubmit={saveRules}>
          <div className="form-grid">
            <label>Invitación propia desde<input name="base" type="number" min={1} max={1000} defaultValue={rule.baseThreshold} required /></label>
            <label>+1 por cada bloque de<input name="step" type="number" min={1} max={1000} defaultValue={rule.stepSize} required /></label>
          </div>
          <label>Máximo de adicionales (vacío = sin límite)<input name="maxExtra" type="number" min={0} max={1000} defaultValue={rule.maxExtra ?? ''} /></label>
          <label>Condiciones<textarea name="conditions" maxLength={1500} defaultValue={current.conditions ?? ''} /></label>
          <button className="secondary">Guardar como nueva versión</button>
        </form>
        <p className="help" style={{ marginTop: 10 }}>Las versiones anteriores se conservan: {campaign.campaign_rules.map((r) => `v${r.version} (${r.base_threshold}/${r.step_size})`).join(', ')}.</p>
      </section>

      <section className="panel">
        <h3 style={{ marginTop: 0 }}>Historial de la campaña</h3>
        <History rows={history.map((h) => ({ ...h, display_name: h.referral_link_id ? names[h.referral_link_id] : undefined }))} showUser />
      </section>
    </>
  );
}
