'use client';
import Link from 'next/link';
import { useEffect, useState } from 'react';
import { useSession } from '@/components/providers/SessionProvider';
import { useDiscovery } from '@/components/providers/DiscoveryProvider';
import { Avatar } from '@/components/ui/Avatar';
import { Icon } from '@/components/ui/Icon';
import { Empty, ErrorState, Intro, Loading } from '@/components/ui/States';
import { EventCard } from '@/components/events/EventCard';
import { fetchEntityBySlug, fetchFollowerCount, isEntityAdmin } from '@/lib/data/entities';
import { fetchEntityEvents } from '@/lib/data/events';
import { fetchCommunityByEntity } from '@/lib/data/communities';
import { mediaUrl } from '@/lib/data/storage';
import { loadOfflineSnapshot } from '@/lib/data/offline';
import { safeHttpsUrl } from '@/lib/domain/events';
import { downloadFile } from '@/lib/domain/ics';
import type { DiscoveryEvent, EntityRow } from '@/lib/types';

export const KIND_LABEL = { dj: 'DJ', venue: 'Sala', collective: 'Colectivo' } as const;
const ACCENTS = ['#765466', '#AF4529', '#386B68', '#596597', '#84652D'];
const FONTS = ['Manrope', 'DM Sans', 'Georgia'];
const LINKS: [string, string][] = [['soundcloud', 'SoundCloud'], ['spotify', 'Spotify'], ['instagram', 'Instagram'], ['website', 'Web']];

export function profileStyle(p: Pick<EntityRow, 'accent' | 'profile_font'>) {
  const accent = ACCENTS.includes(p.accent) ? p.accent : '#765466';
  const font = FONTS.includes(p.profile_font) ? p.profile_font : 'Manrope';
  return { ['--dj-accent' as string]: accent, ['--dj-font' as string]: `'${font}'` } as React.CSSProperties;
}

export function originTag(p: Pick<EntityRow, 'data_origin'>) {
  if (p.data_origin === 'imported') return 'Referencia pública · sin reclamar';
  if (p.data_origin === 'demo') return 'Perfil de demostración';
  return 'Perfil en YOU IN?';
}

export function ProfileView({ slug }: { slug: string }) {
  const { db, user, follows, toggleFollow } = useSession();
  const { entityMap, events: allEvents } = useDiscovery();
  const [entity, setEntity] = useState<EntityRow | null>(null);
  const [events, setEvents] = useState<DiscoveryEvent[]>([]);
  const [followers, setFollowers] = useState<number | null>(null);
  const [community, setCommunity] = useState<{ slug: string; name: string } | null>(null);
  const [admin, setAdmin] = useState(false);
  const [state, setState] = useState<'loading' | 'ready' | 'missing' | 'error'>('loading');
  const [error, setError] = useState('');

  useEffect(() => {
    let active = true;
    (async () => {
      try {
        if (!db) {
          // Modo demo sin servidor: solo datos incluidos, sin seguir ni comunidades.
          const snap = await loadOfflineSnapshot();
          const s = snap.entities.find((x) => x.slug === slug);
          if (!active) return;
          if (!s) { setState('missing'); return; }
          setEntity({ ...s, bio: null, address: null, lat: null, lng: null, cover_path: null, accent: '#765466', profile_font: 'Manrope', profile_layout: 'editorial', links: {}, contact_email: null, contact_phone: null, source_url: null, source_key: null, user_id: null, created_by: null, created_at: '', updated_at: '', province: null } as EntityRow);
          setEvents(snap.events.filter((e) => e.organizer_entity_id === s.id || e.venue_entity_id === s.id || e.event_artists.some((a) => a.entity_id === s.id)));
          setState('ready');
          return;
        }
        const e = await fetchEntityBySlug(db, slug);
        if (!active) return;
        if (!e) { setState('missing'); return; }
        setEntity(e);
        const [evs, count, com, isAdmin] = await Promise.all([
          fetchEntityEvents(db, e.id), fetchFollowerCount(db, e.id), fetchCommunityByEntity(db, e.id), user ? isEntityAdmin(db, e.id) : Promise.resolve(false),
        ]);
        if (!active) return;
        setEvents(evs);
        setFollowers(count);
        setCommunity(com);
        setAdmin(isAdmin);
        setState('ready');
      } catch (err) {
        if (active) { setError((err as Error).message); setState('error'); }
      }
    })();
    return () => { active = false; };
  }, [db, slug, user, allEvents.length]);

  if (state === 'loading') return <Loading label="Cargando perfil…" />;
  if (state === 'error') return <ErrorState message={error} />;
  if (state === 'missing' || !entity) {
    return <Empty title="Este perfil no existe" icon="user" action={<Link className="secondary" href="/explorar">Volver a explorar</Link>} />;
  }

  const p = entity;
  const followed = follows.has(p.id);
  const links = (p.links ?? {}) as Record<string, string>;
  const cover = mediaUrl(p.cover_path);
  const isDj = p.kind === 'dj';
  const sourceUrl = safeHttpsUrl(p.source_url);

  function presskit() {
    downloadFile(`you-in-presskit-${p.slug}.txt`,
      `${p.name}\n${KIND_LABEL[p.kind]} · ${p.area || 'Valencia'}\n${p.genres.join(' · ')}\n${p.tagline ? '\n«' + p.tagline + '»\n' : ''}\n${p.bio || ''}\n\n` +
      LINKS.filter(([k]) => safeHttpsUrl(links[k])).map(([k, l]) => `${l}: ${links[k]}`).join('\n') +
      `\nContacto: ${p.contact_email || 'No indicado'}${p.contact_phone ? ' · ' + p.contact_phone : ''}\n\nGenerado desde YOU IN?${p.data_origin === 'demo' ? ' (perfil de demostración)' : ''}\n`,
      'text/plain');
  }

  return (
    <>
      <Intro kicker="Conoce a la escena" title={p.name} sub={`${KIND_LABEL[p.kind]} · ${p.area || p.municipality || 'Valencia'}`}
        extra={<Link className="secondary" href="/explorar"><Icon name="back" size={16} /> Volver a explorar</Link>} />
      <div className="profile-layout">
        <section className={`panel profile-hero dj-personalized ${p.profile_layout === 'compact' ? 'compact' : ''}`} style={profileStyle(p)}>
          {(isDj || cover) && (
            <div className="dj-cover">
              {/* eslint-disable-next-line @next/next/no-img-element */}
              {cover ? <img src={cover} alt={`Portada de ${p.name}`} /> : <span aria-hidden="true">◌</span>}
            </div>
          )}
          <Avatar p={p} />
          <div className="tags">
            <span className="tag">{KIND_LABEL[p.kind]}</span>
            <span className="tag">{originTag(p)}</span>
          </div>
          <h2>{p.name}</h2>
          {p.tagline && <p className="dj-tagline">{p.tagline}</p>}
          <p>{p.genres.length ? p.genres.join(' · ') : 'Todos los géneros'}</p>
          <p style={{ whiteSpace: 'pre-line' }}>{p.bio || 'Un nuevo perfil de la escena.'}</p>
          {p.kind === 'venue' && p.address && <p><Icon name="pin" size={14} /> {p.address}</p>}
          <div className="profile-stats">
            {followers !== null && <span><strong>{followers}</strong>seguidores</span>}
            <span><strong>{events.length}</strong>próximos eventos</span>
          </div>
          <div className="actions">
            <button className="primary" onClick={() => toggleFollow(p.id)} aria-pressed={followed}>
              <Icon name={followed ? 'check' : 'plus'} size={17} /> {followed ? 'Siguiendo' : 'Seguir'}
            </button>
            {sourceUrl && <a className="secondary" href={sourceUrl} target="_blank" rel="noopener noreferrer">Ver fuente <Icon name="external" size={14} /></a>}
            {admin && <Link className="secondary" href={`/panel/${p.slug}`}><Icon name="settings" size={15} /> Gestionar</Link>}
          </div>
          {p.data_origin === 'imported' && (
            <p className="help" style={{ marginTop: 14 }}>
              Perfil creado a partir de información pública. No está registrado ni reclamado por {p.name} y no se puede editar desde YOU IN?.
              La reclamación verificada de perfiles llegará más adelante.
            </p>
          )}
          {p.contact_email && <p><Icon name="mail" size={15} /> <a href={`mailto:${p.contact_email}`}>{p.contact_email}</a></p>}
          {p.contact_phone && <p>Teléfono: {p.contact_phone}</p>}
          {isDj && <div className="actions"><button className="text-button" onClick={presskit}><Icon name="download" size={15} /> Descargar presskit</button></div>}
          {LINKS.some(([k]) => safeHttpsUrl(links[k])) && (
            <div className="dj-social-links">
              {LINKS.filter(([k]) => safeHttpsUrl(links[k])).map(([k, label]) => (
                <a key={k} className="pill" href={safeHttpsUrl(links[k])} target="_blank" rel="noopener noreferrer">{label} <Icon name="external" size={12} /></a>
              ))}
            </div>
          )}
          <hr className="divider" />
          {community ? (
            <Link className="secondary full" href={`/comunidades/${community.slug}`}><Icon name="people" size={16} /> Conocer su comunidad · {community.name}</Link>
          ) : (
            <p className="muted-small">{p.data_origin === 'imported' ? 'Los perfiles sin reclamar no tienen comunidad.' : 'Este perfil aún no ha abierto su comunidad.'}</p>
          )}
          <p className="help" style={{ marginTop: 10 }}>Seguir te avisa de su agenda; para conversar, únete a su comunidad.</p>
        </section>
        <section>
          <div className="section-head" style={{ marginTop: 0 }}><h2>Próximos encuentros</h2></div>
          <div className="cards">
            {events.length ? events.map((e) => <EventCard key={e.id} event={e} entityMap={entityMap} />) : (
              <Empty title="La próxima noche está por anunciar" icon="music">
                Los eventos aparecerán aquí cuando este perfil los publique o reciba una mención.
              </Empty>
            )}
          </div>
        </section>
      </div>
    </>
  );
}
