import type { Metadata } from 'next';
import { Suspense } from 'react';
import { AuthForm } from '@/components/auth/AuthForm';
import { Loading } from '@/components/ui/States';

export const metadata: Metadata = { title: 'Entrar' };

export default function Page() {
  return (
    <Suspense fallback={<Loading />}>
      <AuthForm />
    </Suspense>
  );
}
