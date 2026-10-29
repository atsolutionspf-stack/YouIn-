'use client';
import { useEffect, useState } from 'react';
import { useSession } from '@/components/providers/SessionProvider';
import { ErrorState, Loading } from '@/components/ui/States';
import { fetchDashboard } from '@/lib/data/entities';
import type { EntityRow } from '@/lib/types';

const METRICS: [string, string][] = [
  ['followers', 'Seguidores'],
  ['upcoming_events', 'Eventos próximos'],
  ['past_events', 'Eventos pasados'],
  ['event_saves', 'Veces guardados sus eventos'],
  ['members', 'Miembros de la comunidad'],
  ['members_last_7d', 'Nuevos miembros (7 días)'],
  ['messages_last_7d', 'Mensajes (7 días)'],
  ['active_authors_last_7d', 'Personas que escriben (7 días)'],
  ['bans', 'Personas expulsadas'],
  ['campaigns', 'Campañas de recompensas'],
];

export function OverviewTab({ entity, go }: { entity: EntityRow; go: (tab: string) => void }) {
  const { db } = useSession();
  const [data, setData] = useState<Record<string, number | string | null> | null>(null);
  const [error, setError] = useState('');
  useEffect(() => {
    if (!db) return;
    fetchDashboard(db, entity.id).then(setData).catch((e) => setError((e as Error).message));
  }, [db, entity.id]);
  if (error) return <ErrorState message={error} />;
  if (!data) return <Loading />;
  return (
    <section className="stack">
      <div className="metrics">
        {METRICS.filter(([k]) => data.community_id || !['members', 'members_last_7d', 'messages_last_7d', 'active_authors_last_7d', 'bans', 'campaigns'].includes(k)).map(([k, label]) => (
          <div key={k} className="metric"><strong>{Number(data[k] ?? 0)}</strong><span>{label}</span></div>
        ))}
      </div>
      <p className="help">Métricas calculadas en el momento con datos reales de la base de datos. No hay estimaciones ni cifras de ejemplo.{entity.data_origin === 'demo' ? ' Este perfil es de demostración.' : ''}</p>
      {!data.community_id && (
        <div className="notice">Aún no tienes comunidad. <button className="text-button link" onClick={() => go('comunidad')}>Créala ahora</button> para conversar con tu gente.</div>
      )}
      {entity.kind !== 'dj' && <div className="row"><button className="primary rust" onClick={() => go('eventos')}>Publicar un evento</button></div>}
    </section>
  );
}
