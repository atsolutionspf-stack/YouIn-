'use client';
import { useState } from 'react';
import type { DiscoveryEvent } from '@/lib/types';
import { mediaUrl } from '@/lib/data/storage';
import { safeHttpsUrl } from '@/lib/domain/events';

const STYLES = ['groove', 'orbita', 'sol', 'onda'];

export function posterSrc(e: Pick<DiscoveryEvent, 'poster_path' | 'poster_url' | 'poster_style' | 'data_origin'>) {
  return (
    mediaUrl(e.poster_path) ||
    safeHttpsUrl(e.poster_url) ||
    (e.data_origin === 'imported' ? '/brand/poster-unavailable.svg' : `/brand/${STYLES.includes(e.poster_style) ? e.poster_style : 'groove'}.svg`)
  );
}

/** Cartel con alternativa si la imagen de la fuente deja de estar disponible. */
export function Poster({ event, className }: { event: Pick<DiscoveryEvent, 'title' | 'poster_path' | 'poster_url' | 'poster_style' | 'data_origin'>; className?: string }) {
  const [failed, setFailed] = useState(false);
  const src = failed ? '/brand/poster-unavailable.svg' : posterSrc(event);
  return (
    // eslint-disable-next-line @next/next/no-img-element
    <img
      className={className}
      src={src}
      alt={failed ? 'Cartel no disponible' : `Cartel de ${event.title}`}
      loading="lazy"
      referrerPolicy="no-referrer"
      onError={() => setFailed(true)}
    />
  );
}
