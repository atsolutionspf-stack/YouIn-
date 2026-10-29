'use client';
import Link from 'next/link';
import { useEffect, useState } from 'react';
import { useDiscovery } from '@/components/providers/DiscoveryProvider';
import { useSession } from '@/components/providers/SessionProvider';
import { Empty, ErrorState, Intro, Loading } from '@/components/ui/States';
import { Icon } from '@/components/ui/Icon';
import { fetchEvent } from '@/lib/data/events';
import type { DiscoveryEvent } from '@/lib/types';
import { EventDetail } from './EventDetail';
import { useNow } from '@/lib/hooks/useNow';

export function EventPageClient({ id }: { id: string }) {
  const { events, entityMap, loading: discoveryLoading } = useDiscovery();
  const { db } = useSession();
  const fromList = events.find((e) => e.id === id) ?? null;
  const [event, setEvent] = useState<DiscoveryEvent | null>(fromList);
  const [state, setState] = useState<'loading' | 'ready' | 'missing' | 'error'>(fromList ? 'ready' : 'loading');
  const [error, setError] = useState('');
  const now = useNow();

  useEffect(() => {
    if (fromList) { setEvent(fromList); setState('ready'); return; }
    if (discoveryLoading) return;
    if (!db) { setState('missing'); return; }
    let active = true;
    fetchEvent(db, id)
      .then((e) => { if (!active) return; setEvent(e); setState(e ? 'ready' : 'missing'); })
      .catch((e) => { if (active) { setError((e as Error).message); setState('error'); } });
    return () => { active = false; };
  }, [db, id, fromList, discoveryLoading]);

  const back = <Link className="secondary" href="/"><Icon name="back" size={16} /> Volver al mapa</Link>;
  if (state === 'loading') return <Loading label="Cargando evento…" />;
  if (state === 'error') return <ErrorState message={error} />;
  if (state === 'missing' || !event) {
    return <Empty title="Este evento no existe o ya no está publicado" icon="music" action={back} />;
  }
  const ended = +new Date(event.ends_at) < now;
  return (
    <>
      <Intro kicker="Tu próximo encuentro" title={event.title} sub={`${event.venue_name} · ${event.municipality}`} extra={back} />
      {ended && <div className="notice warm" style={{ marginBottom: 18 }}>Este evento ya ha terminado.</div>}
      <section className="panel"><EventDetail event={event} entityMap={entityMap} layout="page" /></section>
    </>
  );
}
