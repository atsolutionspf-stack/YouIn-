// Uso en móvil (375 px): sin desbordamiento horizontal y controles accesibles.
import { expect, test } from '@playwright/test';
import { login } from './helpers';

const PAGES = ['/', '/explorar', '/comunidades', '/comunidades/la-casa-del-groove', '/acerca', '/entrar', '/favoritos', '/perfil'];

for (const path of PAGES) {
  test(`sin desbordamiento horizontal en ${path}`, async ({ page }) => {
    await page.goto(path);
    await page.waitForLoadState('networkidle');
    const overflow = await page.evaluate(() => document.documentElement.scrollWidth - window.innerWidth);
    expect(overflow).toBeLessThanOrEqual(0);
  });
}

test('selector mapa/lista y navegación inferior', async ({ page }) => {
  await page.goto('/');
  await expect(page.locator('.bottom-nav')).toBeVisible();
  await expect(page.locator('.map-wrap')).toBeVisible();
  await page.getByRole('button', { name: /^Lista/ }).click();
  await expect(page.locator('.map-wrap')).toBeHidden();
  await expect(page.locator('.event-card').first()).toBeVisible();
  // Controles con tamaño táctil suficiente.
  const box = await page.locator('.bottom-nav a').first().boundingBox();
  expect(box!.height).toBeGreaterThanOrEqual(44);
});

test('chat utilizable en móvil sin desbordamiento', async ({ page }) => {
  await login(page, 'ana@demo.youin.local');
  await page.goto('/comunidades/la-casa-del-groove?canal=chat');
  await expect(page.getByLabel('Escribe un mensaje')).toBeVisible();
  const overflow = await page.evaluate(() => document.documentElement.scrollWidth - window.innerWidth);
  expect(overflow).toBeLessThanOrEqual(0);
  const composer = await page.locator('.composer').boundingBox();
  expect(composer!.width).toBeLessThanOrEqual(375);
});

test('panel y recompensas sin desbordamiento', async ({ page }) => {
  await login(page, 'arena@demo.youin.local');
  for (const path of ['/panel/house-arena-demo?tab=campanas', '/panel/house-arena-demo?tab=comunidad', '/perfil']) {
    await page.goto(path);
    await page.waitForLoadState('networkidle');
    const overflow = await page.evaluate(() => document.documentElement.scrollWidth - window.innerWidth);
    expect(overflow, path).toBeLessThanOrEqual(0);
  }
});
