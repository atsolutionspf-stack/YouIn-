// Validación de registros importados antes de sembrarlos. Si un registro no
// cumple, se descarta y se informa: nunca se completan datos inventados.

const inRegion = (lat, lng) =>
  Number.isFinite(lat) && Number.isFinite(lng) && lat >= 37.75 && lat <= 40.85 && lng >= -1.6 && lng <= 0.65;
const isHttps = (v) => {
  try { return new URL(v).protocol === 'https:'; } catch { return false; }
};

export function validateImportedEvent(e) {
  if (!e.title?.trim()) return 'sin título';
  if (!e.sourceEventKey) return 'sin clave de origen';
  const start = Date.parse(e.start);
  const end = Date.parse(e.end);
  if (!Number.isFinite(start) || !Number.isFinite(end)) return 'fechas no válidas';
  if (end <= start) return 'el fin no es posterior al inicio';
  if (!inRegion(e.lat, e.lng)) return 'coordenadas ausentes o fuera de la Comunitat';
  if (e.ticket && !isHttps(e.ticket)) return 'enlace de entradas no https';
  if (e.posterURL && !isHttps(e.posterURL)) return 'cartel no https';
  if (!Array.isArray(e.sources) || !e.sources.length || !e.sources.every((s) => isHttps(s.url))) return 'sin fuentes verificables';
  if (e.price !== null && e.price !== undefined && !(Number(e.price) >= 0 && Number(e.price) <= 10000)) return 'precio no válido';
  if (!['Valencia', 'Alicante', 'Castellón'].includes(e.province)) return 'provincia no válida';
  return '';
}

export function validateImportedProfile(p) {
  if (!p.name?.trim()) return 'sin nombre';
  if (!['Sala', 'Artista'].includes(p.role)) return 'rol desconocido';
  if (p.sourceURL && !isHttps(p.sourceURL)) return 'fuente no https';
  if (p.imageURL && !isHttps(p.imageURL)) return 'imagen no https';
  if ((p.lat !== undefined || p.lng !== undefined) && !inRegion(p.lat, p.lng)) return 'coordenadas fuera de la Comunitat';
  return '';
}
