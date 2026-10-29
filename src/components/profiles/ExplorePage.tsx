'use client';
import Link from 'next/link';
import { useMemo, useState } from 'react';
import { useDiscovery } from '@/components/providers/DiscoveryProvider';
import { useSession } from '@/components/providers/SessionProvider';
import { Avatar } from '@/components/ui/Avatar';
import { Icon } from '@/components/ui/Icon';
import { Empty, ErrorState, Intro, Loading } from '@/components/ui/States';
import { normalize } from '@/lib/domain/events';
import type { EntityKind, EntitySummary } from '@/lib/types';
import { KIND_LABEL } from './ProfileView';

const TYPES: [EntityKind | 'all', string][] = [['all', 'Todos'], ['dj', 'DJs'], ['venue', 'Salas'], ['collective', 'Colectivos']];
const PAGE = 24;

export function ProfileCard({ p }: { p: EntitySummary }) {
  const { follows, toggleFollow } = useSession();
  const followed = follows.has(p.id);
  return (
    <article className="profile-card">
      <header>
        <Avatar p={p} />
        <span className="tag">{KIND_LABEL[p.kind]}{p.data_origin === 'imported' ? ' · referencia' : p.data_origin === 'demo' ? ' · demo' : ''}</span>
      </header>
      <h3>{p.name}</h3>
      <p>{p.genres.length ? p.genres.join(' · ') : 'Todos los géneros'}<br />{p.area || p.municipality || 'Valencia'}</p>
      <div className="row">
        <Link className="text-button" href={`/p/${p.slug}`}>Conoce su universo <Icon name="arrow" size={15} /></Link>
        <span className="spacer" />
        <button className={`pill ${followed ? 'dark' : ''}`} onClick={() => toggleFollow(p.id)} aria-pressed={followed} aria-label={`${followed ? 'Dejar de seguir' : 'Seguir'} a ${p.name}`}>
          {followed ? 'Siguiendo' : 'Seguir'}
        </button>
      </div>
    </article>
  );
}

export function ExplorePage() {
  const { entities, events, loading, error, reload } = useDiscovery();
  const [type, setType] = useState<EntityKind | 'all'>('all');
  const [query, setQuery] = useState('');
  const [origin, setOrigin] = useState<'all' | 'app' | 'imported'>('all');
  const [withEvents, setWithEvents] = useState(false);
  const [limit, setLimit] = useState(PAGE);

  const withUpcoming = useMemo(() => {
    const s = new Set<string>();
    for (const e of events) {
      if (e.organizer_entity_id) s.add(e.organizer_entity_id);
      if (e.venue_entity_id) s.add(e.venue_entity_id);
      e.event_artists.forEach((a) => { if (!a.hidden_by_artist) s.add(a.entity_id); });
    }
    return s;
  }, [events]);

  const found = useMemo(() => {
    const q = normalize(query);
    return entities
      .filter((p) => type === 'all' || p.kind === type)
      .filter((p) => origin === 'all' || (origin === 'imported' ? p.data_origin === 'imported' : p.data_origin !== 'imported'))
      .filter((p) => !withEvents || withUpcoming.has(p.id))
      .filter((p) => !q || normalize([p.name, p.area, p.municipality, ...p.genres].join(' ')).includes(q))
      .sort((a, b) => Number(withUpcoming.has(b.id)) - Number(withUpcoming.has(a.id)) || a.name.localeCompare(b.name, 'es'));
  }, [entities, type, origin, withEvents, withUpcoming, query]);

  return (
    <>
      <Intro kicker="Conoce a la escena" title={<>Detrás de cada noche,<br /><em>hay personas.</em></>}
        sub="DJs, salas y colectivos de Valencia. Síguelos y entra en sus comunidades." />
      <div className="toolbar">
        <div className="searchbox">
          <Icon name="search" size={18} />
          <input type="search" value={query} onChange={(e) => { setQuery(e.target.value); setLimit(PAGE); }} placeholder="Busca por nombre, zona o estilo…" aria-label="Buscar perfiles" />
        </div>
        <div className="segmented" role="group" aria-label="Tipo de perfil">
          {TYPES.map(([v, l]) => <button key={v} className={type === v ? 'active' : ''} aria-pressed={type === v} onClick={() => { setType(v); setLimit(PAGE); }}>{l}</button>)}
        </div>
      </div>
      <div className="chips" role="group" aria-label="Más filtros">
        <button className={`chip ${origin === 'all' ? 'active' : ''}`} aria-pressed={origin === 'all'} onClick={() => setOrigin('all')}>Todos los perfiles</button>
        <button className={`chip ${origin === 'app' ? 'active' : ''}`} aria-pressed={origin === 'app'} onClick={() => setOrigin('app')}>En YOU IN? y demo</button>
        <button className={`chip ${origin === 'imported' ? 'active' : ''}`} aria-pressed={origin === 'imported'} onClick={() => setOrigin('imported')}>Referencias importadas</button>
        <button className={`chip ${withEvents ? 'active' : ''}`} aria-pressed={withEvents} onClick={() => setWithEvents((v) => !v)}>Con eventos próximos</button>
      </div>
      <div className="section-head"><h2>{loading ? 'Cargando…' : `${found.length} perfiles`}</h2><Link className="pill" href="/comunidades"><Icon name="people" size={15} /> Ver comunidades</Link></div>
      {error ? <ErrorState message={error} onRetry={reload} /> : loading ? <Loading /> : found.length ? (
        <>
          <div className="profiles-grid">{found.slice(0, limit).map((p) => <ProfileCard key={p.id} p={p} />)}</div>
          {found.length > limit && <button className="secondary more-events" onClick={() => setLimit((l) => l + PAGE)}>Ver más perfiles ({limit} de {found.length})</button>}
        </>
      ) : (
        <Empty title="Nadie con ese nombre… todavía" icon="user">Prueba con otra búsqueda o tipo de perfil.</Empty>
      )}
      <p className="help" style={{ marginTop: 18 }}>
        Las referencias importadas proceden de páginas públicas de ticketing: son informativas, no cuentas reclamadas, y no tienen comunidad.
      </p>
    </>
  );
}
