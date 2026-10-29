import { defineConfig, devices } from '@playwright/test';

// Pruebas de extremo a extremo contra la app (http://localhost:3000) y Supabase local.
// Arranca antes `npm run build && npm start` (o `npm run dev`) y `npx supabase start`.
export default defineConfig({
  testDir: './tests/e2e',
  timeout: 60_000,
  expect: { timeout: 15_000 },
  fullyParallel: false,
  workers: 1,
  reporter: [['list']],
  use: {
    baseURL: process.env.E2E_BASE_URL ?? 'http://localhost:3000',
    trace: 'retain-on-failure',
    locale: 'es-ES',
    timezoneId: 'Europe/Madrid',
  },
  projects: [
    { name: 'escritorio', use: { ...devices['Desktop Chrome'] }, testIgnore: /mobile\.spec/ },
    { name: 'movil', use: { ...devices['Pixel 5'], viewport: { width: 375, height: 760 } }, testMatch: /mobile\.spec/ },
  ],
});
