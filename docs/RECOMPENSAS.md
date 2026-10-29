# Recompensas por entradas referidas

Implementación: `supabase/migrations/20261029000400_rewards.sql` (fuente de verdad) y `src/lib/domain/rewards.ts` (misma fórmula para la interfaz). Ambas se prueban con los mismos límites.

## Regla

Por campaña y versionada (`campaign_rules`). Con los valores por defecto (umbral 5, bloque 10):

| Entradas válidas | Invitaciones |
| --- | --- |
| 0–4 | 0 |
| 5–9 | 1 (la propia) |
| 10–19 | 1 + 1 |
| 20–29 | 1 + 2 |
| 30–39 | 1 + 3 |
| … | +1 por cada bloque de 10 |

Fórmula: `válidas < umbral → 0; si no → 1 + min(floor(válidas / bloque), máximo_adicionales)`. Se exige `umbral ≤ bloque`.

## Qué cuenta

- Solo **entradas válidas** (`ticket_items.status = 'valid'`). No cuentan clics, visitas al enlace ni pedidos: un pedido de 3 entradas suma 3.
- Cada compra pertenece a una campaña y a un enlace de esa campaña. Un enlace de otra campaña se rechaza. Los reembolsos actúan sobre el pedido original, así que no se mezclan campañas ni comunidades.

## Idempotencia

- Cada operación (compra, reembolso, cancelación) lleva una clave. La primera ejecución guarda su resultado en `ticket_operations`; reenviar la misma clave devuelve ese resultado con `replayed: true` y no cambia nada.
- Un mismo pedido externo (`proveedor + id de pedido`) no se puede registrar dos veces aunque llegue con otra clave: se responde `duplicate_order` y se anota en el historial.
- Cada enlace se procesa con un bloqueo (`pg_advisory_xact_lock`) y hay un índice único que impide dos invitaciones vivas con el mismo número para el mismo enlace.

## Cambios de regla

`update_campaign_rules` crea una versión nueva y la marca como vigente. **Nunca retira** invitaciones ya concedidas. Si la regla nueva es más generosa, concede las que falten (con la versión nueva anotada). Cada invitación guarda la versión con la que se concedió.

## Reembolsos y cancelaciones

1. Se marcan las entradas como `refunded` o `cancelled` y se recalcula lo que corresponde.
2. Se retiran solo invitaciones **disponibles** (la de número más alto primero), y como máximo las que dependían de esas entradas según la regla vigente (un cambio de regla no provoca retiradas al reembolsar después).
3. Si la invitación que habría que retirar **ya se canjeó**, no se anula (ya se usó en puerta): se anota un **déficit** en el historial. Como las canjeadas siguen contando como concedidas, las siguientes entradas válidas cubren primero ese déficit antes de generar invitaciones nuevas.

## Canje

`redeem_reward` solo lo puede ejecutar la administración de la campaña. Es una actualización atómica `available → redeemed`: un segundo intento (o dos simultáneos) falla indicando cuándo se canjeó. Una invitación retirada no se puede canjear.

## Simulación frente a flujo real

- Las campañas tienen `mode`. Las creadas desde la app son `simulation` (no hay proveedores conectados).
- `simulate_purchase` / `simulate_reversal` solo funcionan en campañas de simulación, las usa la persona dueña del enlace o la administración, y todo queda marcado `is_simulated` (pedidos con proveedor `simulator`, invitaciones e historial).
- Una campaña `live` rechaza compras simuladas y solo aceptaría confirmaciones verificables de un proveedor vía `process_ticket_purchase` con la clave secreta de servidor (no expuesta a la API pública).
