'use client';
import Link from 'next/link';
import type { OriginFilter } from '@/lib/domain/events';
import { Icon } from '@/components/ui/Icon';

/** Selector de procedencia de datos (Anunciados / Demo), como en el piloto. */
export function ProvenanceBar({ origin, onChange, importedCount }: { origin: OriginFilter; onChange: (o: OriginFilter) => void; importedCount: number }) {
  return (
    <section className="import-bar" aria-label="Procedencia de los eventos">
      <div className="segmented">
        <button className={origin === 'published' ? 'active' : ''} aria-pressed={origin === 'published'} onClick={() => onChange('published')}>Anunciados</button>
        <button className={origin === 'demo' ? 'active' : ''} aria-pressed={origin === 'demo'} onClick={() => onChange('demo')}>Demo</button>
      </div>
      <div>
        {origin === 'demo' ? (
          <><strong>Datos ficticios para probar funciones</strong><span>No corresponden a fiestas reales. Incluye la comunidad de prueba House Arena.</span></>
        ) : (
          <>
            <strong>Publicados en YOU IN? + {importedCount} eventos importados vigentes · Valencia y hasta 50 km</strong>
            <span>Importación puntual de Fourvenues, Marina Beach Club y Xceed · consulta 19/10/2026 · no se actualiza sola</span>
          </>
        )}
      </div>
      <Link className="text-button" href="/acerca#fuentes">Ver fuentes <Icon name="external" size={12} /></Link>
    </section>
  );
}
