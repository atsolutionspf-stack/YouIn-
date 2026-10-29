import type { Metadata } from 'next';
import { FavoritesPage } from '@/components/favorites/FavoritesPage';

export const metadata: Metadata = { title: 'Favoritos' };

export default function Page() {
  return <FavoritesPage />;
}
