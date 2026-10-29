import type { Metadata } from 'next';
import { Suspense } from 'react';
import { getPublicServerClient } from '@/lib/supabase/public';
import { CommunityPage } from '@/components/communities/CommunityPage';
import { Loading } from '@/components/ui/States';

type Props = { params: Promise<{ slug: string }> };

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const { slug } = await params;
  const db = getPublicServerClient();
  if (!db) return { title: 'Comunidad' };
  const { data } = await db.from('communities').select('name, description').eq('slug', slug).maybeSingle();
  return data ? { title: data.name, description: data.description ?? undefined } : { title: 'Comunidad no encontrada' };
}

export default async function Page({ params }: Props) {
  const { slug } = await params;
  return <Suspense fallback={<Loading />}><CommunityPage slug={slug} /></Suspense>;
}
