'use client';
import Link from 'next/link';
import { useRouter } from 'next/navigation';
import { useCallback, useEffect, useState, type FormEvent } from 'react';
import { useSession } from '@/components/providers/SessionProvider';
import { useToast } from '@/components/ui/Toast';
import { Avatar } from '@/components/ui/Avatar';
import { Icon } from '@/components/ui/Icon';
import { Modal } from '@/components/ui/Modal';
import { Intro, Loading, NeedsLogin, NoBackend } from '@/components/ui/States';
import { activateDj, exportMyData } from '@/lib/data/user';
import { createOrganization } from '@/lib/data/entities';
import { setMentionHidden } from '@/lib/data/events';
import { fetchMyCampaigns } from '@/lib/data/rewards';
import { downloadFile } from '@/lib/domain/ics';
import { formatDay, formatHour } from '@/lib/domain/time';
import { KIND_LABEL } from './ProfileView';
import { useNow } from '@/lib/hooks/useNow';

type Mention = { event_id: string; hidden_by_artist: boolean; events: { id: string; title: string; starts_at: string; ends_at: string; status: string } | null };
type MyCampaign = Awaited<ReturnType<typeof fetchMyCampaigns>>[number];

export function MyProfilePage() {
  const { configured, ready, user, profile, db, favorites, follows, communities, entities, djEntity, refreshEntities, signOut } = useSession();
  const toast = useToast();
  const router = useRouter();
  const [mentions, setMentions] = useState<Mention[]>([]);
  const [campaigns, setCampaigns] = useState<MyCampaign[]>([]);
  const [orgOpen, setOrgOpen] = useState(false);
  const [busy, setBusy] = useState(false);
  const [orgError, setOrgError] = useState('');
  const now = useNow();

  const loadMentions = useCallback(async () => {
    if (!db || !djEntity) { setMentions([]); return; }
    const { data } = await db.from('event_artists').select('event_id, hidden_by_artist, events(id, title, starts_at, ends_at, status)').eq('entity_id', djEntity.id);
    setMentions(((data ?? []) as unknown as Mention[]).filter((m) => m.events).sort((a, b) => +new Date(a.events!.starts_at) - +new Date(b.events!.starts_at)));
  }, [db, djEntity]);

  useEffect(() => { void loadMentions(); }, [loadMentions]);
  useEffect(() => { if (db && user) fetchMyCampaigns(db, user.id).then(setCampaigns); }, [db, user]);

  if (!configured) return <NoBackend feature="El perfil" />;
  if (!ready) return <Loading />;
  if (!user || !profile) return (
    <>
      <Intro kicker="Aquí también estás tú" title={<>Una cuenta.<br /><em>Muchas formas de vivirlo.</em></>} sub="Tu perfil de usuario y DJ, juntos. Tus salas y colectivos, por separado." />
      <NeedsLogin next="/perfil" />
    </>
  );

  async function onActivateDj() {
    if (!db) return;
    setBusy(true);
    try {
      await activateDj(db);
      await refreshEntities();
      toast('Perfil de DJ activado. Personalízalo a tu manera.');
      router.push('/perfil/editar#dj');
    } catch (e) { toast((e as Error).message); } finally { setBusy(false); }
  }

  async function toggleHidden(m: Mention) {
    if (!db || !djEntity) return;
    try {
      await setMentionHidden(db, m.event_id, djEntity.id, !m.hidden_by_artist);
      toast(m.hidden_by_artist ? 'Vuelve a verse en tu perfil' : 'Oculto en tu perfil. El evento sigue publicado.');
      await loadMentions();
    } catch (e) { toast((e as Error).message); }
  }

  async function createOrg(e: FormEvent<HTMLFormElement>) {
    e.preventDefault();
    if (!db) return;
    const f = new FormData(e.currentTarget);
    setBusy(true);
    setOrgError('');
    try {
      await createOrganization(db, {
        kind: f.get('kind') === 'venue' ? 'venue' : 'collective',
        name: String(f.get('name') ?? '').trim(),
        bio: String(f.get('bio') ?? '').trim() || undefined,
        municipality: String(f.get('municipality') ?? '').trim() || 'València',
      });
      const list = await refreshEntities();
      void list;
      setOrgOpen(false);
      toast('Perfil profesional creado. Completa sus datos en el panel.');
      router.push('/panel');
    } catch (err) { setOrgError((err as Error).message); } finally { setBusy(false); }
  }

  async function onExport() {
    if (!db) return;
    const data = await exportMyData(db);
    downloadFile('you-in-mis-datos.json', JSON.stringify(data, null, 2), 'application/json');
  }

  const orgs = entities.filter((e) => e.kind !== 'dj');
  const first = profile.display_name.split(' ')[0];
  return (
    <>
      <Intro kicker="Tu espacio" title={<>Hola, <em>{first}.</em></>} sub="Todo lo que te conecta con la escena de Valencia." />
      <div className="profile-layout">
        <section className="panel profile-hero">
          <Avatar p={{ name: profile.display_name, photo_path: profile.avatar_path, color: 'peach' }} />
          <h2>{profile.display_name}</h2>
          <div className="tags">
            <span className="tag">Usuario{djEntity ? ' + DJ' : ''}</span>
            {profile.is_demo && <span className="tag">Cuenta de prueba</span>}
          </div>
          <p>{profile.bio || 'Tu música, tus noches, tu gente.'}</p>
          <div className="actions">
            <Link className="secondary" href="/perfil/editar">Editar perfil</Link>
            {djEntity ? <Link className="secondary" href={`/p/${djEntity.slug}`}>Ver perfil DJ</Link> : (
              <button className="secondary" onClick={onActivateDj} disabled={busy}>Activar perfil DJ</button>
            )}
          </div>
          <hr className="divider" />
          <div className="list-row"><span>Eventos guardados</span><strong>{favorites.size}</strong></div>
          <div className="list-row"><span>Siguiendo</span><strong>{follows.size}</strong></div>
          <div className="list-row"><span>Comunidades</span><strong>{communities.filter((c) => c.is_member).length}</strong></div>
          <p className="help" style={{ marginTop: 12 }}>{profile.email} · tus datos se guardan en tu cuenta y se sincronizan entre dispositivos.</p>
          <div className="row">
            <button className="text-button" onClick={onExport}><Icon name="download" size={15} /> Exportar mis datos</button>
            <span className="spacer" />
            <button className="text-button" onClick={signOut}><Icon name="logout" size={15} /> Cerrar sesión</button>
          </div>
        </section>

        <div className="stack">
          <section className="panel">
            <div className="row"><h3 style={{ margin: 0 }}>Mis comunidades</h3><span className="spacer" /><Link className="text-button" href="/comunidades">Descubrir más <Icon name="arrow" size={14} /></Link></div>
            <p className="muted-small">Seguir un perfil no te une a su comunidad: entra en las que quieras.</p>
            <div className="my-communities" style={{ marginTop: 12 }}>
              {communities.length ? communities.map((c) => {
                const unread = Number(c.unread_chat) + Number(c.unread_announcements);
                return (
                  <Link key={c.community_id} className="my-community" href={`/comunidades/${c.slug}`}>
                    <span className="avatar lilac"><Icon name="people" size={18} /></span>
                    <span className="meta"><strong>{c.name}</strong><small>{c.is_admin ? 'Administras esta comunidad' : `De ${c.entity_name}`}</small></span>
                    {unread > 0 && <span className="tab-count">{unread} sin leer</span>}
                  </Link>
                );
              }) : <p className="muted">Aún no estás en ninguna comunidad.</p>}
            </div>
          </section>

          <section className="panel">
            <h3 style={{ marginTop: 0 }}>Recompensas</h3>
            {campaigns.length ? campaigns.map((c) => (
              <div key={c.id} className="list-row">
                <div><strong>{c.referral_campaigns?.name}</strong><p>{c.referral_campaigns?.communities?.name} · tu código {c.code}</p></div>
                <div className="row">
                  {c.referral_campaigns?.mode === 'simulation' && <span className="status-badge sim">Simulación</span>}
                  <Link className="pill" href={`/recompensas/${c.campaign_id}`}>Ver progreso</Link>
                </div>
              </div>
            )) : <p className="muted">Cuando una comunidad tenga una campaña de invitaciones, tu enlace personal y tu progreso aparecerán aquí. Prueba en <Link className="link" href="/comunidades/house-arena">House Arena (demo)</Link>.</p>}
          </section>

          <section className="panel">
            <h3 style={{ marginTop: 0 }}>Tus perfiles profesionales</h3>
            <p className="muted">Salas y colectivos son perfiles separados que pueden administrar varias personas.</p>
            {entities.map((e) => (
              <div key={e.id} className="list-row">
                <div><strong>{e.name}</strong><p>{KIND_LABEL[e.kind]} · {e.role === 'owner' ? 'Propietario/a' : 'Administrador/a'}</p></div>
                <Link className="pill" href={`/panel/${e.slug}`}>Gestionar</Link>
              </div>
            ))}
            <div className="actions">
              <button className="secondary" onClick={() => setOrgOpen(true)}><Icon name="plus" size={16} /> Añadir sala o colectivo</button>
              {!djEntity && <button className="secondary" onClick={onActivateDj} disabled={busy}>Activar perfil DJ</button>}
            </div>
            {orgs.length > 0 && <p className="help" style={{ marginTop: 14 }}>Las salas y colectivos publican eventos gratis desde el panel.</p>}
          </section>

          {djEntity && (
            <section className="panel">
              <h3 style={{ marginTop: 0 }}>Tu agenda como DJ</h3>
              <p className="help">Las menciones añaden automáticamente un evento a tu agenda. Tú decides si aparece en tu perfil; ocultarlo no borra el evento.</p>
              {mentions.length ? mentions.map((m) => {
                const ev = m.events!;
                const past = +new Date(ev.ends_at) < now;
                return (
                  <div key={m.event_id} className={`list-row agenda-row ${m.hidden_by_artist ? 'hidden-row' : ''}`}>
                    <div>
                      <Link href={`/eventos/${ev.id}`}><strong>{ev.title}</strong></Link>
                      <p>{m.hidden_by_artist ? 'Oculto en tu perfil' : 'Visible en tu perfil'} · {formatDay(ev.starts_at)} {formatHour(ev.starts_at)}{past ? ' · ya pasó' : ''}</p>
                    </div>
                    <button className="pill" onClick={() => toggleHidden(m)} aria-pressed={m.hidden_by_artist}>{m.hidden_by_artist ? 'Mostrar' : 'Ocultar'}</button>
                  </div>
                );
              }) : <p className="muted">Aún no tienes menciones. Cuando una sala o colectivo te mencione en un evento, aparecerá aquí.</p>}
            </section>
          )}
        </div>
      </div>

      <Modal open={orgOpen} onClose={() => setOrgOpen(false)} title="Un nuevo espacio en la escena">
        <p>Tu cuenta administrará este perfil profesional separado. Después podrás añadir a más personas al equipo.</p>
        <form onSubmit={createOrg}>
          <label>Nombre<input name="name" required maxLength={80} placeholder="Nombre de la sala o colectivo" /></label>
          <label>Tipo de perfil<select name="kind"><option value="venue">Sala / venue</option><option value="collective">Colectivo</option></select></label>
          <label>Municipio<input name="municipality" defaultValue="València" maxLength={80} /></label>
          <label>Descripción<textarea name="bio" maxLength={1500} placeholder="Cuéntanos qué os mueve" /></label>
          <p className="help">No puedes apropiarte de perfiles importados: si ya existe una referencia pública de tu sala, crea tu perfil y más adelante podrás solicitar la verificación.</p>
          <div className="form-error" role="alert">{orgError}</div>
          <button className="primary full" disabled={busy}>Crear perfil gratuito</button>
        </form>
      </Modal>
    </>
  );
}
