'use client';
import Link from 'next/link';
import { useCallback, useEffect, useState } from 'react';
import { useSession } from '@/components/providers/SessionProvider';
import { useToast } from '@/components/ui/Toast';
import { Icon } from '@/components/ui/Icon';
import { Empty, ErrorState, Intro, Loading, NeedsLogin, NoBackend } from '@/components/ui/States';
import { fetchMembership, joinCommunity } from '@/lib/data/communities';
import { fetchCampaign, fetchLinkStatus, fetchMyLink, getOrCreateLink, toRule } from '@/lib/data/rewards';
import { describeRule, rewardProgress, ruleTiers } from '@/lib/domain/rewards';
import { formatDateTime } from '@/lib/domain/time';
import type { CampaignRuleRow, RewardRow } from '@/lib/types';
import { Simulator } from './Simulator';
import { History } from './History';

type Campaign = NonNullable<Awaited<ReturnType<typeof fetchCampaign>>>;
type Link_ = { id: string; code: string };
type Status = Awaited<ReturnType<typeof fetchLinkStatus>>;

export const REWARD_STATUS = { available: 'Disponible', redeemed: 'Canjeada', revoked: 'Retirada' } as const;

export function rewardLabel(r: Pick<RewardRow, 'kind' | 'sequence'>) {
  return r.kind === 'own' ? 'Tu invitación' : `Invitación adicional nº ${r.sequence - 1}`;
}

export function RewardsPage({ campaignId }: { campaignId: string }) {
  const { configured, ready, user, db, refreshCommunities } = useSession();
  const toast = useToast();
  const [campaign, setCampaign] = useState<Campaign | null>(null);
  const [link, setLink] = useState<Link_ | null>(null);
  const [status, setStatus] = useState<Status | null>(null);
  const [member, setMember] = useState(false);
  const [state, setState] = useState<'loading' | 'ready' | 'missing' | 'error'>('loading');
  const [error, setError] = useState('');

  const refresh = useCallback(async (linkId: string) => {
    if (!db) return;
    setStatus(await fetchLinkStatus(db, linkId));
  }, [db]);

  const load = useCallback(async () => {
    if (!db || !user) return;
    try {
      const c = await fetchCampaign(db, campaignId);
      if (!c) { setState('missing'); return; }
      setCampaign(c);
      const acc = await fetchMembership(db, c.community_id, user.id);
      setMember(acc.member || acc.admin);
      let l = await fetchMyLink(db, c.id, user.id);
      if (!l && (acc.member || acc.admin) && c.status === 'active') l = await getOrCreateLink(db, c.id);
      if (l) { setLink({ id: l.id, code: l.code }); await refresh(l.id); }
      setState('ready');
    } catch (e) { setError((e as Error).message); setState('error'); }
  }, [db, user, campaignId, refresh]);

  useEffect(() => { if (ready) void load(); }, [ready, load]);

  if (!configured) return <NoBackend feature="Las recompensas" />;
  if (!ready) return <Loading />;
  if (!user) return <NeedsLogin next={`/recompensas/${campaignId}`}>Entra para obtener tu enlace personal y seguir tus invitaciones.</NeedsLogin>;
  if (state === 'loading') return <Loading label="Cargando tu progreso…" />;
  if (state === 'error') return <ErrorState message={error} onRetry={load} />;
  if (state === 'missing' || !campaign) return <Empty title="Esta campaña no existe" icon="gift" />;

  const rules = (campaign.campaign_rules ?? []) as CampaignRuleRow[];
  const current = rules.find((r) => r.version === campaign.current_rule_version) ?? rules[0];
  const rule = toRule(current);
  const valid = status?.validTickets ?? 0;
  const progress = rewardProgress(valid, rule);
  const tiers = ruleTiers(rule, 4);
  const live = (status?.rewards ?? []).filter((r) => r.status !== 'revoked');
  const url = link ? `${window.location.origin}/r/${link.code}` : '';
  const simulated = campaign.mode === 'simulation';

  async function copy() {
    try { await navigator.clipboard.writeText(url); toast('Enlace copiado'); } catch { toast('No se pudo copiar: selecciónalo y cópialo a mano.'); }
  }

  return (
    <>
      <Intro kicker={`Recompensas · ${campaign.communities?.name ?? ''}`} title={campaign.name} sub={campaign.description ?? undefined}
        extra={campaign.communities && <Link className="secondary" href={`/comunidades/${campaign.communities.slug}`}><Icon name="back" size={16} /> Comunidad</Link>} />
      {simulated && (
        <div className="notice warm" role="note" style={{ marginBottom: 18 }}>
          <span className="status-badge sim">Simulación</span> Campaña de prueba: las entradas se registran con el simulador y ninguna es real. Las invitaciones también son de prueba.
        </div>
      )}
      {!member ? (
        <Empty title="Únete a la comunidad para obtener tu enlace" icon="people" action={
          <button className="primary" onClick={async () => {
            if (!db) return;
            try { await joinCommunity(db, campaign.community_id); await refreshCommunities(); await load(); } catch (e) { toast((e as Error).message); }
          }}>Unirme a {campaign.communities?.name}</button>
        }>Cada persona de la comunidad tiene un enlace personal asociado a esta campaña.</Empty>
      ) : !link ? (
        <Empty title="La campaña no está activa" icon="gift">No se pueden crear enlaces nuevos ahora mismo.</Empty>
      ) : (
        <>
          <div className="reward-hero">
            <section className="panel">
              <span className="eyebrow">TU ENLACE PERSONAL</span>
              <div className="link-box"><code>{url}</code><button className="primary small" onClick={copy}><Icon name="copy" size={15} /> Copiar</button></div>
              <p className="help">Compártelo. Solo cuentan las entradas válidas confirmadas por el vendedor: abrir el enlace o hacer clic no cuenta como venta.</p>
              <hr className="divider" />
              <div className="row" style={{ alignItems: 'flex-end' }}>
                <div><div className="big-number">{valid}</div><span className="muted-small">entradas válidas atribuidas</span></div>
                <span className="spacer" />
                <div style={{ textAlign: 'right' }}><div className="big-number">{live.length}</div><span className="muted-small">invitaciones conseguidas</span></div>
              </div>
              <div className="progress" role="progressbar" aria-valuemin={0} aria-valuemax={100} aria-valuenow={Math.round(progress.ratio * 100)} aria-label="Progreso al siguiente objetivo">
                <span style={{ width: `${Math.round(progress.ratio * 100)}%` }} />
              </div>
              <p style={{ margin: 0, fontSize: 13 }}><strong>{progress.label}</strong>{progress.nextTarget !== null && <span className="muted"> · siguiente objetivo: {progress.nextTarget} entradas</span>}</p>
              {(status?.reversedTickets ?? 0) > 0 && <p className="muted-small">{status!.reversedTickets} entrada(s) reembolsadas o canceladas no cuentan.</p>}
            </section>
            <section className="panel">
              <h3 style={{ marginTop: 0 }}>Cómo funciona</h3>
              <p className="muted" style={{ fontSize: 13 }}>{describeRule(rule)}</p>
              <div className="tiers">
                {tiers.map((t) => {
                  const isCurrent = valid >= t.from && (t.to === null || valid <= t.to);
                  return (
                    <div key={t.from} className={`tier ${isCurrent ? 'current' : ''}`}>
                      <strong>{t.total === 0 ? '—' : t.total === 1 ? '1 (la tuya)' : `1 + ${t.total - 1}`}</strong>
                      {t.from}{t.to === null ? '+' : `–${t.to}`} entradas
                    </div>
                  );
                })}
              </div>
              {current.conditions && <p className="help" style={{ marginTop: 12 }}>{current.conditions}</p>}
              <p className="help">Regla vigente: versión {current.version}. Si la organización cambia la regla, las invitaciones ya conseguidas se mantienen.</p>
            </section>
          </div>

          <div className="section-head"><h2>Tus invitaciones</h2></div>
          {status?.rewards.length ? (
            <div className="reward-list">
              {status.rewards.map((r) => (
                <div key={r.id} className="reward-item">
                  <div>
                    <strong>{rewardLabel(r)}</strong>
                    <p className="muted-small" style={{ margin: '4px 0 0' }}>
                      Conseguida el {formatDateTime(r.granted_at)} · regla v{r.rule_version}
                      {r.redeemed_at && ` · canjeada el ${formatDateTime(r.redeemed_at)}`}
                      {r.revoke_reason && ` · ${r.revoke_reason}`}
                    </p>
                  </div>
                  <div className="row">
                    {r.is_simulated && <span className="status-badge sim">Simulación</span>}
                    <span className={`status-badge ${r.status === 'available' ? 'ok' : r.status === 'redeemed' ? 'off' : 'warn'}`}>{REWARD_STATUS[r.status as keyof typeof REWARD_STATUS]}</span>
                    {r.status === 'available' && <code title="Muestra este código en la puerta">{r.code}</code>}
                  </div>
                </div>
              ))}
            </div>
          ) : <Empty title="Aún no tienes invitaciones" icon="gift">{progress.label}.</Empty>}

          <div className="section-head"><h2>Historial de movimientos</h2></div>
          <section className="panel"><History rows={status?.history ?? []} /></section>

          {simulated && (
            <>
              <div className="section-head"><h2>Simulador</h2><span className="status-badge sim">Separado del flujo real</span></div>
              <Simulator campaignId={campaign.id} code={link.code} orders={status?.orders ?? []} onChange={() => refresh(link.id)} />
            </>
          )}
        </>
      )}
    </>
  );
}
