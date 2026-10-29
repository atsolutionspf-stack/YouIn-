// Estructura para futuras integraciones AUTORIZADAS con proveedores de ticketing
// (Fourvenues, Xceed u otros). Ningún proveedor está conectado en esta versión y
// aquí no se asume ningún endpoint, formato ni firma: se implementará con la
// documentación oficial y un acuerdo con cada proveedor.
//
// Flujo previsto:
//   1. El proveedor envía una confirmación (webhook) firmada.
//   2. verifyRequest() comprueba la firma con un secreto del proveedor.
//   3. parse() traduce el cuerpo a ConfirmedPurchase / ConfirmedReversal.
//   4. El servidor llama, con service_role, a public.process_ticket_purchase()
//      o public.process_ticket_reversal() usando la clave de idempotencia del
//      proveedor. Solo las campañas en modo 'live' aceptan estas operaciones.
//
// Abrir un enlace de compra NUNCA cuenta como venta.

export type ConfirmedPurchase = {
  kind: 'purchase';
  idempotencyKey: string; // id único de la notificación del proveedor
  externalOrderId: string;
  ticketIds: string[]; // una entrada = un id; un pedido puede tener varias
  referralCode: string; // código YOU IN? que el proveedor devuelva asociado al pedido
  campaignId: string;
};

export type ConfirmedReversal = {
  kind: 'refunded' | 'cancelled';
  idempotencyKey: string;
  externalOrderId: string;
  ticketIds: string[] | null; // null = todas las entradas válidas del pedido
};

export interface TicketingProvider {
  id: string; // coincide con public.ticketing_providers.id
  name: string;
  verifyRequest(request: Request, rawBody: string): Promise<boolean>;
  parse(rawBody: string): Promise<ConfirmedPurchase | ConfirmedReversal | null>;
}

/** Registro de proveedores conectados. Vacío a propósito: no hay integraciones activas. */
export const CONNECTED_PROVIDERS: Record<string, TicketingProvider> = {};
