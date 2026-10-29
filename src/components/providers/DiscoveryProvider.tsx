'use client';
import { createContext, useCallback, useContext, useEffect, useMemo, useState, type ReactNode } from 'react';
import { getBrowserClient } from '@/lib/supabase/client';
import { fetchEntitySummaries, fetchUpcomingEvents } from '@/lib/data/events';
import { loadOfflineSnapshot } from '@/lib/data/offline';
import type { DiscoveryEvent, EntitySummary } from '@/lib/types';

type DiscoveryState = {
  loading: boolean;
  error: string | null;
  events: DiscoveryEvent[];
  entities: EntitySummary[];
  entityMap: Map<string, EntitySummary>;
  offline: boolean;
  reload: () => void;
  upsertEvent: (e: DiscoveryEvent) => void;
};

const DiscoveryContext = createContext<DiscoveryState | null>(null);

/** Carga una vez los eventos próximos y los perfiles para mapa, lista y búsqueda. */
export function DiscoveryProvider({ children }: { children: ReactNode }) {
  const db = getBrowserClient();
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);
  const [events, setEvents] = useState<DiscoveryEvent[]>([]);
  const [entities, setEntities] = useState<EntitySummary[]>([]);
  const [nonce, setNonce] = useState(0);

  useEffect(() => {
    let active = true;
    (async () => {
      setLoading(true);
      setError(null);
      try {
        if (db) {
          const [ev, en] = await Promise.all([fetchUpcomingEvents(db), fetchEntitySummaries(db)]);
          if (!active) return;
          setEvents(ev);
          setEntities(en);
        } else {
          const snap = await loadOfflineSnapshot();
          if (!active) return;
          setEvents(snap.events);
          setEntities(snap.entities);
        }
      } catch (e) {
        if (active) setError((e as Error).message);
      } finally {
        if (active) setLoading(false);
      }
    })();
    return () => { active = false; };
  }, [db, nonce]);

  const reload = useCallback(() => setNonce((n) => n + 1), []);
  const upsertEvent = useCallback((e: DiscoveryEvent) => {
    // Solo los eventos publicados y no terminados forman parte del descubrimiento.
    const visible = e.status === 'published' && +new Date(e.ends_at) > Date.now();
    setEvents((list) => [...list.filter((x) => x.id !== e.id), ...(visible ? [e] : [])].sort((a, b) => +new Date(a.starts_at) - +new Date(b.starts_at)));
  }, []);

  const value = useMemo(() => ({
    loading, error, events, entities, entityMap: new Map(entities.map((e) => [e.id, e])), offline: !db, reload, upsertEvent,
  }), [loading, error, events, entities, db, reload, upsertEvent]);

  return <DiscoveryContext.Provider value={value}>{children}</DiscoveryContext.Provider>;
}

export function useDiscovery() {
  const ctx = useContext(DiscoveryContext);
  if (!ctx) throw new Error('useDiscovery fuera de DiscoveryProvider');
  return ctx;
}
