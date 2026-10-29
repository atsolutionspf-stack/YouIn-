import type { NextConfig } from 'next';

// cacheComponents queda desactivado: casi todos los datos se leen en el cliente
// con la sesión del usuario y RLS. Se puede adoptar más adelante por rutas.
const nextConfig: NextConfig = {
  poweredByHeader: false,
};

export default nextConfig;
