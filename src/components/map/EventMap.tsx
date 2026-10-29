'use client';
// Mapa de eventos con Leaflet + MarkerCluster.
// Solo se dibujan ubicaciones con eventos que cumplen los filtros (los grupos
// llegan ya filtrados). Varios eventos en el mismo punto forman un único
// marcador con el número de eventos; al acercarse los clústeres se separan.
import { forwardRef, useEffect, useImperativeHandle, useRef, useState } from 'react';
import type * as Leaflet from 'leaflet';
import type { LocationGroup } from '@/lib/domain/events';
import { formatPrice } from '@/lib/domain/events';
import { MAP_ATTRIBUTION, MAP_TILE_URL } from '@/lib/config';

export type MapHandle = {
  zoomIn: () => void;
  zoomOut: () => void;
  flyTo: (lat: number, lng: number, zoom?: number) => void;
  fitGroups: () => void;
};

type Props = {
  groups: LocationGroup[];
  selectedKey: string | null;
  onSelect: (groupKey: string) => void;
  userLocation?: { lat: number; lng: number } | null;
  initialCenter: { lat: number; lng: number };
  initialZoom: number;
  onFailure?: (kind: 'init' | 'tiles') => void;
  /** Cuando cambia, el mapa se encuadra en los resultados (p. ej. al cargar o cambiar de procedencia). */
  fitKey?: string;
};

const escapeHtml = (s: string) => s.replace(/[&<>"']/g, (c) => ({ '&': '&amp;', '<': '&lt;', '>': '&gt;', '"': '&quot;', "'": '&#39;' })[c]!);

function pinLabel(g: LocationGroup) {
  return g.events.length > 1 ? `${g.events.length} eventos` : formatPrice(g.events[0]);
}

export const EventMap = forwardRef<MapHandle, Props>(function EventMap(
  { groups, selectedKey, onSelect, userLocation, initialCenter, initialZoom, onFailure, fitKey },
  ref,
) {
  const el = useRef<HTMLDivElement>(null);
  const L = useRef<typeof Leaflet | null>(null);
  const map = useRef<Leaflet.Map | null>(null);
  const cluster = useRef<Leaflet.MarkerClusterGroup | null>(null);
  const markers = useRef(new Map<string, Leaflet.Marker>());
  const userMarker = useRef<Leaflet.CircleMarker | null>(null);
  const onSelectRef = useRef(onSelect);
  const onFailureRef = useRef(onFailure);
  const [ready, setReady] = useState(false);
  const resizeObserver = useRef<ResizeObserver | null>(null);
  const lastFit = useRef<string | undefined>(undefined);

  useEffect(() => { onSelectRef.current = onSelect; onFailureRef.current = onFailure; });

  useImperativeHandle(ref, () => ({
    zoomIn: () => map.current?.zoomIn(),
    zoomOut: () => map.current?.zoomOut(),
    flyTo: (lat, lng, zoom) => map.current?.flyTo([lat, lng], zoom ?? Math.max(map.current.getZoom(), 14), { duration: 0.6 }),
    fitGroups: () => {
      if (!map.current || !L.current || !groups.length) return;
      const b = L.current.latLngBounds(groups.map((g) => [g.lat, g.lng] as [number, number]));
      map.current.fitBounds(b, { padding: [40, 40], maxZoom: 14 });
    },
  }), [groups]);

  // Inicialización (una vez).
  useEffect(() => {
    let cancelled = false;
    const markerMap = markers.current;
    (async () => {
      try {
        const leaflet = (await import('leaflet')).default;
        (window as unknown as { L: typeof Leaflet }).L = leaflet;
        await import('leaflet.markercluster');
        if (cancelled || !el.current) return;
        L.current = leaflet;
        const m = leaflet.map(el.current, { zoomControl: false, attributionControl: true, tap: true } as Leaflet.MapOptions)
          .setView([initialCenter.lat, initialCenter.lng], initialZoom);
        m.attributionControl.setPrefix(false);
        let loaded = 0;
        let failed = 0;
        const tiles = leaflet.tileLayer(MAP_TILE_URL, { attribution: MAP_ATTRIBUTION, maxZoom: 19, crossOrigin: true });
        tiles.on('tileload', () => { loaded++; });
        tiles.on('tileerror', () => {
          failed++;
          if (failed === 6 && loaded === 0) onFailureRef.current?.('tiles');
        });
        tiles.addTo(m);
        const group = leaflet.markerClusterGroup({
          showCoverageOnHover: false,
          maxClusterRadius: 48,
          spiderfyOnMaxZoom: true,
          iconCreateFunction: (c) => {
            const count = c.getAllChildMarkers().reduce((n, mk) => n + ((mk.options as { eventCount?: number }).eventCount ?? 1), 0);
            return leaflet.divIcon({
              html: `<span>${count}</span>`,
              className: `youin-cluster ${count >= 20 ? 'big' : ''}`,
              iconSize: [52, 52],
            });
          },
        });
        group.addTo(m);
        map.current = m;
        cluster.current = group;
        // El contenedor cambia de tamaño con el diseño (móvil, escritorio, conmutador mapa/lista).
        const ro = new ResizeObserver(() => m.invalidateSize());
        ro.observe(el.current);
        resizeObserver.current = ro;
        setReady(true);
      } catch (err) {
        console.error('Mapa no disponible', err);
        onFailureRef.current?.('init');
      }
    })();
    return () => {
      cancelled = true;
      resizeObserver.current?.disconnect();
      map.current?.remove();
      map.current = null;
      cluster.current = null;
      markerMap.clear();
    };
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  // Marcadores: se reconstruyen cuando cambian los grupos filtrados.
  useEffect(() => {
    const leaflet = L.current;
    const group = cluster.current;
    if (!ready || !leaflet || !group) return;
    group.clearLayers();
    markers.current.clear();
    for (const g of groups) {
      const label = pinLabel(g);
      const first = g.events[0];
      const title = g.events.length > 1 ? `${first.venue_name}: ${g.events.length} eventos` : `${first.title} · ${first.venue_name}`;
      const marker = leaflet.marker([g.lat, g.lng], {
        icon: leaflet.divIcon({
          html: `<span class="map-pin ${g.events.length > 1 ? 'multi' : ''}">${escapeHtml(label)}</span>`,
          className: 'youin-pin',
          iconSize: [0, 0],
        }),
        title,
        alt: title,
        keyboard: true,
        riseOnHover: true,
        eventCount: g.events.length,
      } as Leaflet.MarkerOptions & { eventCount: number });
      marker.on('click', () => onSelectRef.current(g.key));
      marker.on('keypress', (e: Leaflet.LeafletKeyboardEvent) => {
        if (e.originalEvent.key === 'Enter' || e.originalEvent.key === ' ') onSelectRef.current(g.key);
      });
      markers.current.set(g.key, marker);
      group.addLayer(marker);
    }
    if (fitKey && fitKey !== lastFit.current && groups.length && map.current) {
      lastFit.current = fitKey;
      const b = leaflet.latLngBounds(groups.map((g) => [g.lat, g.lng] as [number, number]));
      map.current.fitBounds(b, { padding: [50, 50], maxZoom: 14 });
    }
  }, [groups, ready, fitKey]);

  // Marcador seleccionado.
  useEffect(() => {
    if (!ready) return;
    markers.current.forEach((mk, key) => {
      const icon = mk.getElement();
      icon?.classList.toggle('selected', key === selectedKey);
      if (key === selectedKey) mk.setZIndexOffset(1000); else mk.setZIndexOffset(0);
    });
    if (selectedKey && cluster.current && map.current) {
      const mk = markers.current.get(selectedKey);
      if (mk && !map.current.getBounds().contains(mk.getLatLng())) {
        cluster.current.zoomToShowLayer(mk);
      }
    }
  }, [selectedKey, ready, groups]);

  // Ubicación del usuario (solo si la ha compartido).
  useEffect(() => {
    const leaflet = L.current;
    if (!ready || !leaflet || !map.current) return;
    userMarker.current?.remove();
    userMarker.current = null;
    if (userLocation) {
      userMarker.current = leaflet
        .circleMarker([userLocation.lat, userLocation.lng], { radius: 8, color: '#FFFAF3', weight: 3, fillColor: '#386B68', fillOpacity: 1 })
        .bindTooltip('Tu ubicación aproximada')
        .addTo(map.current);
    }
  }, [userLocation, ready]);

  return <div ref={el} className="map" role="region" aria-label="Mapa de ubicaciones con eventos" />;
});
