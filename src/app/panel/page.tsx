import type { Metadata } from 'next';
import { PanelHome } from '@/components/panel/PanelPage';

export const metadata: Metadata = { title: 'Panel profesional' };

export default function Page() {
  return <PanelHome />;
}
