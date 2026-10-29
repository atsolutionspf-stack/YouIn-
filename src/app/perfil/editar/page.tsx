import type { Metadata } from 'next';
import { EditProfilePage } from '@/components/profiles/EditProfilePage';

export const metadata: Metadata = { title: 'Editar perfil' };

export default function Page() {
  return <EditProfilePage />;
}
