'use client';
import Link from 'next/link';
import { useCallback, useEffect, useState } from 'react';
import { useSession } from '@/components/providers/SessionProvider';
import { useDiscovery } from '@/components/providers/DiscoveryProvider';
import { useToast } from '@/components/ui/Toast';
import { Empty, ErrorState, Loading } from '@/components/ui/States';
import { Icon } from '@/components/ui/Icon';
import { deleteEvent, EVENT_COLUMNS } from '@/lib/data/events';
import { friendlyError } from '@/lib/data/errors';
import { formatDay, formatHour } from '@/lib/domain/time';
import type { DiscoveryEvent, EntityRow } from '@/lib/types';
import { EventForm } from './EventForm';
import { useNow } from '@/lib/hooks/useNow';

export function EventsTab({ entity }: { entity: EntityRow }) {
  const { db } = useSession();
  const { reload } = useDiscovery();
  const toast = useToast();
  const [events, setEvents] = useState<DiscoveryEvent[] | null>(null);
  const [error, setError] = useState('');
  const [editing, setEditing] = useState<DiscoveryEvent | 'new' | null>(null);
  const now = useNow();

  const load = useCallback(async () => {
    if (!db) return;
    const { data, error: e } = await db.from('events').select(EVENT_COLUMNS).eq('organizer_entity_id', entity.id).order('starts_at', { ascending: false });
    if (e) setError(friendlyError(e)); else setEvents((data ?? []) as unknown as DiscoveryEvent[]);
  }, [db, entity.id]);
  useEffect(() => { void load(); }, [load]);

  if (entity.kind === 'dj') {
    return (
      <section className="panel">
        <h3 style={{ marginTop: 0 }}>Tu agenda como DJ</h3>
        <p className="muted">Los eventos los publican salas y colectivos. Cuando te mencionan, el evento se añade a tu agenda y puedes ocultarlo de tu perfil sin borrarlo.</p>
        <Link className="secondary" href="/perfil">Gestionar mis menciones</Link>
      </section>
    );
  }
  if (editing) {
    return (
      <section className="panel">
        <h3 style={{ marginTop: 0 }}>{editing === 'new' ? 'Publicar un evento gratis' : 'Editar evento'}</h3>
        <EventForm organizer={entity} event={editing === 'new' ? null : editing} onDone={() => { setEditing(null); void load(); reload(); }} />
      </section>
    );
  }
  if (error) return <ErrorState message={error} onRetry={load} />;
  if (!events) return <Loading />;

  async function remove(e: DiscoveryEvent) {
    if (!db || !confirm(`¿Borrar «${e.title}»? Se eliminará también de favoritos y agendas.`)) return;
    try { await deleteEvent(db, e.id); toast('Evento borrado'); await load(); reload(); } catch (err) { toast((err as Error).message); }
  }

  return (
    <section className="panel">
      <div className="row"><h3 style={{ margin: 0 }}>Eventos de {entity.name}</h3><span className="spacer" />
        <button className="primary rust" onClick={() => setEditing('new')}><Icon name="plus" size={16} /> Crear evento gratis</button>
      </div>
      <p className="muted-small">Las salas y colectivos publican eventos manualmente y sin coste.</p>
      {events.length ? events.map((e) => (
        <div key={e.id} className="list-row">
          <div>
            <Link href={`/eventos/${e.id}`}><strong>{e.title}</strong></Link>
            <p>
              {formatDay(e.starts_at)} · {formatHour(e.starts_at)} · {e.venue_name}
              {' · '}<span className={`status-badge ${e.status === 'published' ? 'ok' : e.status === 'draft' ? 'off' : 'warn'}`}>{e.status === 'published' ? 'Publicado' : e.status === 'draft' ? 'Borrador' : 'Cancelado'}</span>
              {+new Date(e.ends_at) < now && ' · terminado'}
              {e.lat === null && ' · sin ubicación en mapa'}
            </p>
          </div>
          <div className="row">
            <button className="pill" onClick={() => setEditing(e)}>Editar</button>
            <button className="text-button danger" onClick={() => remove(e)} aria-label={`Borrar ${e.title}`}><Icon name="trash" size={15} /></button>
          </div>
        </div>
      )) : <Empty title="Aún no has publicado eventos" icon="calendar">Publica tu primer evento: aparecerá en el mapa y en la lista al instante.</Empty>}
    </section>
  );
}
