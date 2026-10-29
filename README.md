# YOU IN?

Plataforma para descubrir eventos de música y ocio nocturno en Valencia y conectar con las comunidades de DJs, salas y colectivos.

> Descubro un evento en el mapa → conozco a sus artistas y organizadores → sigo sus perfiles → entro en su comunidad → participo y vuelvo a sus eventos.

Esta es la primera versión compartida, construida a partir del piloto `You-in-piloto-4.html`. Conserva su identidad visual (paleta ciruela/melocotón, DM Sans + Manrope + Georgia en cursiva, logotipo original y tono) y pasa de un único HTML con `localStorage` a una app multiusuario real.

- **Estado, pendientes y siguiente paso:** [`docs/PROGRESO.md`](docs/PROGRESO.md)
- **Qué se migró del piloto y qué no:** [`docs/MIGRACION-PILOTO.md`](docs/MIGRACION-PILOTO.md)
- **Reglas de recompensas y reembolsos:** [`docs/RECOMPENSAS.md`](docs/RECOMPENSAS.md)

## Arquitectura

| Capa | Tecnología | Dónde |
| --- | --- | --- |
| Interfaz | Next.js 16 (App Router) + React 19 + TypeScript, CSS del piloto ampliado | `src/app`, `src/components` |
| Acceso a datos | `@supabase/supabase-js` + `@supabase/ssr` (cookies, `proxy.ts`) | `src/lib/data`, `src/lib/supabase` |
| Reglas de negocio puras (probadas) | fechas Europe/Madrid, filtros, precio, recompensas, validación | `src/lib/domain` |
| Base de datos y permisos | PostgreSQL de Supabase con RLS y funciones `SECURITY DEFINER` | `supabase/migrations` |
| Tiempo real | Supabase Realtime (`postgres_changes`, respeta RLS) | `src/components/communities/ChatRoom.tsx` |
| Archivos | Supabase Storage (bucket `media`, cada persona escribe en su carpeta) | `src/lib/data/storage.ts` |
| Mapa | Leaflet 1.9 + Leaflet.markercluster | `src/components/map` |

**Por qué Leaflet:** el piloto ya usaba teselas ráster; Leaflet es ligero, estable y su plugin de agrupación es maduro. MapLibre exigiría además un proveedor de estilos vectoriales. El proveedor de teselas se configura con `NEXT_PUBLIC_MAP_TILE_URL`; por defecto se usan las teselas estándar de OpenStreetMap, que **solo** son aceptables para desarrollo y poco tráfico según su política de uso. Para producción hay que contratar un proveedor (p. ej. MapTiler, Stadia Maps o Carto) y poner aquí su plantilla `{z}/{x}/{y}` y su atribución.

**Permisos:** se comprueban en la base de datos (RLS, permisos por columna y funciones que validan `auth.uid()`), no ocultando botones. Las pruebas de integración atacan la API directamente para verificarlo.

## Puesta en marcha (local, con Supabase local)

Requisitos: Node.js ≥ 20.9, npm, Docker en marcha.

```bash
npm install
```

```bash
npx supabase start
```

`supabase start` aplica las migraciones e imprime `API_URL`, `PUBLISHABLE_KEY` y `SECRET_KEY`. Copia la plantilla de entorno y pega esos valores:

```bash
cp .env.example .env.local
```

```dotenv
NEXT_PUBLIC_SUPABASE_URL=http://127.0.0.1:54321
NEXT_PUBLIC_SUPABASE_PUBLISHABLE_KEY=<PUBLISHABLE_KEY>
SUPABASE_SECRET_KEY=<SECRET_KEY>
NEXT_PUBLIC_SITE_URL=http://localhost:3000
```

Carga los datos de prueba (también lo hace `supabase start` la primera vez):

```bash
npm run db:reset
```

Arranca la app:

```bash
npm run dev
```

Abre http://localhost:3000. Para una versión optimizada: `npm run build` y después `npm start`.

### Cuentas de prueba

Todas son datos de demostración (correo `@demo.youin.local`, contraseña común `demo-youin-2026`):

| Cuenta | Para probar |
| --- | --- |
| `ana@demo.youin.local`, `leo@demo.youin.local` | Usuarias: favoritos, seguir, comunidades, chat entre dos personas |
| `arena@demo.youin.local` | Administra **House Arena (demo)**: campañas, canje de invitaciones |
| `casagroove@demo.youin.local` | Administra Casa Groove y El Patio Club: publicar eventos, moderar |
| `sala@demo.youin.local` | Administra Nave 08 y Onda Libre |
| `luna@demo.youin.local`, `nico@demo.youin.local` | DJs con agenda por menciones |

También puedes registrar cuentas nuevas desde `/entrar` (en local no se pide confirmación por correo; en un proyecto real se activa en Supabase y el enlace llega a `/auth/confirm`).

### Modo demo sin servidor

Si faltan `NEXT_PUBLIC_SUPABASE_URL` o la clave publicable, la app arranca igualmente en **modo demo sin servidor**: solo descubrimiento (mapa, lista, filtros, fichas, perfiles) con los datos incluidos en `public/data/offline-snapshot.json`, de solo lectura. Cuentas, favoritos, comunidades y recompensas muestran que requieren el servidor. Nada se guarda en el navegador simulando ser multiusuario.

## Datos

- **Demo** (`data_origin = 'demo'`): perfiles, comunidades y eventos ficticios del piloto + House Arena. Definidos en `data/demo/demo-data.mjs`. Sus fechas se calculan respecto al día en que se siembra la base; si el entorno lleva días encendido: `npm run db:refresh-demo`.
- **Importados** (`data_origin = 'imported'`): la importación puntual del piloto (`data/import/pilot-ticketing-snapshot-2026-10-19.json`), con fuentes, enlaces y fecha de consulta (19/10/2026). Se validan antes de sembrarse (`scripts/import-validation.mjs`); un registro inválido se descarta, nunca se completa. Los perfiles importados son referencias sin reclamar: nadie puede editarlos ni apropiárselos.
- **Publicados en YOU IN?** (`data_origin = 'user'`): lo que crean salas y colectivos.

Tras editar los datos demo o la importación, regenera los seeds y la instantánea sin servidor:

```bash
npm run db:seed:build
```

```bash
npm run db:reset
```

## Pruebas

```bash
npm test
```

Unitarias (fechas Europe/Madrid y cambios de hora, jornada nocturna, filtros, precio, procedencia, calendario, validación de eventos, límites de recompensas).

```bash
npm run test:integration
```

Integración contra Supabase local (auth real, RLS, Realtime, funciones). Requiere `npx supabase start`. Crean cuentas y mensajes de prueba en las comunidades demo: después, `npm run db:reset` para volver a los datos limpios.

```bash
npm run test:e2e
```

Extremo a extremo con Playwright (escritorio y móvil 375 px) contra la app en http://localhost:3000 (arráncala antes con `npm run build && npm start`) y Supabase local.

Otras comprobaciones: `npm run lint` y `npm run typecheck`.

## Ticketing

No hay integraciones activas. `src/lib/ticketing/types.ts` define la interfaz para futuras integraciones **autorizadas** (verificación de firma + traducción a compras/reversiones confirmadas) y `POST /api/ticketing/[proveedor]/webhook` responde `501` sin registrar nada. Las compras reales solo se aceptarán en campañas en modo `live` a través de `process_ticket_purchase` / `process_ticket_reversal` con la clave secreta de servidor. Abrir un enlace de compra nunca cuenta como entrada vendida.

## Despliegue (cuando toque; no en esta fase)

1. Crear un proyecto Supabase y enlazarlo: `npx supabase link --project-ref <ref>` y `npx supabase db push` (aplica `supabase/migrations`). No subas los seeds demo a producción salvo que quieras un entorno de pruebas.
2. En Supabase › Authentication: activar confirmación por correo, configurar SMTP propio y añadir la URL del sitio y `/auth/confirm` a las URLs de redirección.
3. Configurar en el hosting las variables de `.env.example` (sin exponer `SUPABASE_SECRET_KEY` al cliente) y un proveedor de teselas con contrato.

## Problemas conocidos del entorno

- Si `supabase start` falla al descargar imágenes desde `public.ecr.aws` (p. ej. por un proxy), puedes usar Docker Hub: `SUPABASE_INTERNAL_IMAGE_REGISTRY=docker.io npx supabase start`.
- Tras `db reset`, el primer cliente de Realtime puede tardar unos segundos en recibir eventos (arranque en frío del servicio).
