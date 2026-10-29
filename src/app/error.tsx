'use client';
import { ErrorState } from '@/components/ui/States';

export default function Error({ error, reset }: { error: Error & { digest?: string }; reset: () => void }) {
  return <ErrorState message={error.message || 'Error inesperado.'} onRetry={reset} />;
}
