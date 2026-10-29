'use client';
import { createContext, useCallback, useContext, useRef, useState, type ReactNode } from 'react';

const ToastContext = createContext<(message: string) => void>(() => {});

export function ToastProvider({ children }: { children: ReactNode }) {
  const [message, setMessage] = useState('');
  const [visible, setVisible] = useState(false);
  const timer = useRef<ReturnType<typeof setTimeout> | null>(null);
  const toast = useCallback((m: string) => {
    setMessage(m);
    setVisible(true);
    if (timer.current) clearTimeout(timer.current);
    timer.current = setTimeout(() => setVisible(false), 3600);
  }, []);
  return (
    <ToastContext.Provider value={toast}>
      {children}
      <div id="toast" className={visible ? 'show' : ''} role="status" aria-live="polite">{message}</div>
    </ToastContext.Provider>
  );
}

export const useToast = () => useContext(ToastContext);
