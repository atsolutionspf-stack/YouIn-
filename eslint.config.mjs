import { defineConfig, globalIgnores } from "eslint/config";
import nextVitals from "eslint-config-next/core-web-vitals";
import nextTs from "eslint-config-next/typescript";

const eslintConfig = defineConfig([
  ...nextVitals,
  ...nextTs,
  {
    rules: {
      // Las cargas de datos llaman a funciones asíncronas que actualizan el estado
      // tras `await`; la regla no distingue ese caso. Se mantiene como aviso.
      'react-hooks/set-state-in-effect': 'warn',
      // Carteles e imágenes de fuentes externas y SVG de marca: sin optimizador de imágenes.
      '@next/next/no-img-element': 'off',
    },
  },
  // Override default ignores of eslint-config-next.
  globalIgnores([
    // Default ignores of eslint-config-next:
    ".next/**",
    "out/**",
    "build/**",
    "next-env.d.ts",
  ]),
]);

export default eslintConfig;
