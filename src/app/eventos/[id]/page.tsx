import type { Metadata } from 'next';
import { getPublicServerClient } from '@/lib/supabase/public';
import { formatDay, formatHour } from '@/lib/domain/time';
import { EventPageClient } from '@/components/events/EventPageClient';

type Props = { params: Promise<{ id: string }> };

export async function generateMetadata({ params }: Props): Promise<Metadata> {
  const { id } = await params;
  const db = getPublicServerClient();
  if (!db || !/^[0-9a-f-]{36}$/i.test(id)) return { title: 'Evento' };
  const { data } = await db.from('events').select('title, venue_name, starts_at, data_origin').eq('id', id).maybeSingle();
  if (!data) return { title: 'Evento no encontrado' };
  const description = `${formatDay(data.starts_at)} · ${formatHour(data.starts_at)} · ${data.venue_name}${data.data_origin === 'demo' ? ' (demostración)' : ''}`;
  return { title: data.title, description, openGraph: { title: data.title, description } };
}

export default async function Page({ params }: Props) {
  const { id } = await params;
  return <EventPageClient id={id} />;
}
