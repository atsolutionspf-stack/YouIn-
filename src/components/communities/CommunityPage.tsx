'use client';
import Link from 'next/link';
import { useCallback, useEffect, useState } from 'react';
import { useRouter, useSearchParams } from 'next/navigation';
import { useSession } from '@/components/providers/SessionProvider';
import { useDiscovery } from '@/components/providers/DiscoveryProvider';
import { useToast } from '@/components/ui/Toast';
import { Avatar } from '@/components/ui/Avatar';
import { Icon } from '@/components/ui/Icon';
import { Empty, ErrorState, Intro, Loading, NoBackend } from '@/components/ui/States';
import { EventCard } from '@/components/events/EventCard';
import { KIND_LABEL, originTag } from '@/components/profiles/ProfileView';
import { fetchCommunityBySlug, fetchMemberCount, fetchMembership, joinCommunity, leaveCommunity } from '@/lib/data/communities';
import { fetchEntityEvents } from '@/lib/data/events';
import { fetchCommunityCampaigns } from '@/lib/data/rewards';
import type { CampaignRow, ClubRow, CommunityRow, DiscoveryEvent, EntityRow } from '@/lib/types';
import { ChatRoom } from './ChatRoom';
import { ClubPreview } from './ClubPreview';

type Community = CommunityRow & { entities: EntityRow; clubs: ClubRow | ClubRow[] | null };

export function CommunityPage({ slug }: { slug: string }) {
  const { configured, db, user, ready, communities, refreshCommunities, requireLogin } = useSession();
  const { entityMap } = useDiscovery();
  const toast = useToast();
  const router = useRouter();
  const params = useSearchParams();
  const [community, setCommunity] = useState<Community | null>(null);
  const [members, setMembers] = useState(0);
  const [access, setAccess] = useState({ member: false, admin: false, banned: false });
  const [adminIds, setAdminIds] = useState<string[]>([]);
  const [events, setEvents] = useState<DiscoveryEvent[]>([]);
  const [campaigns, setCampaigns] = useState<CampaignRow[]>([]);
  const [state, setState] = useState<'loading' | 'ready' | 'missing' | 'error'>('loading');
  const [error, setError] = useState('');
  const [busy, setBusy] = useState(false);

  const load = useCallback(async () => {
    if (!db) return;
    try {
      const c = (await fetchCommunityBySlug(db, slug)) as Community | null;
      if (!c) { setState('missing'); return; }
      setCommunity(c);
      const [count, acc, evs, camps] = await Promise.all([
        fetchMemberCount(db, c.id), fetchMembership(db, c.id, user?.id ?? null), fetchEntityEvents(db, c.entity_id), fetchCommunityCampaigns(db, c.id),
      ]);
      setMembers(count);
      setAccess(acc);
      setEvents(evs);
      setCampaigns(camps.filter((x) => x.status === 'active'));
      const { data: admins } = await db.rpc('community_admin_ids', { p_community: c.id });
      setAdminIds((admins ?? []) as string[]);
      setState('ready');
    } catch (e) { setError((e as Error).message); setState('error'); }
  }, [db, slug, user]);

  useEffect(() => { if (ready) void load(); }, [load, ready]);

  if (!configured) return <NoBackend feature="Las comunidades" />;
  if (state === 'loading') return <Loading label="Cargando comunidad…" />;
  if (state === 'error') return <ErrorState message={error} onRetry={load} />;
  if (state === 'missing' || !community) return <Empty title="Esta comunidad no existe" icon="people" action={<Link className="secondary" href="/comunidades">Ver comunidades</Link>} />;

  const c = community;
  const owner = c.entities;
  const club = Array.isArray(c.clubs) ? c.clubs[0] ?? null : c.clubs;
  const canRead = access.member || access.admin;
  const mine = communities.find((x) => x.community_id === c.id);
  const tab = params.get('canal') ?? (canRead ? 'chat' : 'info');
  const setTab = (t: string) => router.replace(`/comunidades/${slug}?canal=${t}`, { scroll: false });

  async function join() {
    if (!db || !requireLogin('Entra para unirte a la comunidad.')) return;
    setBusy(true);
    try {
      await joinCommunity(db, c.id);
      toast('¡Ya formas parte de la comunidad!');
      await Promise.all([load(), refreshCommunities()]);
      setTab('chat');
    } catch (e) { toast((e as Error).message); } finally { setBusy(false); }
  }
  async function leave() {
    if (!db || !confirm('¿Salir de la comunidad? Dejarás de ver sus conversaciones. Seguir el perfil es independiente.')) return;
    setBusy(true);
    try { await leaveCommunity(db, c.id); toast('Has salido de la comunidad'); await Promise.all([load(), refreshCommunities()]); setTab('info'); }
    catch (e) { toast((e as Error).message); } finally { setBusy(false); }
  }
  const onAccessLost = () => { toast('Ya no tienes acceso a esta comunidad.'); void load(); void refreshCommunities(); };

  const unreadChat = Number(mine?.unread_chat ?? 0);
  const unreadAnn = Number(mine?.unread_announcements ?? 0);

  return (
    <>
      <Intro kicker={`Comunidad${c.is_demo ? ' · demostración' : ''}`} title={c.name} sub={`Por ${owner.name} · ${members} ${members === 1 ? 'miembro' : 'miembros'}`}
        extra={<Link className="secondary" href="/comunidades"><Icon name="back" size={16} /> Comunidades</Link>} />
      <div className="community-hero">
        <div>
          {access.banned && <div className="notice warm" role="alert" style={{ marginBottom: 14 }}>La administración te ha expulsado de esta comunidad: ya no puedes leer ni escribir en sus canales.</div>}
          <div className="tabs" role="tablist" aria-label="Secciones de la comunidad">
            <button role="tab" aria-selected={tab === 'info'} className={tab === 'info' ? 'active' : ''} onClick={() => setTab('info')}>Comunidad</button>
            <button role="tab" aria-selected={tab === 'anuncios'} className={tab === 'anuncios' ? 'active' : ''} onClick={() => setTab('anuncios')}>
              <Icon name="megaphone" size={15} /> Anuncios {unreadAnn > 0 && <span className="tab-count">{unreadAnn}</span>}
            </button>
            <button role="tab" aria-selected={tab === 'chat'} className={tab === 'chat' ? 'active' : ''} onClick={() => setTab('chat')}>
              <Icon name="chat" size={15} /> Chat {unreadChat > 0 && <span className="tab-count">{unreadChat}</span>}
            </button>
            <button role="tab" aria-selected={tab === 'club'} className={tab === 'club' ? 'active' : ''} onClick={() => setTab('club')}><Icon name="lock" size={14} /> Club de pago</button>
            <button role="tab" aria-selected={tab === 'eventos'} className={tab === 'eventos' ? 'active' : ''} onClick={() => setTab('eventos')}>Eventos ({events.length})</button>
          </div>
          <div style={{ marginTop: 16 }}>
            {(tab === 'anuncios' || tab === 'chat') && (canRead ? (
              <ChatRoom
                key={tab}
                communityId={c.id}
                channel={tab === 'anuncios' ? 'announcements' : 'chat'}
                canWrite={tab === 'anuncios' ? access.admin : canRead}
                isAdmin={access.admin}
                adminIds={adminIds}
                onRead={refreshCommunities}
                onAccessLost={onAccessLost}
                emptyText={tab === 'anuncios' ? 'Aún no hay anuncios.' : c.welcome_message || 'Sé la primera persona en escribir.'}
              />
            ) : (
              <Empty title={access.banned ? 'Acceso retirado' : 'Únete para participar'} icon="lock"
                action={!access.banned && <button className="primary" onClick={join} disabled={busy}>Unirme a la comunidad</button>}>
                {access.banned ? 'No puedes ver los canales de esta comunidad.' : 'Los anuncios y el chat son solo para miembros. Unirse es gratis.'}
              </Empty>
            ))}
            {tab === 'club' && <ClubPreview club={club} communityName={c.name} />}
            {tab === 'eventos' && (
              <div className="cards">
                {events.length ? events.map((e) => <EventCard key={e.id} event={e} entityMap={entityMap} />) : <Empty title="Sin eventos próximos" icon="calendar">Cuando {owner.name} publique o le mencionen en un evento, aparecerá aquí.</Empty>}
              </div>
            )}
            {tab === 'info' && (
              <section className="panel">
                <p style={{ whiteSpace: 'pre-line' }}>{c.description || 'Una comunidad de la escena de Valencia.'}</p>
                {!!c.genres.length && <div className="tags">{c.genres.map((g) => <span key={g} className="tag">{g}</span>)}</div>}
                <div className="membership">
                  <h4>Comunidad gratuita</h4>
                  {c.free_benefits.length ? <ul className="benefits">{c.free_benefits.map((b) => <li key={b}>{b}</li>)}</ul> : <p>Conversación con la comunidad y anuncios de la administración.</p>}
                </div>
                {c.rules && <div className="membership"><h4>Normas</h4><p style={{ whiteSpace: 'pre-line' }}>{c.rules}</p></div>}
                {campaigns.length > 0 && (
                  <div className="membership">
                    <h4><Icon name="gift" size={16} /> Recompensas activas</h4>
                    {campaigns.map((camp) => (
                      <div key={camp.id} className="list-row">
                        <div><strong>{camp.name}</strong><p>{camp.description}</p></div>
                        <div className="row">
                          {camp.mode === 'simulation' && <span className="status-badge sim">Simulación</span>}
                          <Link className="pill dark" href={`/recompensas/${camp.id}`}>{canRead ? 'Mi enlace' : 'Ver'}</Link>
                        </div>
                      </div>
                    ))}
                  </div>
                )}
              </section>
            )}
          </div>
        </div>

        <aside className="stack">
          <section className="panel">
            <div className="row"><Avatar p={owner} /><div><strong>{owner.name}</strong><p className="muted-small" style={{ margin: 0 }}>{KIND_LABEL[owner.kind]} · {originTag(owner)}</p></div></div>
            <p className="muted-small" style={{ marginTop: 12 }}>Responsable: la administración de {owner.name}.</p>
            <div className="stack" style={{ marginTop: 10 }}>
              {access.admin ? (
                <>
                  <span className="tag">Administras esta comunidad</span>
                  <Link className="secondary" href={`/panel/${owner.slug}?tab=comunidad`}><Icon name="settings" size={15} /> Gestionar y moderar</Link>
                </>
              ) : access.member ? (
                <button className="secondary" onClick={leave} disabled={busy}>Salir de la comunidad</button>
              ) : !access.banned && (
                <button className="primary" onClick={join} disabled={busy}>{user ? 'Unirme gratis' : 'Entra para unirte'}</button>
              )}
              <Link className="text-button" href={`/p/${owner.slug}`}>Ver perfil de {owner.name} <Icon name="arrow" size={14} /></Link>
            </div>
          </section>
          <section className="panel">
            <h4 style={{ marginTop: 0 }}>Gratis y club, por separado</h4>
            <p className="muted-small">La comunidad gratuita y el club de pago tienen acceso independiente. Unirte gratis no da acceso al club; el club se paga aparte y solo en esta comunidad.</p>
          </section>
        </aside>
      </div>
    </>
  );
}
