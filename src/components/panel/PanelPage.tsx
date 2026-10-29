'use client';
import Link from 'next/link';
import { useCallback, useEffect, useState } from 'react';
import { useRouter, useSearchParams } from 'next/navigation';
import { useSession } from '@/components/providers/SessionProvider';
import { Icon, type IconName } from '@/components/ui/Icon';
import { Empty, ErrorState, Intro, Loading, NeedsLogin, NoBackend, PermissionDenied } from '@/components/ui/States';
import { EntityForm } from '@/components/profiles/EntityForm';
import { KIND_LABEL } from '@/components/profiles/ProfileView';
import { fetchEntityBySlug, isEntityAdmin } from '@/lib/data/entities';
import type { EntityRow } from '@/lib/types';
import { OverviewTab } from './OverviewTab';
import { EventsTab } from './EventsTab';
import { TeamTab } from './TeamTab';
import { CommunityTab } from './CommunityTab';
import { CampaignsTab } from './CampaignsTab';

const TABS: { id: string; label: string; icon: IconName; kinds?: EntityRow['kind'][] }[] = [
  { id: 'resumen', label: 'Resumen', icon: 'list' },
  { id: 'perfil', label: 'Perfil', icon: 'user' },
  { id: 'eventos', label: 'Eventos', icon: 'calendar' },
  { id: 'comunidad', label: 'Comunidad', icon: 'people' },
  { id: 'campanas', label: 'Recompensas', icon: 'gift' },
  { id: 'equipo', label: 'Equipo', icon: 'shield', kinds: ['venue', 'collective'] },
];

export function PanelHome() {
  const { configured, ready, user, entities } = useSession();
  if (!configured) return <NoBackend feature="El panel profesional" />;
  if (!ready) return <Loading />;
  if (!user) return <NeedsLogin next="/panel" />;
  return (
    <>
      <Intro kicker="Panel profesional" title={<>Tu escena,<br /><em>en tus manos.</em></>} sub="Perfiles, eventos, comunidad y recompensas de lo que administras." />
      {entities.length ? (
        <div className="profiles-grid">
          {entities.map((e) => (
            <article key={e.id} className="profile-card">
              <header><span className="avatar yellow">{e.name.slice(0, 2).toUpperCase()}</span><span className="tag">{KIND_LABEL[e.kind]}</span></header>
              <h3>{e.name}</h3>
              <p>{e.role === 'owner' ? 'Propietario/a' : 'Administrador/a'}{e.community_id ? ' · con comunidad' : ''}</p>
              <Link className="primary full" href={`/panel/${e.slug}`}>Gestionar <Icon name="arrow" size={15} /></Link>
            </article>
          ))}
        </div>
      ) : (
        <Empty title="Aún no administras ningún perfil" icon="settings" action={<Link className="secondary" href="/perfil">Crear sala, colectivo o activar DJ</Link>}>
          Desde tu perfil puedes activar tu perfil de DJ o crear una sala o un colectivo.
        </Empty>
      )}
    </>
  );
}

export function PanelEntity({ slug }: { slug: string }) {
  const { configured, ready, user, db } = useSession();
  const params = useSearchParams();
  const router = useRouter();
  const tab = params.get('tab') ?? 'resumen';
  const [entity, setEntity] = useState<EntityRow | null>(null);
  const [state, setState] = useState<'loading' | 'ready' | 'denied' | 'missing' | 'error'>('loading');
  const [error, setError] = useState('');

  const load = useCallback(async () => {
    if (!db || !user) return;
    try {
      const e = await fetchEntityBySlug(db, slug);
      if (!e) { setState('missing'); return; }
      // Comprobación en servidor (RPC con auth.uid()); la interfaz no decide permisos.
      if (!(await isEntityAdmin(db, e.id))) { setState('denied'); return; }
      setEntity(e);
      setState('ready');
    } catch (err) { setError((err as Error).message); setState('error'); }
  }, [db, user, slug]);

  useEffect(() => { void load(); }, [load]);

  if (!configured) return <NoBackend feature="El panel profesional" />;
  if (!ready) return <Loading />;
  if (!user) return <NeedsLogin next={`/panel/${slug}`} />;
  if (state === 'loading') return <Loading />;
  if (state === 'error') return <ErrorState message={error} onRetry={load} />;
  if (state === 'missing') return <Empty title="Este perfil no existe" icon="user" />;
  if (state === 'denied' || !entity) return <PermissionDenied>Solo la administración de este perfil puede gestionarlo. Los perfiles importados no se pueden reclamar ni editar.</PermissionDenied>;

  const tabs = TABS.filter((t) => !t.kinds || t.kinds.includes(entity.kind));
  const go = (id: string) => router.replace(`/panel/${slug}?tab=${id}`, { scroll: false });

  return (
    <>
      <Intro kicker={`Panel · ${KIND_LABEL[entity.kind]}`} title={entity.name}
        sub={entity.data_origin === 'demo' ? 'Perfil de demostración: los datos son de prueba.' : 'Gestiona tu perfil, eventos, comunidad y recompensas.'}
        extra={<Link className="secondary" href={`/p/${entity.slug}`}>Ver perfil público <Icon name="external" size={14} /></Link>} />
      <div className="panel-grid">
        <nav className="panel-side" aria-label="Secciones del panel">
          {tabs.map((t) => (
            <button key={t.id} className={tab === t.id ? 'active' : ''} aria-current={tab === t.id ? 'page' : undefined} onClick={() => go(t.id)}>
              <Icon name={t.icon} size={16} /> {t.label}
            </button>
          ))}
        </nav>
        <div>
          {tab === 'resumen' && <OverviewTab entity={entity} go={go} />}
          {tab === 'perfil' && <section className="panel"><h3 style={{ marginTop: 0 }}>Identidad del perfil</h3><EntityForm entity={entity} onSaved={setEntity} /></section>}
          {tab === 'eventos' && <EventsTab entity={entity} />}
          {tab === 'comunidad' && <CommunityTab entity={entity} />}
          {tab === 'campanas' && <CampaignsTab entity={entity} />}
          {tab === 'equipo' && <TeamTab entity={entity} />}
        </div>
      </div>
    </>
  );
}
