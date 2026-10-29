'use client';
import dynamic from 'next/dynamic';
import { useState, type FormEvent } from 'react';
import { useSession } from '@/components/providers/SessionProvider';
import { useToast } from '@/components/ui/Toast';
import { Avatar } from '@/components/ui/Avatar';
import { updateEntity, type EntityPatch } from '@/lib/data/entities';
import { mediaUrl, removeMedia, uploadMedia, validateMedia } from '@/lib/data/storage';
import { GENRES } from '@/lib/domain/events';
import type { EntityRow } from '@/lib/types';
import { profileStyle } from './ProfileView';

const PinPicker = dynamic(() => import('@/components/map/PinPicker').then((m) => m.PinPicker), { ssr: false });

const ACCENTS: [string, string][] = [['#765466', 'Ciruela'], ['#AF4529', 'Terracota'], ['#386B68', 'Petróleo'], ['#596597', 'Índigo'], ['#84652D', 'Miel tostada']];
const LINKS: [string, string][] = [['soundcloud', 'SoundCloud'], ['spotify', 'Spotify'], ['instagram', 'Instagram'], ['website', 'Web']];

/** Identidad y personalización de un perfil profesional (DJ, sala o colectivo). */
export function EntityForm({ entity, onSaved }: { entity: EntityRow; onSaved?: (e: EntityRow) => void }) {
  const { db, user } = useSession();
  const toast = useToast();
  const [busy, setBusy] = useState(false);
  const [error, setError] = useState('');
  const [accent, setAccent] = useState(entity.accent);
  const [font, setFont] = useState(entity.profile_font);
  const [name, setName] = useState(entity.name);
  const [lat, setLat] = useState<number | null>(entity.lat);
  const [lng, setLng] = useState<number | null>(entity.lng);
  const [previews, setPreviews] = useState<Record<string, string>>({});
  const links = (entity.links ?? {}) as Record<string, string>;
  const isVenue = entity.kind === 'venue';

  function preview(field: string, file: File | undefined) {
    if (!file) return;
    const problem = validateMedia(file, 'image');
    if (problem) { toast(problem); return; }
    setPreviews((p) => ({ ...p, [field]: URL.createObjectURL(file) }));
  }

  async function submit(e: FormEvent<HTMLFormElement>) {
    e.preventDefault();
    if (!db || !user) return;
    const f = new FormData(e.currentTarget);
    setBusy(true);
    setError('');
    const uploaded: string[] = [];
    try {
      const patch: EntityPatch = {
        name: String(f.get('name') ?? '').trim(),
        tagline: String(f.get('tagline') ?? '').trim() || null,
        bio: String(f.get('bio') ?? '').trim() || null,
        genres: f.getAll('genres').map(String),
        area: String(f.get('area') ?? '').trim() || null,
        municipality: String(f.get('municipality') ?? '').trim() || null,
        accent: String(f.get('accent')),
        profile_font: String(f.get('profile_font')),
        profile_layout: String(f.get('profile_layout')),
        contact_email: String(f.get('contact_email') ?? '').trim() || null,
        contact_phone: String(f.get('contact_phone') ?? '').trim() || null,
        links: Object.fromEntries(LINKS.map(([k]) => [k, String(f.get(k) ?? '').trim()]).filter(([, v]) => v)),
      };
      for (const [k, label] of LINKS) {
        const v = (patch.links as Record<string, string>)[k];
        if (v && !/^https:\/\//.test(v)) throw new Error(`El enlace de ${label} debe empezar por https://`);
      }
      if (isVenue) {
        patch.address = String(f.get('address') ?? '').trim() || null;
        patch.lat = lat;
        patch.lng = lng;
      }
      for (const field of ['photo', 'cover'] as const) {
        const file = f.get(field) as File | null;
        if (file && file.size) {
          const path = await uploadMedia(db, user.id, file, 'image', `entities/${entity.id}`);
          uploaded.push(path);
          patch[field === 'photo' ? 'photo_path' : 'cover_path'] = path;
        }
        if (f.get(`remove-${field}`) === 'on') patch[field === 'photo' ? 'photo_path' : 'cover_path'] = null;
      }
      await updateEntity(db, entity.id, patch);
      // Archivos sustituidos: se eliminan los antiguos que subió esta persona.
      if (patch.photo_path !== undefined && entity.photo_path && patch.photo_path !== entity.photo_path) await removeMedia(db, entity.photo_path);
      if (patch.cover_path !== undefined && entity.cover_path && patch.cover_path !== entity.cover_path) await removeMedia(db, entity.cover_path);
      toast('Perfil guardado');
      onSaved?.({ ...entity, ...patch } as EntityRow);
    } catch (err) {
      for (const p of uploaded) await removeMedia(db, p);
      setError((err as Error).message);
    } finally {
      setBusy(false);
    }
  }

  return (
    <form onSubmit={submit}>
      <label>{entity.kind === 'dj' ? 'Nombre artístico' : 'Nombre'}<input name="name" required maxLength={80} value={name} onChange={(e) => setName(e.target.value)} /></label>
      <label>Una frase que os represente<input name="tagline" maxLength={100} defaultValue={entity.tagline ?? ''} placeholder="El groove también se siente como casa" /></label>
      <label>Biografía<textarea name="bio" maxLength={1500} defaultValue={entity.bio ?? ''} /></label>
      <fieldset className="plain">
        <legend>Géneros</legend>
        <div className="row" style={{ marginBottom: 12 }}>
          {GENRES.filter((g) => g !== 'Sin clasificar').map((g) => (
            <label key={g} style={{ margin: 0, fontWeight: 400 }}><input type="checkbox" name="genres" value={g} defaultChecked={entity.genres.includes(g)} /> {g}</label>
          ))}
        </div>
      </fieldset>
      <div className="form-grid">
        <label>Municipio<input name="municipality" maxLength={80} defaultValue={entity.municipality ?? (isVenue ? 'València' : '')} /></label>
        <label>Barrio o zona<input name="area" maxLength={80} defaultValue={entity.area ?? ''} /></label>
      </div>
      {isVenue && (
        <fieldset className="plain">
          <legend>Ubicación de la sala</legend>
          <label>Dirección<input name="address" maxLength={200} defaultValue={entity.address ?? ''} placeholder="Calle y número" /></label>
          <PinPicker lat={lat} lng={lng} onChange={(a, b) => { setLat(a); setLng(b); }} />
          <p className="help">Una sala sin eventos en el periodo elegido conserva su perfil, pero no aparece como evento en el mapa.</p>
        </fieldset>
      )}

      <hr className="divider" />
      <h3>Que se vea y se sienta</h3>
      <div className="form-grid">
        <div>
          <label>Foto (JPG, PNG o WebP · máx. 6 MB)<input type="file" name="photo" accept="image/jpeg,image/png,image/webp" onChange={(e) => preview('photo', e.target.files?.[0])} /></label>
          {entity.photo_path && <label style={{ fontWeight: 400 }}><input type="checkbox" name="remove-photo" /> Quitar foto actual</label>}
        </div>
        <div>
          <label>Portada<input type="file" name="cover" accept="image/jpeg,image/png,image/webp" onChange={(e) => preview('cover', e.target.files?.[0])} /></label>
          {entity.cover_path && <label style={{ fontWeight: 400 }}><input type="checkbox" name="remove-cover" /> Quitar portada actual</label>}
        </div>
      </div>
      <div className="form-grid">
        <label>Color del perfil
          <select name="accent" value={accent} onChange={(e) => setAccent(e.target.value)}>
            {ACCENTS.map(([v, l]) => <option key={v} value={v}>{l}</option>)}
          </select>
        </label>
        <label>Tipografía
          <select name="profile_font" value={font} onChange={(e) => setFont(e.target.value)}>
            {['Manrope', 'DM Sans', 'Georgia'].map((v) => <option key={v}>{v}</option>)}
          </select>
        </label>
      </div>
      <label>Diseño
        <select name="profile_layout" defaultValue={entity.profile_layout}>
          <option value="editorial">Editorial · portada protagonista</option>
          <option value="compact">Compacto · directo al sonido</option>
        </select>
      </label>
      <div className="dj-style-preview dj-personalized" style={profileStyle({ accent, profile_font: font })} aria-label="Vista previa">
        <div className="dj-cover">
          {/* eslint-disable-next-line @next/next/no-img-element */}
          {previews.cover || mediaUrl(entity.cover_path) ? <img src={previews.cover || mediaUrl(entity.cover_path)} alt="" /> : <span>◌</span>}
        </div>
        {previews.photo ? (
          // eslint-disable-next-line @next/next/no-img-element
          <img className="avatar photo-avatar" src={previews.photo} alt="" />
        ) : <Avatar p={{ ...entity, name }} />}
        <h3>{name}</h3>
        <p>Tu música. Tu estilo.</p>
      </div>
      <h4>Enlaces</h4>
      {LINKS.map(([k, label]) => (
        <label key={k}>{label}<input type="url" name={k} maxLength={500} defaultValue={links[k] ?? ''} placeholder="https://…" /></label>
      ))}
      <div className="form-grid">
        <label>Email de contacto (público)<input type="email" name="contact_email" maxLength={100} defaultValue={entity.contact_email ?? ''} /></label>
        <label>Teléfono de contacto (público)<input type="tel" name="contact_phone" maxLength={30} defaultValue={entity.contact_phone ?? ''} /></label>
      </div>
      <p className="help">El email y el teléfono se muestran en el perfil público. Déjalos vacíos si no quieres publicarlos.</p>
      <div className="form-error" role="alert">{error}</div>
      <button className="primary full" disabled={busy}>{busy ? 'Guardando…' : 'Guardar perfil'}</button>
    </form>
  );
}
