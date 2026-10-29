import type { Metadata } from 'next';
import { RewardsPage } from '@/components/rewards/RewardsPage';

export const metadata: Metadata = { title: 'Recompensas' };

export default async function Page({ params }: { params: Promise<{ id: string }> }) {
  const { id } = await params;
  return <RewardsPage campaignId={id} />;
}
