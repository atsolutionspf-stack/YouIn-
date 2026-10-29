'use client';
// Selector de ubicación: el organizador fija el punto exacto en el mapa (o
// escribe las coordenadas). No se geocodifica automáticamente ni se inventa
// una posición: sin punto, no hay coordenadas.
import { useEffect, useRef, useState } from 'react';
import type * as Leaflet from 'leaflet';
import { MAP_ATTRIBUTION, MAP_TILE_URL } from '@/lib/config';
import { VALENCIA_CENTER, inRegion } from '@/lib/domain/events';

type Props = { lat: number | null; lng: number | null; onChange: (lat: number | null, lng: number | null) => void };

export function PinPicker({ lat, lng, onChange }: Props) {
  const el = useRef<HTMLDivElement>(null);
  const map = useRef<Leaflet.Map | null>(null);
  const marker = useRef<Leaflet.Marker | null>(null);
  const L = useRef<typeof Leaflet | null>(null);
  const onChangeRef = useRef(onChange);
  const [failed, setFailed] = useState(false);
  useEffect(() => { onChangeRef.current = onChange; });

  useEffect(() => {
    let cancelled = false;
    (async () => {
      try {
        const leaflet = (await import('leaflet')).default;
        if (cancelled || !el.current) return;
        L.current = leaflet;
        const start = lat !== null && lng !== null ? { lat, lng } : VALENCIA_CENTER;
        const m = leaflet.map(el.current, { zoomControl: true }).setView([start.lat, start.lng], lat !== null ? 16 : 12);
        m.attributionControl.setPrefix(false);
        leaflet.tileLayer(MAP_TILE_URL, { attribution: MAP_ATTRIBUTION, maxZoom: 19 }).addTo(m);
        m.on('click', (e: Leaflet.LeafletMouseEvent) => {
          const { lat: la, lng: ln } = e.latlng;
          onChangeRef.current(Number(la.toFixed(6)), Number(ln.toFixed(6)));
        });
        map.current = m;
        new ResizeObserver(() => m.invalidateSize()).observe(el.current);
      } catch {
        setFailed(true);
      }
    })();
    return () => { cancelled = true; map.current?.remove(); map.current = null; marker.current = null; };
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  useEffect(() => {
    const leaflet = L.current;
    const m = map.current;
    if (!leaflet || !m) return;
    if (lat === null || lng === null) { marker.current?.remove(); marker.current = null; return; }
    if (!marker.current) {
      marker.current = leaflet.marker([lat, lng], {
        draggable: true,
        icon: leaflet.divIcon({ html: '<span class="map-pin">Aquí</span>', className: 'youin-pin selected', iconSize: [0, 0] }),
        title: 'Ubicación del evento',
      }).addTo(m);
      marker.current.on('dragend', () => {
        const p = marker.current!.getLatLng();
        onChangeRef.current(Number(p.lat.toFixed(6)), Number(p.lng.toFixed(6)));
      });
    } else {
      marker.current.setLatLng([lat, lng]);
    }
  }, [lat, lng]);

  const outside = lat !== null && lng !== null && !inRegion(lat, lng);
  return (
    <div>
      <div className="pin-picker">
        {failed ? <div className="map-fallback">El mapa no está disponible: escribe las coordenadas.</div> : <div ref={el} style={{ height: '100%' }} />}
      </div>
      <p className="help" style={{ marginTop: 6 }}>Pulsa en el mapa o arrastra el marcador hasta la entrada del local. Si el fondo no carga, escribe latitud y longitud.</p>
      <div className="form-grid">
        <label>Latitud<input type="number" step="any" min={37.75} max={40.85} value={lat ?? ''} onChange={(e) => onChange(e.target.value === '' ? null : Number(e.target.value), lng)} /></label>
        <label>Longitud<input type="number" step="any" min={-1.6} max={0.65} value={lng ?? ''} onChange={(e) => onChange(lat, e.target.value === '' ? null : Number(e.target.value))} /></label>
      </div>
      {outside && <div className="form-error">Las coordenadas deben estar dentro de la Comunitat Valenciana.</div>}
    </div>
  );
}
