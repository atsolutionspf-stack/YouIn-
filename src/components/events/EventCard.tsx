'use client';
import Link from 'next/link';
import { forwardRef } from 'react';
import type { DiscoveryEvent, EntitySummary } from '@/lib/types';
import { formatPrice, provenance } from '@/lib/domain/events';
import { formatDay, formatHours } from '@/lib/domain/time';
import { useSession } from '@/components/providers/SessionProvider';
import { Icon } from '@/components/ui/Icon';
import { Poster } from './Poster';

type Props = {
  event: DiscoveryEvent;
  entityMap: Map<string, EntitySummary>;
  selected?: boolean;
  onOpen?: (id: string) => void;
  onFocusEvent?: (id: string) => void;
};

export const EventCard = forwardRef<HTMLElement, Props>(function EventCard({ event: e, entityMap, selected, onOpen, onFocusEvent }, ref) {
  const { favorites, toggleFavorite } = useSession();
  const saved = favorites.has(e.id);
  const prov = provenance(e);
  const djs = e.event_artists.map((a) => entityMap.get(a.entity_id)?.name).filter(Boolean).join(' + ');
  const open = (ev: React.MouseEvent) => {
    if (onOpen && !ev.metaKey && !ev.ctrlKey) { ev.preventDefault(); onOpen(e.id); }
  };
  return (
    <article ref={ref} className={`event-card ${selected ? 'selected' : ''}`} onMouseEnter={() => onFocusEvent?.(e.id)} data-event-id={e.id}>
      <Link className="poster-button" href={`/eventos/${e.id}`} onClick={open} aria-label={`Ver ${e.title}`} tabIndex={-1}>
        <Poster event={e} className="poster" />
      </Link>
      <div className="event-info">
        <span className="event-tag">{e.genre} · {e.area || e.municipality || 'València'}</span>
        <h3><Link href={`/eventos/${e.id}`} onClick={open} onFocus={() => onFocusEvent?.(e.id)}>{e.title}</Link></h3>
        <p>{e.venue_name}<br />{formatDay(e.starts_at)} · {formatHours(e)}</p>
        <div className="card-bottom">
          <span>
            <span className={`source-badge ${prov.tone}`} title={prov.detail}>{prov.label}</span>
            {djs && <span className="card-djs"> {djs}</span>}
          </span>
          <strong title={e.price_note ?? ''}>{formatPrice(e)}</strong>
        </div>
      </div>
      <button className={`save ${saved ? 'saved' : ''}`} onClick={() => toggleFavorite(e.id)} aria-label={saved ? `Quitar ${e.title} de favoritos` : `Guardar ${e.title} en favoritos`} aria-pressed={saved}>
        <Icon name="heart" size={18} fill={saved} />
      </button>
    </article>
  );
});
