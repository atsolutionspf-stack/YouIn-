'use client';
import dynamic from 'next/dynamic';
import { useMemo, useState, type FormEvent } from 'react';
import { useSession } from '@/components/providers/SessionProvider';
import { useDiscovery } from '@/components/providers/DiscoveryProvider';
import { useToast } from '@/components/ui/Toast';
import { createEvent, fetchEvent, updateEvent } from '@/lib/data/events';
import { removeMedia, uploadMedia, validateMedia } from '@/lib/data/storage';
import { GENRES, normalize } from '@/lib/domain/events';
import { validateEventForm, type EventFormValues } from '@/lib/domain/eventForm';
import { addDaysKey, madridDateKey, madridLocalInput } from '@/lib/domain/time';
import type { DiscoveryEvent, EntityRow } from '@/lib/types';

const PinPicker = dynamic(() => import('@/components/map/PinPicker').then((m) => m.PinPicker), { ssr: false });

type Props = { organizer: EntityRow; event?: DiscoveryEvent | null; onDone: () => void };

export function EventForm({ organizer, event, onDone }: Props) {
  const { db, user } = useSession();
  const { entities, upsertEvent } = useDiscovery();
  const toast = useToast();
  const tomorrow = addDaysKey(madridDateKey(new Date()), 1);
  const start = event ? madridLocalInput(event.starts_at) : `${tomorrow}T23:00`;
  const end = event ? madridLocalInput(event.ends_at) : `${addDaysKey(tomorrow, 1)}T06:00`;
  const ownVenue = organizer.kind === 'venue' ? organizer : null;
  const [venueId, setVenueId] = useState(event?.venue_entity_id ?? ownVenue?.id ?? '');
  const [venueName, setVenueName] = useState(event?.venue_name ?? ownVenue?.name ?? '');
  const [address, setAddress] = useState(event?.address ?? ownVenue?.address ?? '');
  const [municipality, setMunicipality] = useState(event?.municipality ?? ownVenue?.municipality ?? 'València');
  const [area, setArea] = useState(event?.area ?? ownVenue?.area ?? '');
  const [lat, setLat] = useState<number | null>(event ? event.lat : ownVenue?.lat ?? null);
  const [lng, setLng] = useState<number | null>(event ? event.lng : ownVenue?.lng ?? null);
  const [priceKind, setPriceKind] = useState<EventFormValues['priceKind']>(event?.price_kind ?? 'fixed');
  const [djs, setDjs] = useState<string[]>(event?.event_artists.map((a) => a.entity_id) ?? []);
  const [djQuery, setDjQuery] = useState('');
  const [errors, setErrors] = useState<Record<string, string>>({});
  const [busy, setBusy] = useState(false);

  const venues = useMemo(() => entities.filter((e) => e.kind === 'venue').sort((a, b) => a.name.localeCompare(b.name, 'es')), [entities]);
  const djOptions = useMemo(() => {
    const q = normalize(djQuery);
    return entities.filter((e) => e.kind === 'dj' && (djs.includes(e.id) || !q || normalize(e.name).includes(q))).slice(0, 60);
  }, [entities, djQuery, djs]);

  async function pickVenue(id: string) {
    setVenueId(id);
    if (!id || !db) return;
    // Se copian las coordenadas publicadas de la sala (no se inventan).
    const { data } = await db.from('entities').select('name, address, municipality, area, lat, lng').eq('id', id).single();
    if (data) {
      setVenueName(data.name);
      if (data.address) setAddress(data.address);
      if (data.municipality) setMunicipality(data.municipality);
      if (data.area) setArea(data.area);
      if (data.lat !== null && data.lng !== null) { setLat(data.lat); setLng(data.lng); }
    }
  }

  async function submit(e: FormEvent<HTMLFormElement>) {
    e.preventDefault();
    if (!db || !user) return;
    const f = new FormData(e.currentTarget);
    const values: EventFormValues = {
      title: String(f.get('title') ?? ''), description: String(f.get('description') ?? ''), venueEntityId: venueId, venueName, address,
      municipality, province: String(f.get('province') ?? 'Valencia'), area, lat, lng,
      startDate: String(f.get('startDate')), startTime: String(f.get('startTime')), endDate: String(f.get('endDate')), endTime: String(f.get('endTime')),
      genre: String(f.get('genre')), priceKind, price: String(f.get('price') ?? ''), priceNote: String(f.get('priceNote') ?? ''),
      ticketUrl: String(f.get('ticketUrl') ?? ''), posterStyle: String(f.get('posterStyle') ?? 'groove'), age: String(f.get('age') ?? ''),
      status: String(f.get('status')) as EventFormValues['status'],
    };
    const result = validateEventForm(values);
    if (!result.ok) { setErrors(result.errors); toast('Revisa los campos marcados'); return; }
    setErrors({});
    setBusy(true);
    const uploaded: string[] = [];
    try {
      const poster = f.get('poster') as File | null;
      const video = f.get('video') as File | null;
      let poster_path = event?.poster_path ?? null;
      let video_path = event?.video_path ?? null;
      if (poster && poster.size) { poster_path = await uploadMedia(db, user.id, poster, 'image', 'posters'); uploaded.push(poster_path); }
      if (video && video.size) { video_path = await uploadMedia(db, user.id, video, 'video', 'videos'); uploaded.push(video_path); }
      if (f.get('remove-poster') === 'on') poster_path = null;
      if (f.get('remove-video') === 'on') video_path = null;
      const input = { ...result.input, poster_path, video_path };
      let id = event?.id;
      if (event) await updateEvent(db, event.id, input, djs, event.event_artists.map((a) => a.entity_id));
      else id = await createEvent(db, organizer.id, user.id, input, djs);
      if (event?.poster_path && event.poster_path !== poster_path) await removeMedia(db, event.poster_path);
      if (event?.video_path && event.video_path !== video_path) await removeMedia(db, event.video_path);
      const fresh = await fetchEvent(db, id!);
      if (fresh && fresh.status === 'published') upsertEvent(fresh);
      toast(event ? 'Evento guardado' : input.status === 'published' ? 'Evento publicado: ya aparece en el mapa y la lista' : 'Borrador guardado');
      onDone();
    } catch (err) {
      for (const p of uploaded) await removeMedia(db, p);
      toast((err as Error).message);
      setErrors({ form: (err as Error).message });
    } finally {
      setBusy(false);
    }
  }

  const err = (k: string) => errors[k] && <div className="form-error" role="alert">{errors[k]}</div>;

  return (
    <form onSubmit={submit} noValidate>
      <div className="notice">Como <strong>{organizer.name}</strong> · horarios de Madrid en 24 h · publicación gratuita.</div>
      <label style={{ marginTop: 18 }}>Nombre del evento<input name="title" required maxLength={120} defaultValue={event?.title ?? ''} placeholder="La próxima noche empieza aquí" /></label>
      {err('title')}
      <label>Descripción<textarea name="description" maxLength={2000} defaultValue={event?.description ?? ''} /></label>

      <fieldset className="datetime-group">
        <legend>Empieza · 24 h</legend>
        <div className="form-grid">
          <label>Fecha<input type="date" name="startDate" required defaultValue={start.slice(0, 10)} /></label>
          <label>Hora<input type="time" name="startTime" required defaultValue={start.slice(11, 16)} /></label>
        </div>
      </fieldset>
      {err('start')}
      <fieldset className="datetime-group">
        <legend>Termina · 24 h</legend>
        <div className="form-grid">
          <label>Fecha<input type="date" name="endDate" required defaultValue={end.slice(0, 10)} /></label>
          <label>Hora<input type="time" name="endTime" required defaultValue={end.slice(11, 16)} /></label>
        </div>
        <p className="help">Si la fiesta acaba de madrugada, elige el día siguiente.</p>
      </fieldset>
      {err('end')}

      <fieldset className="plain">
        <legend>Dónde</legend>
        <label>Sala registrada (opcional)
          <select value={venueId} onChange={(e) => pickVenue(e.target.value)}>
            <option value="">Otro espacio (escribe el nombre)</option>
            {venues.map((v) => <option key={v.id} value={v.id}>{v.name}{v.data_origin === 'imported' ? ' · referencia' : v.data_origin === 'demo' ? ' · demo' : ''}</option>)}
          </select>
        </label>
        <label>Nombre del espacio<input value={venueName} onChange={(e) => setVenueName(e.target.value)} required maxLength={120} /></label>
        {err('venueName')}
        <label>Dirección<input value={address} onChange={(e) => setAddress(e.target.value)} required maxLength={200} placeholder="Calle y número" /></label>
        {err('address')}
        <div className="form-grid">
          <label>Municipio<input value={municipality} onChange={(e) => setMunicipality(e.target.value)} required maxLength={80} /></label>
          <label>Provincia
            <select name="province" defaultValue={event?.province ?? 'Valencia'}>
              {['Valencia', 'Alicante', 'Castellón'].map((p) => <option key={p}>{p}</option>)}
            </select>
          </label>
        </div>
        <label>Barrio o zona<input value={area} onChange={(e) => setArea(e.target.value)} maxLength={80} /></label>
        <PinPicker lat={lat} lng={lng} onChange={(a, b) => { setLat(a); setLng(b); }} />
        {err('location')}
        {lat === null && <p className="help">Sin ubicación fijada, el evento aparecerá en la lista pero no en el mapa.</p>}
      </fieldset>

      <div className="form-grid">
        <label>Género
          <select name="genre" defaultValue={event?.genre ?? 'House'}>{GENRES.map((g) => <option key={g}>{g}</option>)}</select>
        </label>
        <label>Edad mínima (opcional)<input name="age" maxLength={10} defaultValue={event?.age ?? ''} placeholder="18+" /></label>
      </div>
      <div className="form-grid">
        <label>Tipo de precio
          <select value={priceKind} onChange={(e) => setPriceKind(e.target.value as EventFormValues['priceKind'])}>
            <option value="fixed">Precio fijo</option>
            <option value="from">Desde</option>
            <option value="conditional-free">Lista gratuita con condiciones</option>
            <option value="unknown">Sin precio publicado («Consultar»)</option>
          </select>
        </label>
        <label>Precio (€)<input name="price" inputMode="decimal" disabled={priceKind === 'unknown' || priceKind === 'conditional-free'} defaultValue={event?.price ?? '0'} /></label>
      </div>
      {err('price')}
      <label>Nota sobre el precio (opcional)<input name="priceNote" maxLength={120} defaultValue={event?.price_note ?? ''} placeholder="Anticipada, taquilla…" /></label>
      <label>Enlace al vendedor de entradas (opcional)<input name="ticketUrl" type="url" maxLength={500} defaultValue={event?.ticket_url ?? ''} placeholder="https://…" /></label>
      {err('ticketUrl')}
      <p className="help">YOU IN? no vende entradas: el enlace lleva al vendedor. Abrirlo no cuenta como entrada vendida.</p>

      <fieldset className="plain">
        <legend>Menciona DJs (se añade a su agenda; podrán ocultarlo de su perfil)</legend>
        <input aria-label="Buscar DJ" placeholder="Buscar DJ…" value={djQuery} onChange={(e) => setDjQuery(e.target.value)} style={{ width: '100%', marginBottom: 8, border: '1px solid var(--line)', borderRadius: 10, padding: 10, background: '#fffdf9' }} />
        <div className="check-list">
          {djOptions.map((d) => (
            <label key={d.id}>
              <input type="checkbox" checked={djs.includes(d.id)} onChange={(e) => setDjs((list) => e.target.checked ? [...list, d.id] : list.filter((x) => x !== d.id))} />
              {' '}{d.name}{d.data_origin === 'imported' ? ' · referencia' : d.data_origin === 'demo' ? ' · demo' : ''}
            </label>
          ))}
          {!djOptions.length && <span className="muted-small">Sin resultados.</span>}
        </div>
      </fieldset>

      <h3>Que se vea y se sienta</h3>
      <label>Cartel (JPG, PNG o WebP · máx. 6 MB)<input type="file" name="poster" accept="image/jpeg,image/png,image/webp" onChange={(e) => { const p = e.target.files?.[0] && validateMedia(e.target.files[0], 'image'); if (p) toast(p); }} /></label>
      {event?.poster_path && <label style={{ fontWeight: 400 }}><input type="checkbox" name="remove-poster" /> Quitar cartel actual</label>}
      <label>Vídeo promocional (MP4 o WebM · máx. 40 MB)<input type="file" name="video" accept="video/mp4,video/webm" onChange={(e) => { const p = e.target.files?.[0] && validateMedia(e.target.files[0], 'video'); if (p) toast(p); }} /></label>
      {event?.video_path && <label style={{ fontWeight: 400 }}><input type="checkbox" name="remove-video" /> Quitar vídeo actual</label>}
      <label>Cartel de reserva (si no subes uno)
        <select name="posterStyle" defaultValue={event?.poster_style ?? 'groove'}>
          <option value="groove">Terracota · groove</option><option value="orbita">Ciruela · órbita</option>
          <option value="sol">Melocotón · sol</option><option value="onda">Lila · onda</option>
        </select>
      </label>
      <label>Estado
        <select name="status" defaultValue={event?.status ?? 'published'}>
          <option value="published">Publicado (visible en mapa y lista)</option>
          <option value="draft">Borrador (solo lo ve el equipo)</option>
          <option value="cancelled">Cancelado (se muestra como cancelado)</option>
        </select>
      </label>
      {err('form')}
      <div className="row" style={{ marginTop: 10 }}>
        <button className="primary" disabled={busy}>{busy ? 'Guardando…' : event ? 'Guardar cambios' : 'Publicar evento gratis'}</button>
        <button type="button" className="secondary" onClick={onDone}>Cancelar</button>
      </div>
    </form>
  );
}
