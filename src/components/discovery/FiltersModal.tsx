'use client';
import { useState, type FormEvent } from 'react';
import { Modal } from '@/components/ui/Modal';
import { GENRES, PRICE_OPTIONS, type EventFilters, type PriceFilter } from '@/lib/domain/events';
import { madridDateKey } from '@/lib/domain/time';

type Props = {
  open: boolean;
  onClose: () => void;
  filters: EventFilters;
  onApply: (f: Partial<EventFilters>) => void;
  locations: { name: string; areas: string[] }[];
  nearActive: boolean;
  geoMessage?: string;
};

export function FiltersModal({ open, onClose, filters, onApply, locations, nearActive, geoMessage }: Props) {
  const [municipality, setMunicipality] = useState(filters.municipality);
  const [genre, setGenre] = useState(filters.genre);
  const areas = locations.find((l) => l.name === municipality)?.areas ?? [];
  const today = madridDateKey(new Date());

  function submit(e: FormEvent<HTMLFormElement>) {
    e.preventDefault();
    const f = new FormData(e.currentTarget);
    const from = String(f.get('from') || '');
    const to = String(f.get('to') || '');
    onApply({
      genre,
      origin: f.get('demo') === 'on' ? 'demo' : 'published',
      municipality: String(f.get('municipality') || ''),
      area: String(f.get('area') || ''),
      price: String(f.get('price') || 'any') as PriceFilter,
      includeUnknownPrice: f.get('unknown') === 'on',
      ...(from ? { date: 'custom', dateFrom: from, dateTo: to || from } : filters.date === 'custom' ? { date: 'all', dateFrom: undefined, dateTo: undefined } : {}),
      ...(nearActive && f.get('radius') ? { near: filters.near ? { ...filters.near, radiusKm: Number(f.get('radius')) } : null } : {}),
    });
    onClose();
  }

  return (
    <Modal open={open} onClose={onClose} title="Filtros">
      {geoMessage && <div className="notice warm" style={{ marginBottom: 16 }}>{geoMessage}</div>}
      <form onSubmit={submit} key={open ? 'open' : 'closed'}>
        <fieldset className="plain">
          <legend>Música</legend>
          <div className="chips wrap" role="radiogroup" aria-label="Género musical">
            {['Todos', ...GENRES].map((g) => (
              <button key={g} type="button" role="radio" aria-checked={genre === g} className={`chip ${genre === g ? 'active' : ''}`} onClick={() => setGenre(g)}>{g}</button>
            ))}
          </div>
        </fieldset>
        <fieldset className="plain">
          <legend>Fechas · jornada de 06:00 a 06:00</legend>
          <div className="form-grid">
            <label>Desde<input type="date" name="from" min={today} defaultValue={filters.date === 'custom' ? filters.dateFrom : ''} /></label>
            <label>Hasta<input type="date" name="to" min={today} defaultValue={filters.date === 'custom' ? filters.dateTo : ''} /></label>
          </div>
          <p className="help">Una fiesta que empieza a la 01:00 cuenta para la noche anterior.</p>
        </fieldset>
        <div className="form-grid">
          <label>Municipio
            <select name="municipality" value={municipality} onChange={(e) => setMunicipality(e.target.value)}>
              <option value="">Todos</option>
              {locations.map((l) => <option key={l.name} value={l.name}>{l.name}</option>)}
            </select>
          </label>
          <label>Barrio o zona
            <select name="area" defaultValue={filters.area} disabled={!areas.length}>
              <option value="">Todos</option>
              {areas.map((a) => <option key={a} value={a}>{a}</option>)}
            </select>
          </label>
        </div>
        <label>Precio
          <select name="price" defaultValue={filters.price}>
            {PRICE_OPTIONS.map((o) => <option key={o.value} value={o.value}>{o.label}</option>)}
          </select>
        </label>
        <label><input type="checkbox" name="unknown" defaultChecked={filters.includeUnknownPrice} /> Incluir eventos con precio «Consultar»</label>
        {nearActive && (
          <label>Distancia desde tu ubicación
            <select name="radius" defaultValue={String(filters.near?.radiusKm ?? 10)}>
              {[2, 5, 10, 25, 50].map((r) => <option key={r} value={r}>{r} km</option>)}
            </select>
          </label>
        )}
        <label><input type="checkbox" name="demo" defaultChecked={filters.origin === 'demo'} /> Ver solo eventos de demostración (ficticios)</label>
        <p className="help">Solo se listan municipios y zonas con eventos publicados. No se inventan precios: si la fuente no lo indica, figura como «Consultar».</p>
        <button className="primary full">Ver resultados</button>
      </form>
    </Modal>
  );
}
