'use client';
import { useCallback, useEffect, useState, type FormEvent } from 'react';
import { useSession } from '@/components/providers/SessionProvider';
import { useToast } from '@/components/ui/Toast';
import { ErrorState, Loading } from '@/components/ui/States';
import { addAdmin, fetchTeam, removeAdmin } from '@/lib/data/entities';
import type { EntityRow } from '@/lib/types';

type Member = Awaited<ReturnType<typeof fetchTeam>>[number];

export function TeamTab({ entity }: { entity: EntityRow }) {
  const { db, user } = useSession();
  const toast = useToast();
  const [team, setTeam] = useState<Member[] | null>(null);
  const [error, setError] = useState('');
  const load = useCallback(async () => {
    if (!db) return;
    try { setTeam(await fetchTeam(db, entity.id)); } catch (e) { setError((e as Error).message); }
  }, [db, entity.id]);
  useEffect(() => { void load(); }, [load]);

  if (error) return <ErrorState message={error} onRetry={load} />;
  if (!team) return <Loading />;
  const iAmOwner = team.some((m) => m.user_id === user?.id && m.role === 'owner');

  async function add(e: FormEvent<HTMLFormElement>) {
    e.preventDefault();
    if (!db) return;
    const form = e.currentTarget;
    const email = String(new FormData(form).get('email') ?? '').trim();
    try { await addAdmin(db, entity.id, email); toast('Persona añadida al equipo'); form.reset(); await load(); } catch (err) { toast((err as Error).message); }
  }

  return (
    <section className="panel">
      <h3 style={{ marginTop: 0 }}>Equipo de administración</h3>
      <p className="muted-small">Pueden editar el perfil, publicar eventos, gestionar la comunidad y las campañas. Solo el propietario añade o quita personas.</p>
      {team.map((m) => (
        <div key={m.user_id} className="list-row">
          <div><strong>{m.display_name}</strong><p>{m.email} · {m.role === 'owner' ? 'Propietario/a' : 'Administrador/a'}</p></div>
          {iAmOwner && m.role !== 'owner' && (
            <button className="text-button danger" onClick={async () => {
              if (!db || !confirm(`¿Quitar a ${m.display_name} del equipo?`)) return;
              try { await removeAdmin(db, entity.id, m.user_id); await load(); } catch (e) { toast((e as Error).message); }
            }}>Quitar</button>
          )}
        </div>
      ))}
      {iAmOwner && (
        <form onSubmit={add} style={{ marginTop: 16 }}>
          <label>Añadir por correo (debe tener cuenta en YOU IN?)<input name="email" type="email" required /></label>
          <button className="secondary">Añadir administrador/a</button>
        </form>
      )}
    </section>
  );
}
