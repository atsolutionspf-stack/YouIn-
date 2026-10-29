'use client';
import { useEffect, useRef, type ReactNode } from 'react';
import { Icon } from './Icon';

/** Diálogo nativo con el estilo del piloto. Se cierra con Esc, botón o clic fuera. */
export function Modal({ open, title, onClose, children, wide }: { open: boolean; title: string; onClose: () => void; children: ReactNode; wide?: boolean }) {
  const ref = useRef<HTMLDialogElement>(null);
  useEffect(() => {
    const d = ref.current;
    if (!d) return;
    if (open && !d.open) d.showModal();
    if (!open && d.open) d.close();
  }, [open]);
  return (
    <dialog
      ref={ref}
      className={wide ? 'wide' : undefined}
      onClose={onClose}
      onClick={(e) => { if (e.target === ref.current) onClose(); }}
      aria-label={title}
    >
      {open && (
        <>
          <div className="modal-head">
            <h2>{title}</h2>
            <button className="iconbutton" onClick={onClose} aria-label="Cerrar"><Icon name="close" size={18} /></button>
          </div>
          <div className="modal-body">{children}</div>
        </>
      )}
    </dialog>
  );
}
