// Exportación a calendario (.ics), como en el piloto.
type IcsEvent = { id: string; title: string; starts_at: string; ends_at: string; venue_name: string; address: string; municipality?: string | null; description?: string | null; data_origin: string };

const stamp = (d: string | Date) => new Date(d).toISOString().replace(/[-:]/g, '').replace(/\.\d{3}/, '');
const escape = (s: string) => s.replace(/\\/g, '\\\\').replace(/\n/g, '\\n').replace(/[,;]/g, (c) => '\\' + c);

export function createIcs(e: IcsEvent, url: string, now: Date = new Date()): string {
  const note = e.data_origin === 'demo' ? ' (Evento de demostración: no es una fiesta real.)' : e.data_origin === 'imported' ? ' (Datos importados: comprueba cambios en el vendedor.)' : '';
  const lines = [
    'BEGIN:VCALENDAR', 'VERSION:2.0', 'PRODID:-//YOU IN?//Eventos//ES', 'CALSCALE:GREGORIAN', 'BEGIN:VEVENT',
    `UID:${e.id}@youin`, `DTSTAMP:${stamp(now)}`, `DTSTART:${stamp(e.starts_at)}`, `DTEND:${stamp(e.ends_at)}`,
    `SUMMARY:${escape(e.title)}`,
    `LOCATION:${escape([e.venue_name, e.address, e.municipality].filter(Boolean).join(', '))}`,
    `DESCRIPTION:${escape((e.description ?? '') + note + ' ' + url)}`,
    `URL:${url}`, 'END:VEVENT', 'END:VCALENDAR',
  ];
  return lines.join('\r\n') + '\r\n';
}

export function downloadFile(name: string, data: string, type: string) {
  const url = URL.createObjectURL(new Blob([data], { type }));
  const a = document.createElement('a');
  a.href = url;
  a.download = name;
  a.click();
  setTimeout(() => URL.revokeObjectURL(url), 1000);
}
