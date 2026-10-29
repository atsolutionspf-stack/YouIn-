import type { Metadata } from 'next';
import { CommunitiesPage } from '@/components/communities/CommunitiesPage';

export const metadata: Metadata = { title: 'Comunidades' };

export default function Page() {
  return <CommunitiesPage />;
}
