'use client';
import { useState } from 'react';

/** Instante fijado al montar el componente (evita llamar a Date.now() en cada render). */
export function useNow(): number {
  const [now] = useState(() => Date.now());
  return now;
}
