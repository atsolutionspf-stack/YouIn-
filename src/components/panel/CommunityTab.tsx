'use client';
import Link from 'next/link';
import { useCallback, useEffect, useState, type FormEvent } from 'react';
import { useSession } from '@/components/providers/SessionProvider';
import { useToast } from '@/components/ui/Toast';
import { Icon } from '@/components/ui/Icon';
import { ErrorState, Loading } from '@/components/ui/States';
import { formatCents } from '@/components/communities/ClubPreview';
import {
  createCommunity, fetchCommunityBySlug, fetchCommunityByEntity, fetchMembersAdmin, kickMember, unbanMember, updateCommunity, upsertClub,
} from '@/lib/data/communities';
import { GENRES } from '@/lib/domain/events';
import { formatDateTime } from '@/lib/domain/time';
import type { ClubRow, CommunityRow, EntityRow } from '@/lib/types';

type Member = Awaited<ReturnType<typeof fetchMembersAdmin>>[number];
const lines = (v: FormDataEntryValue | null) => String(v ?? '').split('\n').map((s) => s.trim()).filter(Boolean).slice(0, 12);

export function CommunityTab({ entity }: { entity: EntityRow }) {
  const { db, refreshCommunities, refreshEntities } = useSession();
  const toast = useToast();
  const [community, setCommunity] = useState<(CommunityRow & { clubs: ClubRow | ClubRow[] | null }) | null | undefined>(undefined);
  const [members, setMembers] = useState<Member[]>([]);
  const [error, setError] = useState('');
  const [busy, setBusy] = useState(false);

  const load = useCallback(async () => {
    if (!db) return;
    try {
      const ref = await fetchCommunityByEntity(db, entity.id);
      if (!ref) { setCommunity(null); return; }
      const full = await fetchCommunityBySlug(db, ref.slug);
      setCommunity(full as typeof community);
      setMembers(await fetchMembersAdmin(db, ref.id));
    } catch (e) { setError((e as Error).message); }
  }, [db, entity.id]);
  useEffect(() => { void load(); }, [load]);

  if (error) return <ErrorState message={error} onRetry={load} />;
  if (community === undefined) return <Loading />;

  async function create(e: FormEvent<HTMLFormElement>) {
    e.preventDefault();
    if (!db) return;
    const f = new FormData(e.currentTarget);
    setBusy(true);
    try {
      await createCommunity(db, entity.id, String(f.get('name')).trim(), String(f.get('description') ?? '').trim(), f.getAll('genres').map(String), lines(f.get('benefits')));
      toast('Comunidad creada');
      await Promise.all([load(), refreshCommunities(), refreshEntities()]);
    } catch (err) { toast((err as Error).message); } finally { setBusy(false); }
  }

  if (!community) {
    return (
      <section className="panel">
        <h3 style={{ marginTop: 0 }}>Abre la comunidad de {entity.name}</h3>
        <p className="muted">Un espacio gratuito con anuncios y chat de miembros. Después podrás preparar un club de pago separado.</p>
        <form onSubmit={create}>
          <label>Nombre de la comunidad<input name="name" required maxLength={80} defaultValue={entity.name} /></label>
          <label>Descripción<textarea name="description" maxLength={1000} placeholder="¿Qué compartiréis aquí?" /></label>
          <fieldset className="plain"><legend>Estilos</legend>
            <div className="row" style={{ marginBottom: 12 }}>{GENRES.filter((g) => g !== 'Sin clasificar').map((g) => (
              <label key={g} style={{ margin: 0, fontWeight: 400 }}><input type="checkbox" name="genres" value={g} defaultChecked={entity.genres.includes(g)} /> {g}</label>
            ))}</div>
          </fieldset>
          <label>Ventajas de la comunidad gratuita (una por línea)<textarea name="benefits" maxLength={1000} placeholder={'Avisos de próximas fiestas\nSesiones compartidas'} /></label>
          <button className="primary" disabled={busy}>Crear comunidad</button>
        </form>
      </section>
    );
  }

  const c = community;
  const club = Array.isArray(c.clubs) ? c.clubs[0] ?? null : c.clubs;

  async function saveInfo(e: FormEvent<HTMLFormElement>) {
    e.preventDefault();
    if (!db) return;
    const f = new FormData(e.currentTarget);
    try {
      await updateCommunity(db, c.id, {
        name: String(f.get('name')).trim(), description: String(f.get('description') ?? '').trim() || null, genres: f.getAll('genres').map(String),
        rules: String(f.get('rules') ?? '').trim() || null, free_benefits: lines(f.get('benefits')), welcome_message: String(f.get('welcome') ?? '').trim() || null,
      });
      toast('Comunidad guardada');
      await load();
    } catch (err) { toast((err as Error).message); }
  }

  async function saveClub(e: FormEvent<HTMLFormElement>) {
    e.preventDefault();
    if (!db) return;
    const f = new FormData(e.currentTarget);
    const price = Math.round(Number(String(f.get('price')).replace(',', '.')) * 100);
    if (!Number.isFinite(price) || price < 0 || price > 100000) { toast('Precio no válido (0–1.000 €).'); return; }
    try {
      await upsertClub(db, c.id, club?.id ?? null, {
        name: String(f.get('name')).trim(), description: String(f.get('description') ?? '').trim() || null, price_cents: price,
        billing_interval: f.get('interval') === 'year' ? 'year' : 'month', benefits: lines(f.get('benefits')),
      });
      toast('Club guardado (vista previa, sin cobros)');
      await load();
    } catch (err) { toast((err as Error).message); }
  }

  const active = members.filter((m) => !m.banned);
  const banned = members.filter((m) => m.banned);

  return (
    <div className="stack">
      <section className="panel">
        <div className="row"><h3 style={{ margin: 0 }}>{c.name}</h3><span className="spacer" />
          <Link className="pill" href={`/comunidades/${c.slug}?canal=anuncios`}><Icon name="megaphone" size={15} /> Publicar anuncio</Link>
          <Link className="pill" href={`/comunidades/${c.slug}?canal=chat`}><Icon name="chat" size={15} /> Ir al chat</Link>
        </div>
        <p className="muted-small">Moderas mensajes directamente en los canales (Moderar / Expulsar en cada mensaje).</p>
        <form onSubmit={saveInfo} style={{ marginTop: 14 }}>
          <label>Nombre<input name="name" required maxLength={80} defaultValue={c.name} /></label>
          <label>Descripción<textarea name="description" maxLength={1000} defaultValue={c.description ?? ''} /></label>
          <fieldset className="plain"><legend>Estilos</legend>
            <div className="row" style={{ marginBottom: 12 }}>{GENRES.filter((g) => g !== 'Sin clasificar').map((g) => (
              <label key={g} style={{ margin: 0, fontWeight: 400 }}><input type="checkbox" name="genres" value={g} defaultChecked={c.genres.includes(g)} /> {g}</label>
            ))}</div>
          </fieldset>
          <label>Ventajas de la comunidad gratuita (una por línea)<textarea name="benefits" maxLength={1000} defaultValue={c.free_benefits.join('\n')} /></label>
          <label>Mensaje de bienvenida (chat vacío)<input name="welcome" maxLength={500} defaultValue={c.welcome_message ?? ''} /></label>
          <label>Normas<textarea name="rules" maxLength={1500} defaultValue={c.rules ?? ''} /></label>
          <button className="primary">Guardar comunidad</button>
        </form>
      </section>

      <section className="panel">
        <h3 style={{ marginTop: 0 }}>Miembros ({active.length})</h3>
        {active.length ? active.map((m) => (
          <div key={m.user_id} className="list-row">
            <div><strong>{m.display_name}</strong><p>Desde {formatDateTime(m.joined_at)} · {Number(m.message_count)} mensajes</p></div>
            <button className="text-button danger" onClick={async () => {
              if (!db) return;
              const reason = prompt(`¿Expulsar a ${m.display_name}? No podrá leer, escribir ni volver a unirse. Motivo (opcional):`);
              if (reason === null) return;
              try { await kickMember(db, c.id, m.user_id, reason); toast('Persona expulsada'); await load(); } catch (e) { toast((e as Error).message); }
            }}>Expulsar</button>
          </div>
        )) : <p className="muted">Aún no hay miembros. Comparte el enlace de la comunidad con tu gente.</p>}
        {banned.length > 0 && (
          <>
            <h4>Expulsadas ({banned.length})</h4>
            {banned.map((m) => (
              <div key={m.user_id} className="list-row">
                <div><strong>{m.display_name}</strong><p>Expulsada el {formatDateTime(m.joined_at)}</p></div>
                <button className="pill" onClick={async () => {
                  if (!db || !confirm(`¿Readmitir a ${m.display_name}? Podrá volver a unirse.`)) return;
                  try { await unbanMember(db, c.id, m.user_id); toast('Readmitida: puede volver a unirse'); await load(); } catch (e) { toast((e as Error).message); }
                }}>Readmitir</button>
              </div>
            ))}
          </>
        )}
      </section>

      <section className="panel">
        <div className="row"><h3 style={{ margin: 0 }}>Club de pago</h3><span className="status-badge off">Vista previa · sin cobros</span></div>
        <p className="muted-small">Un espacio separado con su propia suscripción. Tú decides precio y ventajas; YOU IN? podrá aplicar una comisión ({club ? (club.platform_fee_bps / 100).toLocaleString('es-ES') : '10'} %). Los pagos no están conectados: nadie puede suscribirse todavía.</p>
        <form onSubmit={saveClub} style={{ marginTop: 12 }}>
          <label>Nombre del club<input name="name" required maxLength={80} defaultValue={club?.name ?? `Club ${c.name}`} /></label>
          <label>Descripción<textarea name="description" maxLength={1000} defaultValue={club?.description ?? ''} /></label>
          <div className="form-grid">
            <label>Precio (€)<input name="price" inputMode="decimal" required defaultValue={club ? String(club.price_cents / 100) : '5'} /></label>
            <label>Periodicidad<select name="interval" defaultValue={club?.billing_interval ?? 'month'}><option value="month">Mensual</option><option value="year">Anual</option></select></label>
          </div>
          <label>Ventajas del club (una por línea)<textarea name="benefits" maxLength={1000} defaultValue={club?.benefits.join('\n') ?? ''} /></label>
          {club && <p className="help">Precio actual de la vista previa: {formatCents(club.price_cents)} / {club.billing_interval === 'month' ? 'mes' : 'año'}.</p>}
          <button className="secondary">Guardar vista previa del club</button>
        </form>
      </section>
    </div>
  );
}
