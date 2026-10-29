'use client';
import Link from 'next/link';
import { useCallback, useEffect, useMemo, useRef, useState } from 'react';
import { useSession } from '@/components/providers/SessionProvider';
import { useDiscovery } from '@/components/providers/DiscoveryProvider';
import { useToast } from '@/components/ui/Toast';
import { Icon } from '@/components/ui/Icon';
import { Modal } from '@/components/ui/Modal';
import { Empty, Intro, Loading, NeedsLogin, NoBackend } from '@/components/ui/States';
import { EventCard } from '@/components/events/EventCard';
import { EventDetail } from '@/components/events/EventDetail';
import { ProfileCard } from '@/components/profiles/ExplorePage';
import { agendaEvents, favoriteSourceKeys, monthCells, sourceColor, eventsOnDay } from '@/lib/domain/calendar';
import { madridDateKey, formatHour } from '@/lib/domain/time';
import { updateMyProfile } from '@/lib/data/user';
import { EVENT_COLUMNS } from '@/lib/data/events';
import type { DiscoveryEvent } from '@/lib/types';

const WEEK = ['Lun', 'Mar', 'Mié', 'Jue', 'Vie', 'Sáb', 'Dom'];

export function FavoritesPage() {
  const { configured, ready, user, db, favorites, follows, profile, refreshProfile } = useSession();
  const { events, entityMap, entities, loading } = useDiscovery();
  const toast = useToast();
  const today = madridDateKey(new Date());
  const [year, setYear] = useState(Number(today.slice(0, 4)));
  const [month, setMonth] = useState(Number(today.slice(5, 7)) - 1);
  const [extra, setExtra] = useState<DiscoveryEvent[]>([]);
  const [detail, setDetail] = useState<DiscoveryEvent | null>(null);
  const [colors, setColors] = useState<Record<string, string>>({});
  const saveTimer = useRef<ReturnType<typeof setTimeout> | null>(null);

  useEffect(() => { setColors(profile?.favorite_colors ?? {}); }, [profile]);

  // Los colores se guardan en la cuenta con un pequeño retardo (el selector emite muchos cambios).
  const changeColor = useCallback((key: string, value: string) => {
    setColors((current) => {
      const next = { ...current, [key]: value };
      if (saveTimer.current) clearTimeout(saveTimer.current);
      saveTimer.current = setTimeout(async () => {
        if (!db || !user) return;
        try { await updateMyProfile(db, user.id, { favorite_colors: next }); await refreshProfile(); } catch (e) { toast((e as Error).message); }
      }, 600);
      return next;
    });
  }, [db, user, refreshProfile, toast]);

  // Favoritos que no están en la lista de próximos (p. ej. borradores no, pero sí eventos antiguos).
  useEffect(() => {
    if (!db || loading) return;
    const missing = [...favorites].filter((id) => !events.some((e) => e.id === id));
    if (!missing.length) { setExtra([]); return; }
    db.from('events').select(EVENT_COLUMNS).in('id', missing).then(({ data }) => setExtra((data ?? []) as unknown as DiscoveryEvent[]));
  }, [db, favorites, events, loading]);

  const all = useMemo(() => [...events, ...extra], [events, extra]);
  const agenda = useMemo(() => agendaEvents(all, favorites, follows), [all, favorites, follows]);
  const cells = useMemo(() => monthCells(year, month), [year, month]);
  const sources = useMemo(() => [...new Set(agenda.flatMap((e) => favoriteSourceKeys(e, follows)))], [agenda, follows]);
  const followed = entities.filter((p) => follows.has(p.id));
  const title = new Intl.DateTimeFormat('es-ES', { month: 'long', year: 'numeric', timeZone: 'UTC' }).format(new Date(Date.UTC(year, month, 15)));

  if (!configured) return <NoBackend feature="Los favoritos" />;
  if (!ready) return <Loading />;
  if (!user) return (
    <>
      <Intro kicker="Tu escena, mes a mes" title={<>La agenda de <em>tu gente.</em></>} sub="Guarda eventos y sigue perfiles: aquí se reúne todo." />
      <NeedsLogin next="/favoritos">Entra para guardar eventos y ver la agenda de los perfiles que sigues. Tus favoritos se sincronizan entre dispositivos.</NeedsLogin>
    </>
  );

  const step = (d: number) => {
    const m = month + d;
    setYear(year + Math.floor(m / 12));
    setMonth(((m % 12) + 12) % 12);
  };
  const label = (key: string) => key.startsWith('saved:') ? all.find((e) => e.id === key.slice(6))?.title ?? 'Evento guardado' : entityMap.get(key)?.name ?? 'Perfil seguido';

  return (
    <>
      <Intro kicker="Tu escena, mes a mes" title={<>La agenda de <em>tu gente.</em></>} sub="Todos los próximos eventos guardados y de los perfiles que sigues." />
      <section className="calendar-panel" aria-label="Calendario mensual de favoritos">
        <header className="calendar-toolbar">
          <div><span className="eyebrow">TU CALENDARIO</span><h2 aria-live="polite">{title}</h2></div>
          <div className="calendar-controls">
            <button className="iconbutton" onClick={() => step(-1)} aria-label="Mes anterior"><Icon name="back" size={17} /></button>
            <button className="pill" onClick={() => { setYear(Number(today.slice(0, 4))); setMonth(Number(today.slice(5, 7)) - 1); }}>Este mes</button>
            <input type="month" aria-label="Elegir mes" value={`${year}-${String(month + 1).padStart(2, '0')}`}
              onChange={(e) => { const [y, m] = e.target.value.split('-').map(Number); if (y && m) { setYear(y); setMonth(m - 1); } }} />
            <button className="iconbutton" onClick={() => step(1)} aria-label="Mes siguiente"><Icon name="arrow" size={17} /></button>
          </div>
        </header>
        <div className="calendar-scroll">
          <div className="calendar-week" aria-hidden="true">{WEEK.map((d) => <span key={d}>{d}</span>)}</div>
          <div className="calendar-grid">
            {cells.map((cell) => (
              <div key={cell.key} className={`calendar-day ${cell.inMonth ? '' : 'outside'} ${cell.key === today ? 'today' : ''}`}>
                <div className="calendar-day-number"><time dateTime={cell.key}>{cell.day}</time>{cell.key === today && <span>Hoy</span>}</div>
                {eventsOnDay(agenda, cell.key).map((e) => {
                  const keys = favoriteSourceKeys(e, follows);
                  const color = sourceColor(keys[0], colors);
                  return (
                    <button key={e.id} className="calendar-event" style={{ ['--event-color' as string]: color }} onClick={() => setDetail(e)} title={`${e.title} · ${formatHour(e.starts_at)}–${formatHour(e.ends_at)}`}>
                      <span className="calendar-event-time">{madridDateKey(e.starts_at) === cell.key ? formatHour(e.starts_at) : 'Hasta ' + formatHour(e.ends_at)}</span>
                      <strong>{e.title}</strong>
                      <span>{e.municipality || 'València'}</span>
                      <span className="calendar-event-dots">{keys.map((k) => <i key={k} style={{ background: sourceColor(k, colors) }} />)}</span>
                    </button>
                  );
                })}
              </div>
            ))}
          </div>
        </div>
        <div className="calendar-legend">
          {sources.length ? sources.map((key) => (
            <label key={key} className="calendar-color">
              <input type="color" value={sourceColor(key, colors)} onChange={(e) => changeColor(key, e.target.value)} aria-label={`Color de ${label(key)}`} />
              <span>{label(key)}</span>
            </label>
          )) : <p>Guarda un evento o sigue un perfil para empezar. Los colores se pueden personalizar.</p>}
        </div>
        <p className="calendar-help">Hora de Madrid · 24 h · un evento nocturno aparece también en el día en que termina. Los colores se guardan en tu cuenta.</p>
      </section>

      <div className="section-head"><h2>Próximos encuentros</h2><span className="tag">{agenda.length} eventos · sin duplicados</span></div>
      {agenda.length ? (
        <div className="large-card-grid">{agenda.map((e) => <EventCard key={e.id} event={e} entityMap={entityMap} onOpen={(id) => setDetail(all.find((x) => x.id === id) ?? null)} />)}</div>
      ) : (
        <Empty title="El mes está por escribir" icon="heart" action={<Link className="secondary" href="/">Explorar eventos</Link>}>
          Guarda eventos o sigue DJs, salas y colectivos. Su programación futura se reunirá aquí.
        </Empty>
      )}
      <div className="section-head"><h2>Tu escena</h2><span className="tag">Siguiendo {follows.size}</span></div>
      {followed.length ? <div className="profiles-grid">{followed.map((p) => <ProfileCard key={p.id} p={p} />)}</div> : (
        <p className="muted">Aún no sigues a nadie. <Link className="link" href="/explorar">Descubre perfiles</Link>.</p>
      )}
      <Modal open={Boolean(detail)} onClose={() => setDetail(null)} title="Tu próximo encuentro">
        {detail && <EventDetail event={detail} entityMap={entityMap} />}
      </Modal>
    </>
  );
}
