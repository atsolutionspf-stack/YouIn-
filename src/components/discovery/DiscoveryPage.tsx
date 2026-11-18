'use client';
import dynamic from 'next/dynamic';
import Link from 'next/link';
import { useCallback, useEffect, useMemo, useRef, useState } from 'react';
import { usePathname, useRouter, useSearchParams } from 'next/navigation';
import { useDiscovery } from '@/components/providers/DiscoveryProvider';
import { useToast } from '@/components/ui/Toast';
import { Empty, ErrorState, Intro } from '@/components/ui/States';
import { Icon } from '@/components/ui/Icon';
import { Modal } from '@/components/ui/Modal';
import { EventCard } from '@/components/events/EventCard';
import { EventDetail } from '@/components/events/EventDetail';
import { Poster } from '@/components/events/Poster';
import { ProvenanceBar } from './ProvenanceBar';
import { FiltersModal } from './FiltersModal';
import type { MapHandle } from '@/components/map/EventMap';
import {
  DEFAULT_FILTERS, GENRES, PRICE_OPTIONS, VALENCIA_CENTER, filterEvents, formatPrice, groupByLocation, locationOptions,
  type EventFilters, type PriceFilter,
} from '@/lib/domain/events';
import { formatDay, formatHour, type DatePreset } from '@/lib/domain/time';
import { MAP_TILES_ARE_DEFAULT_OSM } from '@/lib/config';

const EventMap = dynamic(() => import('@/components/map/EventMap').then((m) => m.EventMap), {
  ssr: false,
  loading: () => <div className="map-fallback">Cargando mapa…</div>,
});

const PAGE = 12;
const DATE_CHIPS: [DatePreset, string][] = [['all', 'Próximos'], ['now', 'Ahora'], ['today', 'Hoy'], ['tomorrow', 'Mañana'], ['weekend', 'Este finde']];

function filtersFromParams(p: URLSearchParams): EventFilters {
  const date = (['all', 'now', 'today', 'tomorrow', 'weekend', 'custom'].includes(p.get('fecha') ?? '') ? p.get('fecha') : 'all') as DatePreset;
  const price = (PRICE_OPTIONS.some((o) => o.value === p.get('precio')) ? p.get('precio') : 'any') as PriceFilter;
  return {
    ...DEFAULT_FILTERS,
    origin: p.get('origen') === 'demo' ? 'demo' : 'published',
    date,
    dateFrom: p.get('desde') ?? undefined,
    dateTo: p.get('hasta') ?? undefined,
    genre: p.get('genero') ?? 'Todos',
    query: p.get('q') ?? '',
    price,
    includeUnknownPrice: p.get('consultar') !== '0',
    municipality: p.get('municipio') ?? '',
    area: p.get('zona') ?? '',
  };
}

function paramsFromFilters(f: EventFilters, selected: string | null): string {
  const p = new URLSearchParams();
  if (f.origin === 'demo') p.set('origen', 'demo');
  if (f.date !== 'all') p.set('fecha', f.date);
  if (f.date === 'custom' && f.dateFrom) { p.set('desde', f.dateFrom); if (f.dateTo) p.set('hasta', f.dateTo); }
  if (f.genre !== 'Todos') p.set('genero', f.genre);
  if (f.query) p.set('q', f.query);
  if (f.price !== 'any') p.set('precio', f.price);
  if (!f.includeUnknownPrice) p.set('consultar', '0');
  if (f.municipality) p.set('municipio', f.municipality);
  if (f.area) p.set('zona', f.area);
  if (selected) p.set('evento', selected);
  const s = p.toString();
  return s ? `?${s}` : '';
}

export function DiscoveryPage() {
  const { events, entityMap, loading, error, reload, offline } = useDiscovery();
  const toast = useToast();
  const router = useRouter();
  const pathname = usePathname();
  const params = useSearchParams();
  const [filters, setFilters] = useState<EventFilters>(() => filtersFromParams(params));
  const [selectedId, setSelectedId] = useState<string | null>(params.get('evento'));
  const [detailId, setDetailId] = useState<string | null>(null);
  const [limit, setLimit] = useState(PAGE);
  const [filtersOpen, setFiltersOpen] = useState(false);
  const [geoMessage, setGeoMessage] = useState('');
  const [locating, setLocating] = useState(false);
  const [userLocation, setUserLocation] = useState<{ lat: number; lng: number } | null>(null);
  const [mapFailure, setMapFailure] = useState<'init' | 'tiles' | null>(null);
  const [mobileView, setMobileView] = useState<'map' | 'list'>('map');
  const mapRef = useRef<MapHandle>(null);
  const cardRefs = useRef(new Map<string, HTMLElement>());

  const filtered = useMemo(() => filterEvents(events, filters, entityMap), [events, filters, entityMap]);
  const groups = useMemo(() => groupByLocation(filtered), [filtered]);
  const locations = useMemo(() => locationOptions(events.filter((e) => (filters.origin === 'demo') === (e.data_origin === 'demo'))), [events, filters.origin]);
  const importedCount = useMemo(() => events.filter((e) => e.data_origin === 'imported').length, [events]);
  const groupOf = useMemo(() => {
    const m = new Map<string, string>();
    groups.forEach((g) => g.events.forEach((e) => m.set(e.id, g.key)));
    return m;
  }, [groups]);

  const selected = filtered.find((e) => e.id === selectedId) ?? null;
  const selectedGroup = selected ? groups.find((g) => g.key === groupOf.get(selected.id)) : undefined;

  // URL compartible con los filtros.
  useEffect(() => {
    const qs = paramsFromFilters(filters, selectedId);
    if (qs !== (params.toString() ? `?${params.toString()}` : '')) router.replace(`${pathname}${qs}`, { scroll: false });
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [filters, selectedId]);

  // Si llega ?evento=… desde "Ver en mapa", centrar.
  useEffect(() => {
    const id = params.get('evento');
    if (!id || loading) return;
    const e = events.find((x) => x.id === id);
    if (e?.lat != null && e.lng != null) {
      setMobileView('map');
      setTimeout(() => mapRef.current?.flyTo(e.lat!, e.lng!, 15), 300);
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [loading]);

  const update = useCallback((patch: Partial<EventFilters>) => {
    setFilters((f) => ({ ...f, ...patch }));
    setLimit(PAGE);
  }, []);

  function selectEvent(id: string, opts: { pan?: boolean; scroll?: boolean } = {}) {
    setSelectedId(id);
    const e = filtered.find((x) => x.id === id);
    if (opts.pan && e?.lat != null && e.lng != null) mapRef.current?.flyTo(e.lat, e.lng);
    if (opts.scroll) {
      const idx = filtered.findIndex((x) => x.id === id);
      if (idx >= limit) setLimit(Math.ceil((idx + 1) / PAGE) * PAGE);
      setTimeout(() => cardRefs.current.get(id)?.scrollIntoView({ behavior: 'smooth', block: 'nearest' }), 50);
    }
  }

  function onSelectGroup(key: string) {
    const g = groups.find((x) => x.key === key);
    if (!g) return;
    selectEvent(g.events[0].id, { scroll: true });
  }

  function nearMe() {
    if (filters.near) { update({ near: null }); setUserLocation(null); return; }
    if (!('geolocation' in navigator)) {
      setGeoMessage('Tu navegador no permite la ubicación. Elige un municipio o barrio.');
      setFiltersOpen(true);
      return;
    }
    setLocating(true);
    navigator.geolocation.getCurrentPosition(
      (pos) => {
        setLocating(false);
        const loc = { lat: pos.coords.latitude, lng: pos.coords.longitude };
        setUserLocation(loc);
        update({ near: { ...loc, radiusKm: 10 } });
        mapRef.current?.flyTo(loc.lat, loc.lng, 12);
        toast('Mostrando eventos a menos de 10 km. Tu ubicación no se guarda.');
      },
      (err) => {
        setLocating(false);
        setGeoMessage(err.code === err.PERMISSION_DENIED
          ? 'No has permitido la ubicación. Sin problema: elige un municipio o barrio para ver lo que hay cerca.'
          : 'No hemos podido obtener tu ubicación. Elige un municipio o barrio.');
        setFiltersOpen(true);
      },
      { enableHighAccuracy: false, timeout: 10000, maximumAge: 300000 },
    );
  }

  const activeExtra = [
    filters.genre !== 'Todos' && { key: 'genre', label: filters.genre, clear: { genre: 'Todos' } },
    filters.origin === 'demo' && { key: 'origin', label: 'Demo', clear: { origin: 'published' as const } },
    filters.municipality && { key: 'municipality', label: filters.municipality, clear: { municipality: '', area: '' } },
    filters.area && { key: 'area', label: filters.area, clear: { area: '' } },
    filters.price !== 'any' && { key: 'price', label: PRICE_OPTIONS.find((o) => o.value === filters.price)!.label, clear: { price: 'any' as PriceFilter } },
    !filters.includeUnknownPrice && { key: 'unknown', label: 'Sin «Consultar»', clear: { includeUnknownPrice: true } },
    filters.date === 'custom' && { key: 'date', label: `${filters.dateFrom}${filters.dateTo && filters.dateTo !== filters.dateFrom ? ' → ' + filters.dateTo : ''}`, clear: { date: 'all' as DatePreset, dateFrom: undefined, dateTo: undefined } },
    filters.near && { key: 'near', label: `A menos de ${filters.near.radiusKm} km`, clear: { near: null } },
  ].filter(Boolean) as { key: string; label: string; clear: Partial<EventFilters> }[];

  const detailEvent = detailId ? events.find((e) => e.id === detailId) : null;
  const periodLabel = { all: 'por descubrir', now: 'en curso', today: 'hoy', tomorrow: 'mañana', weekend: 'este finde', custom: 'en esas fechas' }[filters.date];

  return (
    <>
      <Intro
        compactOnMobile
        kicker={filters.origin === 'demo' ? 'Comunitat Valenciana · Demo' : 'Valencia y alrededores'}
        title={<>La música te encuentra.<br /><em>La noche es tuya.</em></>}
        sub="Descubre dónde suena lo tuyo y con quién compartirlo."
      />
      <ProvenanceBar origin={filters.origin} onChange={(origin) => { update({ origin, municipality: '', area: '' }); setSelectedId(null); }} importedCount={importedCount} />
      <p className="source-line">
        {filters.origin === 'demo'
          ? <>Viendo eventos de demostración (ficticios). <button className="text-button link" onClick={() => update({ origin: 'published', municipality: '', area: '' })}>Ver eventos reales</button></>
          : <>{importedCount} eventos anunciados · datos del 19/10 · <Link className="link" href="/acerca#fuentes">Ver fuentes</Link></>}
      </p>

      <div className="toolbar">
        <div className="searchbox">
          <Icon name="search" size={18} />
          <input
            type="search" value={filters.query} onChange={(e) => update({ query: e.target.value })}
            placeholder="Busca fiesta, DJ o sala…" aria-label="Buscar por evento, sala, DJ o colectivo" autoComplete="off"
          />
        </div>
        <button className={`pill near-btn desktop-only ${filters.near ? 'active' : ''}`} onClick={nearMe} disabled={locating} aria-pressed={Boolean(filters.near)}>
          <Icon name="target" size={16} /> {locating ? 'Buscando…' : filters.near ? 'Cerca de mí ✕' : 'Cerca de mí'}
        </button>
        <button className="pill filter-btn" onClick={() => { setGeoMessage(''); setFiltersOpen(true); }} aria-label={`Filtros${activeExtra.length ? ` (${activeExtra.length} activos)` : ''}`}>
          <Icon name="filter" size={16} /> <span className="filter-label">Filtros</span>
          {activeExtra.length > 0 && <span className="filter-count">{activeExtra.length}</span>}
        </button>
      </div>
      <div className="quick-dates" role="group" aria-label="Cuándo y dónde">
        <button className={`chip mobile-only ${filters.near ? 'near-on' : ''}`} aria-pressed={Boolean(filters.near)} onClick={nearMe} disabled={locating}>
          <Icon name="target" size={13} /> {locating ? 'Buscando…' : 'Cerca de mí'}
        </button>
        {DATE_CHIPS.map(([value, label]) => (
          <button key={value} className="chip" aria-pressed={filters.date === value} onClick={() => update({ date: value, dateFrom: undefined, dateTo: undefined })}>{label}</button>
        ))}
        <button className="chip desktop-only" aria-pressed={filters.date === 'custom'} onClick={() => { setGeoMessage(''); setFiltersOpen(true); }}>
          <Icon name="calendar" size={13} /> Elegir fechas
        </button>
      </div>
      <div className="chips desktop-only" role="group" aria-label="Género musical">
        {['Todos', ...GENRES].map((g) => (
          <button key={g} className={`chip ${filters.genre === g ? 'active' : ''}`} aria-pressed={filters.genre === g} onClick={() => update({ genre: g })}>{g}</button>
        ))}
      </div>
      {activeExtra.length > 0 && (
        <div className="filter-summary">
          {activeExtra.map((x) => (
            <span key={x.key} className="tag">{x.label} <button onClick={() => update(x.clear)} aria-label={`Quitar filtro ${x.label}`}><Icon name="close" size={11} /></button></span>
          ))}
          <button className="text-button" style={{ fontSize: 11 }} onClick={() => { update({ ...DEFAULT_FILTERS, origin: filters.origin }); setUserLocation(null); }}>Limpiar todo</button>
        </div>
      )}

      <div className="view-toggle">
        <div className="segmented" role="group" aria-label="Vista">
          <button className={mobileView === 'map' ? 'active' : ''} aria-pressed={mobileView === 'map'} onClick={() => setMobileView('map')}><Icon name="map" size={14} /> Mapa</button>
          <button className={mobileView === 'list' ? 'active' : ''} aria-pressed={mobileView === 'list'} onClick={() => setMobileView('list')}><Icon name="list" size={14} /> Lista ({filtered.length})</button>
        </div>
      </div>

      {error ? <ErrorState message={error} onRetry={reload} /> : (
        <div className={`explore-grid mode-${mapFailure === 'init' ? 'list' : mobileView}`}>
          <section className="event-results" aria-label="Lista de eventos">
            <div className="result-top">
              <span aria-live="polite"><strong>{loading ? '…' : filtered.length} eventos</strong> <span className="muted">{periodLabel}</span></span>
              <span className="muted">{filters.municipality || 'Valencia y alrededores'}</span>
            </div>
            <div className="cards">
              {loading ? Array.from({ length: 4 }, (_, i) => <div key={i} className="skeleton card" />) :
                filtered.length ? (
                  <>
                    {filtered.slice(0, limit).map((e) => (
                      <EventCard
                        key={e.id}
                        ref={(node) => { if (node) cardRefs.current.set(e.id, node); else cardRefs.current.delete(e.id); }}
                        event={e} entityMap={entityMap} selected={e.id === selectedId}
                        onOpen={setDetailId}
                        onFocusEvent={(id) => selectEvent(id)}
                      />
                    ))}
                    {filtered.length > limit && (
                      <button className="secondary more-events" onClick={() => setLimit((l) => l + PAGE)}>
                        Ver más eventos ({limit} de {filtered.length}) <Icon name="plus" size={15} />
                      </button>
                    )}
                  </>
                ) : (
                  <Empty title="La pista está por abrir" icon="music"
                    action={<button className="secondary" onClick={() => { update({ ...DEFAULT_FILTERS, origin: filters.origin }); setUserLocation(null); }}>Ver todos los próximos</button>}>
                    {filters.near ? 'No hay eventos tan cerca con estos filtros. Prueba a ampliar la distancia.' : 'No hay eventos que coincidan con tus filtros. Prueba otra fecha, género o zona.'}
                  </Empty>
                )}
            </div>
          </section>

          <section className="map-wrap" aria-label="Mapa de eventos">
            {mapFailure === 'init' ? (
              <div className="map-fallback">El mapa no está disponible en este dispositivo. Todos los eventos siguen en la lista.</div>
            ) : (
              <EventMap
                ref={mapRef}
                groups={groups}
                selectedKey={selected ? groupOf.get(selected.id) ?? null : null}
                onSelect={onSelectGroup}
                userLocation={userLocation}
                initialCenter={filters.origin === 'demo' ? { lat: 39.33, lng: -0.45 } : VALENCIA_CENTER}
                initialZoom={filters.origin === 'demo' ? 8 : 12}
                onFailure={setMapFailure}
                fitKey={loading || params.get('evento') ? undefined : filters.origin}
              />
            )}
            <div className="map-label"><Icon name="pin" size={12} /> Solo lugares con eventos</div>
            <div className="map-controls">
              <button className="iconbutton" onClick={() => mapRef.current?.zoomIn()} aria-label="Ampliar mapa"><Icon name="plus" size={17} /></button>
              <button className="iconbutton" onClick={() => mapRef.current?.zoomOut()} aria-label="Reducir mapa"><Icon name="minus" size={17} /></button>
              <button className="iconbutton" onClick={nearMe} aria-label="Cerca de mí (usar mi ubicación)"><Icon name="target" size={17} /></button>
              <button className="iconbutton" onClick={() => mapRef.current?.fitGroups()} aria-label="Ver todos los resultados"><Icon name="pin" size={16} /></button>
            </div>
            {mapFailure === 'tiles' && (
              <div className="map-fallback soft" role="status">
                No se pudo cargar el fondo del mapa{offline ? '' : ' (sin conexión con el proveedor de teselas)'}. Las ubicaciones siguen visibles y la lista funciona.
              </div>
            )}
            {selected && selectedGroup && (
              <div className="map-feature">
                <Poster event={selected} />
                <div className="feature-body">
                  <span className="event-tag">{selectedGroup.events.length > 1 ? `${selectedGroup.events.length} eventos en ${selected.venue_name}` : 'Tu próximo encuentro'}</span>
                  <h3>{selected.title}</h3>
                  <p>{selected.venue_name} · {formatDay(selected.starts_at)} {formatHour(selected.starts_at)} · {formatPrice(selected)}</p>
                  {selectedGroup.events.length > 1 && (
                    <div className="map-group-list" role="list" aria-label="Eventos en este lugar">
                      {selectedGroup.events.map((e) => (
                        <button key={e.id} role="listitem" className={e.id === selected.id ? 'active' : ''} onClick={() => selectEvent(e.id, { scroll: true })}>
                          {formatDay(e.starts_at)} · {formatHour(e.starts_at)} — {e.title}
                        </button>
                      ))}
                    </div>
                  )}
                </div>
                <button className="iconbutton arrow" onClick={() => setDetailId(selected.id)} aria-label={`Ver ficha de ${selected.title}`}><Icon name="arrow" size={19} /></button>
              </div>
            )}
            <div className="map-note">
              {filters.origin === 'demo' ? 'Ubicaciones de ejemplo' : 'Coordenadas publicadas por las fuentes o fijadas por el organizador'}
              {MAP_TILES_ARE_DEFAULT_OSM ? ' · Teselas OSM de desarrollo' : ''}
            </div>
          </section>
        </div>
      )}

      <section className="below-strip">
        <div className="strip-left">
          <div><h3>El plan empieza con tu gente.</h3><p>Acércate a los artistas, salas y colectivos que hacen tu noche.</p></div>
        </div>
        <Link className="pill" href="/comunidades">Encuentra tu comunidad <Icon name="arrow" size={16} /></Link>
      </section>

      <Modal open={Boolean(detailEvent)} onClose={() => setDetailId(null)} title="Tu próximo encuentro">
        {detailEvent && <EventDetail event={detailEvent} entityMap={entityMap} />}
        {detailEvent && <p style={{ marginTop: 16 }}><Link className="link" href={`/eventos/${detailEvent.id}`}>Abrir la ficha completa</Link></p>}
      </Modal>
      <FiltersModal
        open={filtersOpen} onClose={() => setFiltersOpen(false)} filters={filters} onApply={update}
        locations={locations} nearActive={Boolean(filters.near)} geoMessage={geoMessage}
      />
    </>
  );
}
