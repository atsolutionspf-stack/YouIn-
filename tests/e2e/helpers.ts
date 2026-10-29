import { expect, type Browser, type Page } from '@playwright/test';
import { randomUUID } from 'node:crypto';

export const DEMO_PASSWORD = 'demo-youin-2026';

export async function login(page: Page, email: string, password = DEMO_PASSWORD) {
  await page.goto('/entrar');
  await page.getByLabel('Correo electrónico').fill(email);
  await page.getByLabel('Contraseña').fill(password);
  await page.getByRole('button', { name: /^Entrar/ }).last().click();
  await page.waitForURL(/\/perfil/);
  await expect(page.getByRole('heading', { level: 1 })).toContainText('Hola');
}

export async function register(page: Page, name: string) {
  const email = `e2e-${randomUUID().slice(0, 8)}@example.test`;
  const password = 'e2e-password-123';
  await page.goto('/entrar?modo=registro');
  await page.getByLabel('Tu nombre o alias').fill(name);
  await page.getByLabel('Correo electrónico').fill(email);
  await page.getByLabel('Contraseña').fill(password);
  await page.getByRole('button', { name: /Crear mi cuenta/ }).click();
  await page.waitForURL(/\/perfil/);
  return { email, password };
}

export async function newPage(browser: Browser) {
  const ctx = await browser.newContext({ locale: 'es-ES', timezoneId: 'Europe/Madrid' });
  return ctx.newPage();
}
