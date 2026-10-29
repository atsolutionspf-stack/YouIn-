import type { Metadata } from 'next';
import { MyProfilePage } from '@/components/profiles/MyProfilePage';

export const metadata: Metadata = { title: 'Tu perfil' };

export default function Page() {
  return <MyProfilePage />;
}
