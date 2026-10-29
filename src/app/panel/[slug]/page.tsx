import type { Metadata } from 'next';
import { Suspense } from 'react';
import { PanelEntity } from '@/components/panel/PanelPage';
import { Loading } from '@/components/ui/States';

export const metadata: Metadata = { title: 'Panel profesional' };

export default async function Page({ params }: { params: Promise<{ slug: string }> }) {
  const { slug } = await params;
  return <Suspense fallback={<Loading />}><PanelEntity slug={slug} /></Suspense>;
}
