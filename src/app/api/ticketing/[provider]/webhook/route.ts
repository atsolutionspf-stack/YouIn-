import { NextResponse } from 'next/server';
import { CONNECTED_PROVIDERS } from '@/lib/ticketing/types';

// Punto de entrada reservado para confirmaciones verificables de proveedores.
// Mientras no haya integración autorizada, responde 501 y no registra nada.
export async function POST(_request: Request, { params }: { params: Promise<{ provider: string }> }) {
  const { provider } = await params;
  if (!CONNECTED_PROVIDERS[provider]) {
    return NextResponse.json(
      { status: 'not_connected', provider, message: 'No hay integración activa con este proveedor. No se ha registrado ninguna compra.' },
      { status: 501 },
    );
  }
  // Implementación futura: verificar firma, parsear y llamar a process_ticket_* con service_role.
  return NextResponse.json({ status: 'not_implemented' }, { status: 501 });
}
