# Seguimiento · YOU IN? v0.4 (primera versión compartida)

Fecha: 29/10/2026.

## Terminado

**A. Base, datos y permisos**
- Next.js 16 + TypeScript, Supabase (auth email/contraseña, PostgreSQL, Storage, Realtime), `proxy.ts` para refrescar la sesión.
- Migraciones `supabase/migrations/2026102900010x_*.sql`: perfiles, entidades (DJ/sala/colectivo) con administradores, eventos y menciones, favoritos y seguidos, importaciones, proveedores de ticketing, comunidades, mensajes, lecturas, expulsiones, club de pago, campañas, enlaces, pedidos, entradas, operaciones, invitaciones e historial, almacenamiento y métricas.
- RLS en todas las tablas, permisos por columna y funciones `SECURITY DEFINER` con `search_path` vacío.
- Datos de prueba identificados (demo) e importación del piloto validada; modo demo sin servidor explícito.

**B. Descubrimiento y perfiles**
- Mapa Leaflet con agrupación, mapa/lista sincronizados, varios eventos por ubicación, selector mapa/lista en móvil, búsqueda, filtros (fecha con jornada nocturna, género, municipio/barrio, precio, «Consultar»), accesos rápidos, «Cerca de mí» con alternativa, fallo de mapa o teselas controlado, URL compartible.
- Ficha de evento (modal y página `/eventos/[id]` con metadatos): sala, organizador, DJs, comunidades, guardar, compartir, calendario, vendedor, fuentes y procedencia.
- Perfiles públicos con personalización del piloto, seguir (≠ unirse), presskit; perfil propio; editor DJ; Explorar; Favoritos con calendario.

**C. Comunidades**
- Descubrimiento por nombre y estilo, página de comunidad (identidad, responsable, eventos, ventajas, normas, recompensas), unirse/salir, «Mis comunidades», anuncios (solo administración), chat en tiempo real persistente con autor y fecha, paginación, no leídos (por canal y en la navegación), moderación (retirar mensajes), expulsión con veto y readmisión, anti-spam (ráfagas, horas, duplicados, enlaces), club de pago separado en vista previa.

**D. Recompensas y panel**
- House Arena (demo): enlace personal con copia, entradas válidas, progreso, tramos, invitaciones y estado, historial, simulador separado (compras con varias entradas, repetir operación, reembolsar, cancelar).
- Panel: resumen con métricas reales, perfil, eventos (crear/editar/borrar), comunidad, campañas (crear, reglas versionadas, cerrar, resultados por enlace, canje en puerta, simulador por enlace, historial), equipo.
- Estructura de ticketing para integraciones futuras sin endpoints inventados.

**E. Verificación**
- 49 pruebas unitarias, 23 de integración contra Supabase (auth, RLS, Realtime, RPC), 17 E2E con Playwright (escritorio y móvil 375 px). Ver README › Pruebas.

## Pendiente (por prioridad)

1. **Borrado de cuenta** en servidor (Edge Function o ruta con clave secreta que llame a `auth.admin.deleteUser`) y política de retención de mensajes. Sustituye al «Borrar datos de prueba» del piloto.
2. **Proveedor de teselas** con contrato para producción (`NEXT_PUBLIC_MAP_TILE_URL`).
3. **Reclamación verificada** de perfiles importados (flujo de solicitud + revisión manual; hoy no se pueden reclamar).
4. **Pagos del club** (proveedor de pagos, webhook que escriba `club_memberships`, comisión) y canal `club`. La estructura y las políticas ya existen.
5. **Integraciones de ticketing** autorizadas (implementar `TicketingProvider` por proveedor con su documentación oficial) y campañas en modo `live`.
6. Notificaciones (correo/push) de anuncios y nuevos eventos de perfiles seguidos.
7. Moderadores de comunidad que no sean administradores de la entidad (la columna existe en el diseño; no se usa).
8. Escalado del descubrimiento: hoy se cargan todos los eventos próximos (≈130) en el cliente; con miles, paginar por zona visible (`bbox`) en el servidor.
9. Imagen social (Open Graph) generada para eventos y comunidades.

## Siguiente paso concreto

Crear el proyecto Supabase de pruebas compartido (`supabase link` + `supabase db push` + seeds demo), configurar SMTP y URLs de redirección, desplegar en un entorno de **preproducción** con un proveedor de teselas de prueba y pedir a 5–10 personas que recorran: registrarse → guardar un evento → seguir un perfil → unirse a una comunidad → conversar. Con lo que salga, priorizar el punto 1 de la lista.
