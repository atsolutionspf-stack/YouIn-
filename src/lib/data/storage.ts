import { MEDIA_BUCKET, SUPABASE_URL } from '@/lib/config';
import type { DB } from '@/lib/types';
import { friendlyError } from './errors';

export const MEDIA_LIMITS = { image: 6 * 1024 * 1024, video: 40 * 1024 * 1024 };
const TYPES = { image: ['image/jpeg', 'image/png', 'image/webp'], video: ['video/mp4', 'video/webm'] };

export function validateMedia(file: File, kind: 'image' | 'video'): string {
  if (!TYPES[kind].includes(file.type)) return kind === 'image' ? 'Usa una imagen JPG, PNG o WebP.' : 'Usa un vídeo MP4 o WebM.';
  if (file.size > MEDIA_LIMITS[kind]) return kind === 'image' ? 'La imagen supera 6 MB.' : 'El vídeo supera 40 MB.';
  return '';
}

/** Sube un archivo a la carpeta del usuario y devuelve la ruta guardada. */
export async function uploadMedia(db: DB, userId: string, file: File, kind: 'image' | 'video', folder: string): Promise<string> {
  const problem = validateMedia(file, kind);
  if (problem) throw new Error(problem);
  const ext = file.type.split('/')[1].replace('jpeg', 'jpg');
  const path = `${userId}/${folder}/${crypto.randomUUID()}.${ext}`;
  const { error } = await db.storage.from(MEDIA_BUCKET).upload(path, file, { contentType: file.type, upsert: false, cacheControl: '31536000' });
  if (error) throw new Error(friendlyError(error, 'No se pudo subir el archivo'));
  return path;
}

export async function removeMedia(db: DB, path: string | null | undefined) {
  if (!path) return;
  await db.storage.from(MEDIA_BUCKET).remove([path]);
}

export function mediaUrl(path: string | null | undefined): string {
  if (!path) return '';
  return `${SUPABASE_URL}/storage/v1/object/public/${MEDIA_BUCKET}/${path.split('/').map(encodeURIComponent).join('/')}`;
}
