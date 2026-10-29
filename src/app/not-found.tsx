import Link from 'next/link';
import { Empty } from '@/components/ui/States';

export default function NotFound() {
  return <Empty title="Esta página no existe" icon="map" action={<Link className="secondary" href="/">Volver al mapa</Link>}>Puede que el enlace esté mal escrito o que el contenido ya no esté publicado.</Empty>;
}
