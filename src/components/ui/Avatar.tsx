import { mediaUrl } from '@/lib/data/storage';
import { safeHttpsUrl } from '@/lib/domain/events';

type AvatarSource = { name: string; initials?: string | null; color?: string | null; photo_path?: string | null; image_url?: string | null };

export function Avatar({ p, size }: { p: AvatarSource; size?: number }) {
  const src = mediaUrl(p.photo_path) || safeHttpsUrl(p.image_url);
  const style = size ? { width: size, height: size, fontSize: Math.round(size / 3) } : undefined;
  if (src) {
    // Imágenes externas de las fuentes importadas: no se optimizan con next/image.
    return <img className="avatar photo-avatar" src={src} alt={`Foto de ${p.name}`} loading="lazy" referrerPolicy="no-referrer" style={style} />;
  }
  const initials = (p.initials || p.name.slice(0, 2)).toUpperCase();
  return <span className={`avatar ${p.color || 'green'}`} style={style} aria-hidden="true">{initials}</span>;
}
