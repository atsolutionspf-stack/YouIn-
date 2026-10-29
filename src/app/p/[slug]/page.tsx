import type { Metadata } from 'next';
import { getPublicServerClient } from '@/lib/supabase/public';
import { ProfileView } from '@/components/profiles/ProfileView';

type Props = { params: Promise<{ slug: string }> };

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const { slug } = await params;
  const db = getPublicServerClient();
  if (!db) return { title: 'Perfil' };
  const { data } = await db.from('entities').select('name, bio').eq('slug', slug).maybeSingle();
  return data ? { title: data.name, description: data.bio?.slice(0, 160) ?? undefined } : { title: 'Perfil no encontrado' };
}

export default async function Page({ params }: Props) {
  const { slug } = await params;
  return <ProfileView slug={slug} />;
}
