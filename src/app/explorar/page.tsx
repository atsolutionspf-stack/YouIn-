import type { Metadata } from 'next';
import { ExplorePage } from '@/components/profiles/ExplorePage';

export const metadata: Metadata = { title: 'Explorar' };

export default function Page() {
  return <ExplorePage />;
}
