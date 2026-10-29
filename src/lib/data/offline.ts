// Modo demo sin servidor: lee /data/offline-snapshot.json (generado por
// scripts/build-seed.mjs con los mismos datos demo e importados que la base de
// datos). Solo lectura y solo descubrimiento. Las fechas demo se calculan
// respecto a hoy, como hace el seed.
import type { DiscoveryEvent, EntitySummary } from '@/lib/types';
import { addDaysKey, madridDateKey, madridToUtcIso } from '@/lib/domain/time';

type RelativeDemoEvent = Omit<DiscoveryEvent, 'starts_at' | 'ends_at'> & {
  relative: { day: number; start: string; endDay: number; end: string };
};
type Snapshot = { generatedAt: string; entities: EntitySummary[]; events: (DiscoveryEvent | RelativeDemoEvent)[] };

export async function loadOfflineSnapshot(): Promise<{ events: DiscoveryEvent[]; entities: EntitySummary[] }> {
  const res = await fetch('/data/offline-snapshot.json');
  if (!res.ok) throw new Error('No se encontraron los datos de demostración incluidos.');
  const snap = (await res.json()) as Snapshot;
  const today = madridDateKey(new Date());
  const now = Date.now();
  const events = snap.events
    .map((e) => {
      if (!('relative' in e)) return e;
      const { relative, ...rest } = e;
      return {
        ...rest,
        starts_at: madridToUtcIso(`${addDaysKey(today, relative.day)}T${relative.start}`),
        ends_at: madridToUtcIso(`${addDaysKey(today, relative.endDay)}T${relative.end}`),
      } as DiscoveryEvent;
    })
    .filter((e) => +new Date(e.ends_at) > now);
  return { events, entities: snap.entities };
}
