'use client';
import Link from 'next/link';
import { useEffect, useState } from 'react';
import type { DiscoveryEvent, EntitySummary, SourceLink } from '@/lib/types';
import { formatPrice, provenance, safeHttpsUrl } from '@/lib/domain/events';
import { formatDay, formatHour, formatLongDay } from '@/lib/domain/time';
import { createIcs, downloadFile } from '@/lib/domain/ics';
import { mediaUrl } from '@/lib/data/storage';
import { useSession } from '@/components/providers/SessionProvider';
import { useToast } from '@/components/ui/Toast';
import { Avatar } from '@/components/ui/Avatar';
import { Icon } from '@/components/ui/Icon';
import { Poster } from './Poster';

type CommunityLink = { id: string; slug: string; name: string; entity_id: string };

const KIND_LABEL = { dj: 'DJ', venue: 'Sala', collective: 'Colectivo' } as const;

export function EventDetail({ event: e, entityMap, layout = 'modal' }: { event: DiscoveryEvent; entityMap: Map<string, EntitySummary>; layout?: 'modal' | 'page' }) {
  const { favorites, toggleFavorite, db } = useSession();
  const toast = useToast();
  const [communities, setCommunities] = useState<CommunityLink[]>([]);
  const saved = favorites.has(e.id);
  const prov = provenance(e);
  const venue = e.venue_entity_id ? entityMap.get(e.venue_entity_id) : undefined;
  const organizer = e.organizer_entity_id ? entityMap.get(e.organizer_entity_id) : undefined;
  const djs = [...e.event_artists].sort((a, b) => a.position - b.position).map((a) => entityMap.get(a.entity_id)).filter(Boolean) as EntitySummary[];
  const ticket = safeHttpsUrl(e.ticket_url);
  const sources = ((e.sources ?? []) as SourceLink[]).filter((s) => safeHttpsUrl(s.url));
  const shareUrl = typeof window !== 'undefined' ? `${window.location.origin}/eventos/${e.id}` : `/eventos/${e.id}`;

  // Comunidades de la sala, el organizador y los DJs.
  useEffect(() => {
    const ids = [e.venue_entity_id, e.organizer_entity_id, ...e.event_artists.map((a) => a.entity_id)].filter(Boolean) as string[];
    if (!db || !ids.length) return;
    let active = true;
    db.from('communities').select('id, slug, name, entity_id').in('entity_id', ids).then(({ data }) => {
      if (active) setCommunities(data ?? []);
    });
    return () => { active = false; };
  }, [db, e]);

  async function share() {
    const data = { title: e.title, text: `${e.title} · ${formatDay(e.starts_at)} · ${e.venue_name}`, url: shareUrl };
    try {
      if (navigator.share) { await navigator.share(data); return; }
      await navigator.clipboard.writeText(shareUrl);
      toast('Enlace copiado');
    } catch {
      /* el usuario canceló */
    }
  }

  const people: { p: EntitySummary; role: string }[] = [];
  if (venue) people.push({ p: venue, role: 'Sala' });
  if (organizer && organizer.id !== venue?.id) people.push({ p: organizer, role: `Organiza · ${KIND_LABEL[organizer.kind]}` });
  djs.forEach((p) => people.push({ p, role: 'DJ' }));

  return (
    <div className={layout === 'page' ? 'event-page' : undefined}>
      <div>
        <Poster event={e} className="modal-poster" />
        {e.video_path && (
          <section className="event-video">
            <h4>Un adelanto de la noche</h4>
            <video src={mediaUrl(e.video_path)} controls playsInline preload="metadata" aria-label={`Vídeo promocional de ${e.title}`} />
          </section>
        )}
      </div>
      <div>
        <div className="event-detail-top">
          <div>
            <span className="event-tag">{e.genre} · {e.area || e.municipality || 'València'}</span>
            <h3 style={{ margin: '9px 0' }}>{e.title}</h3>
          </div>
          <button className="iconbutton" onClick={() => toggleFavorite(e.id)} aria-label={saved ? 'Quitar de favoritos' : 'Guardar evento'} aria-pressed={saved}>
            <Icon name="heart" size={19} fill={saved} />
          </button>
        </div>
        {e.status === 'cancelled' && <div className="notice warm"><strong>Evento cancelado.</strong></div>}
        <div className={`notice ${prov.tone === 'demo' ? 'warm' : ''}`}>{prov.detail}</div>
        {e.description && <p style={{ whiteSpace: 'pre-line' }}>{e.description}</p>}
        {e.time_warning && <div className="notice warm">{e.time_warning}</div>}

        <div className="detail-row">
          <Icon name="clock" size={20} />
          <div>
            <span style={{ textTransform: 'capitalize' }}>{formatLongDay(e.starts_at)}</span> · {formatHour(e.starts_at)}
            <small>
              {e.time_warning ? 'Hora de fin pendiente de contrastar' : e.until_late ? 'Hasta cierre · hora de Madrid' : `Termina: ${formatDay(e.ends_at)}, ${formatHour(e.ends_at)} · hora de Madrid · 24 h`}
            </small>
          </div>
        </div>
        <div className="detail-row">
          <Icon name="pin" size={20} />
          <div>
            {venue ? <Link className="text-button" href={`/p/${venue.slug}`}>{e.venue_name} <Icon name="arrow" size={13} /></Link> : e.venue_name}
            <small>{e.room ? `${e.room} · ` : ''}{e.address}{e.municipality ? ` · ${e.municipality}` : ''}</small>
            {e.lat === null && <small>Sin coordenadas publicadas: no aparece en el mapa.</small>}
          </div>
        </div>
        <div className="detail-row">
          <Icon name="ticket" size={20} />
          <div>
            {formatPrice(e)}
            <small>
              {e.data_origin === 'imported'
                ? `${e.price_note || 'Consultar en origen'} · precio publicado en la consulta; gastos, condiciones y disponibilidad en el vendedor`
                : e.data_origin === 'demo' ? 'Precio de demostración' : 'Precio indicado por el organizador'}
            </small>
            {e.price_kind === 'conditional-free' && <small>* El acceso gratuito tiene las condiciones de la lista publicada. Verifica registro y franja horaria.</small>}
            {e.age && <small>Edad mínima indicada: {e.age}</small>}
          </div>
        </div>
        {!!e.source_genres?.length && <div className="tags">{e.source_genres.map((g) => <span key={g} className="tag">{g}</span>)}</div>}

        <h4>Quién pone el sonido</h4>
        <div className="lineup">
          {djs.length ? djs.map((p) => (
            <Link key={p.id} className="artist" href={`/p/${p.slug}`}><Avatar p={p} /> {p.name}</Link>
          )) : <p className="muted-small">Sin artistas detallados en los datos disponibles.</p>}
        </div>

        {(people.length > 0 || communities.length > 0) && (
          <>
            <h4 style={{ marginTop: 22 }}>Conecta con su gente</h4>
            <div className="connect-grid">
              {people.map(({ p, role }) => (
                <Link key={p.id + role} className="connect-card" href={`/p/${p.slug}`}>
                  <Avatar p={p} />
                  <span><strong>{p.name}</strong><small>{role}{p.data_origin === 'imported' ? ' · referencia sin reclamar' : ''}</small></span>
                </Link>
              ))}
              {communities.map((c) => (
                <Link key={c.id} className="connect-card" href={`/comunidades/${c.slug}`}>
                  <span className="avatar peach"><Icon name="people" size={18} /></span>
                  <span><strong>{c.name}</strong><small>Comunidad · entra y participa</small></span>
                </Link>
              ))}
            </div>
          </>
        )}

        {sources.length > 0 && (
          <div className="source-links">
            <strong>Referencias de origen</strong>
            {sources.map((s) => (
              <a key={s.url} href={safeHttpsUrl(s.url)} target="_blank" rel="noopener noreferrer">{s.label} <Icon name="external" size={12} /></a>
            ))}
          </div>
        )}

        <div className="event-actions">
          {ticket ? (
            <a className="primary" href={ticket} target="_blank" rel="noopener noreferrer">Ver entradas en el vendedor <Icon name="external" size={15} /></a>
          ) : (
            <span className="muted-small">{e.data_origin === 'demo' ? 'Evento ficticio: sin venta de entradas.' : 'Sin enlace de venta publicado.'}</span>
          )}
          <button className="secondary" onClick={share}><Icon name="share" size={16} /> Compartir</button>
          <button className="secondary" onClick={() => {
            downloadFile(e.data_origin === 'demo' ? 'you-in-evento-demo.ics' : 'you-in-evento.ics', createIcs(e, shareUrl), 'text/calendar');
            toast('Calendario descargado');
          }}><Icon name="calendar" size={16} /> Añadir al calendario</button>
          {e.lat !== null && <Link className="secondary" href={`/?evento=${e.id}`}><Icon name="map" size={16} /> Ver en mapa</Link>}
        </div>
        {ticket && <p className="help" style={{ marginTop: 12 }}>La compra se hace en el vendedor externo. YOU IN? no vende entradas ni confirma disponibilidad.</p>}
      </div>
    </div>
  );
}
