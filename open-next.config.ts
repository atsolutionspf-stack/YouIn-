// Configuración de OpenNext para Cloudflare. La app no usa ISR ni caché de
// datos de Next, así que no hace falta caché incremental en R2.
import { defineCloudflareConfig } from '@opennextjs/cloudflare';

export default defineCloudflareConfig({});
