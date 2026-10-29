'use client';
import Link from 'next/link';
import { useEffect, useState, type FormEvent } from 'react';
import { useSession } from '@/components/providers/SessionProvider';
import { useToast } from '@/components/ui/Toast';
import { Icon } from '@/components/ui/Icon';
import { Intro, Loading, NeedsLogin, NoBackend } from '@/components/ui/States';
import { updateMyProfile, activateDj } from '@/lib/data/user';
import { fetchEntityById } from '@/lib/data/entities';
import { removeMedia, uploadMedia } from '@/lib/data/storage';
import type { EntityRow } from '@/lib/types';
import { EntityForm } from './EntityForm';

export function EditProfilePage() {
  const { configured, ready, user, profile, db, djEntity, refreshProfile, refreshEntities } = useSession();
  const toast = useToast();
  const [dj, setDj] = useState<EntityRow | null>(null);
  const [busy, setBusy] = useState(false);
  const [error, setError] = useState('');

  useEffect(() => {
    if (db && djEntity) fetchEntityById(db, djEntity.id).then(setDj);
  }, [db, djEntity]);

  if (!configured) return <NoBackend feature="El perfil" />;
  if (!ready) return <Loading />;
  if (!user || !profile) return <NeedsLogin next="/perfil/editar" />;

  async function saveUser(e: FormEvent<HTMLFormElement>) {
    e.preventDefault();
    if (!db || !user || !profile) return;
    const f = new FormData(e.currentTarget);
    setBusy(true);
    setError('');
    try {
      let avatar_path = profile.avatar_path;
      const file = f.get('avatar') as File | null;
      if (file && file.size) avatar_path = await uploadMedia(db, user.id, file, 'image', 'avatar');
      if (f.get('remove-avatar') === 'on') avatar_path = null;
      await updateMyProfile(db, user.id, {
        display_name: String(f.get('display_name') ?? '').trim(),
        bio: String(f.get('bio') ?? '').trim() || null,
        avatar_path,
      });
      if (avatar_path !== profile.avatar_path) await removeMedia(db, profile.avatar_path);
      await refreshProfile();
      toast('Perfil guardado');
    } catch (err) {
      setError((err as Error).message);
    } finally {
      setBusy(false);
    }
  }

  return (
    <>
      <Intro kicker="Tu perfil" title={<>A tu <em>manera.</em></>} sub="Tu perfil de usuario y, si quieres, tu identidad como DJ."
        extra={<Link className="secondary" href="/perfil"><Icon name="back" size={16} /> Volver</Link>} />
      <div className="profile-layout">
        <section className="panel">
          <h3 style={{ marginTop: 0 }}>Tu cuenta</h3>
          <form onSubmit={saveUser}>
            <label>Tu nombre o alias<input name="display_name" required maxLength={50} defaultValue={profile.display_name} /></label>
            <label>Sobre ti<textarea name="bio" maxLength={600} defaultValue={profile.bio ?? ''} /></label>
            <label>Foto de perfil<input type="file" name="avatar" accept="image/jpeg,image/png,image/webp" /></label>
            {profile.avatar_path && <label style={{ fontWeight: 400 }}><input type="checkbox" name="remove-avatar" /> Quitar foto actual</label>}
            <p className="help">Tu nombre y tu foto se muestran junto a tus mensajes en las comunidades.</p>
            <div className="form-error" role="alert">{error}</div>
            <button className="primary full" disabled={busy}>{busy ? 'Guardando…' : 'Guardar'}</button>
          </form>
        </section>
        <section className="panel" id="dj">
          <h3 style={{ marginTop: 0 }}>Tu identidad como DJ</h3>
          {!djEntity ? (
            <>
              <p className="muted">Activa tu perfil de DJ en esta misma cuenta para tener página propia, agenda con tus menciones y comunidad.</p>
              <button className="primary" onClick={async () => {
                if (!db) return;
                try { await activateDj(db); await refreshEntities(); toast('Perfil de DJ activado'); } catch (e) { toast((e as Error).message); }
              }}>Activar perfil DJ</button>
            </>
          ) : !dj ? <Loading /> : (
            <>
              <p className="help">Se muestra en <Link className="link" href={`/p/${dj.slug}`}>tu página de DJ</Link>. Solo tú puedes editarla.</p>
              <EntityForm entity={dj} onSaved={(e) => { setDj(e); void refreshEntities(); }} />
            </>
          )}
        </section>
      </div>
    </>
  );
}
