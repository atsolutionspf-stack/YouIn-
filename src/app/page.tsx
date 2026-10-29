import { Suspense } from 'react';
import { DiscoveryPage } from '@/components/discovery/DiscoveryPage';
import { Loading } from '@/components/ui/States';

export default function Home() {
  return (
    <Suspense fallback={<Loading label="Cargando eventos…" />}>
      <DiscoveryPage />
    </Suspense>
  );
}
