# Migración desde `You-in-piloto-4.html`

Inventario de funciones del piloto y su estado en esta versión. Nada se ha retirado sin anotarlo aquí.

| Función del piloto | Estado | Notas |
| --- | --- | --- |
| Identidad visual (colores, tipografías, logo, tono) | Migrada | La hoja CSS del piloto se porta literal (`src/app/pilot.css`); las ampliaciones van en `youin.css`. Logo, icono y carteles SVG originales en `public/brand`. |
| Mapa y lista con filtros | Migrada y ampliada | Leaflet con agrupación, mapa y lista sincronizados, varios eventos por lugar, selector mapa/lista en móvil, búsqueda por evento/sala/DJ/colectivo, filtros por fecha, género, municipio/barrio y precio. |
| Periodos «Ahora / Esta noche / Próximos» | Migrada y ampliada | Ahora, Hoy, Mañana, Este finde, fechas personalizadas y Próximos, con jornada nocturna de 06:00 a 06:00. |
| «Usar mi ubicación» | Migrada | «Cerca de mí» solo al pulsar; si se rechaza o falla, se ofrece elegir municipio o barrio. No se guarda. |
| Mapa propio sobre teselas OSM | Sustituido | Leaflet con proveedor configurable. Si las teselas fallan, se avisa y los marcadores y la lista siguen funcionando. |
| Eventos de demostración (Valencia y regionales) | Migrada | Seeds `data_origin = 'demo'`, fechas relativas al día de siembra. |
| Importación puntual de eventos anunciados | Migrada | 119 eventos y 109 perfiles con fuentes, enlaces y fecha de consulta; validación previa; etiquetas de procedencia; precios «Desde»/«Consultar» y avisos de horario. |
| Selector Anunciados / Demo | Migrada | «Anunciados» incluye importados + publicados en la app. |
| Favoritos | Migrada | En la base de datos, privados, persisten entre dispositivos. |
| Calendario mensual con colores por fuente | Migrada | Colores guardados en la cuenta; eventos nocturnos también en el día en que terminan. |
| Exportar evento a calendario (.ics) | Migrada | |
| Perfil de usuario | Migrada | Nombre, bio, foto. |
| Perfil DJ en la misma cuenta | Migrada | Nombre artístico, frase, bio, géneros, foto, portada, color, tipografía, diseño, enlaces, contacto, presskit. |
| Salas y colectivos separados | Migrada y ampliada | Varios administradores por entidad (propietario + administradores). |
| Publicación manual de eventos gratis | Migrada y ampliada | Ubicación fijada en mapa (sin geocodificar ni inventar), borrador/publicado/cancelado, cartel y vídeo, enlace al vendedor. |
| Menciones a DJs y agenda ocultable | Migrada | Ocultar no borra el evento; el DJ no puede editar el evento original. |
| Comunidades con conversaciones locales | Migrada a real | Unirse/salir, anuncios, chat en tiempo real persistente, no leídos, moderación, expulsión, anti-spam. |
| Club de pago (texto informativo) | Migrada y ampliada | Estructura de datos y vista previa configurable por comunidad. Sin cobros. |
| Subida local de imágenes/vídeo (IndexedDB) | Migrada a Supabase Storage | Límites 6 MB imagen / 40 MB vídeo, tipos permitidos validados en cliente y en el bucket. |
| Exportar mis datos (JSON) | Migrada | Desde el perfil. |
| «Borrar datos de prueba» | Sustituido / pendiente | En una cuenta real se necesita borrado de cuenta en servidor: **pendiente** (ver PROGRESO). |
| Contactar / conversaciones privadas de prueba | Retirada intencionadamente | Requisito de esta fase: sin mensajes privados. Se mantiene el contacto público (email/teléfono) si el perfil lo publica. |
| Sugerencias de municipios y centros de barrio para prefijar coordenadas | Retirada como prefijado | Para no presentar coordenadas aproximadas como reales, la ubicación se fija en el mapa. El listado de barrios (CC BY 4.0) se conserva en `data/import/valencia-barrios.json`. Los filtros de ubicación usan los municipios y zonas presentes en los eventos. |
| Selector de provincia (Valencia/Alicante/Castellón) en filtros | Sustituido | Filtro por municipio y zona derivado de los eventos publicados (la importación cubre Valencia y 50 km). La provincia se guarda en cada evento. |
| «Sobre el piloto» | Migrada | Página `/acerca` con estado real/demo/simulado y fuentes. |
