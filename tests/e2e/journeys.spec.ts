// Recorridos principales en navegador real (criterios de entrega).
import { expect, test } from '@playwright/test';
import { login, newPage, register } from './helpers';
import { addDaysKey, madridDateKey } from '../../src/lib/domain/time';

test('dos usuarios distintos entran en una comunidad y conversan en tiempo real', async ({ browser }) => {
  const a = await newPage(browser);
  const b = await newPage(browser);
  await register(a, 'Alba E2E');
  await register(b, 'Bruno E2E');

  for (const page of [a, b]) {
    await page.goto('/comunidades/bajo-la-superficie');
    await page.getByRole('button', { name: /Unirme gratis/ }).click();
    await expect(page.getByRole('tab', { name: /Chat/ })).toHaveAttribute('aria-selected', 'true');
    await expect(page.locator('.realtime-status.on')).toBeVisible();
  }

  const text = `Hola desde Alba ${Date.now()}`;
  await a.getByLabel('Escribe un mensaje').fill(text);
  await a.getByLabel('Escribe un mensaje').press('Enter');
  await expect(a.locator('.bubble.me', { hasText: text })).toBeVisible();
  // B lo recibe sin recargar, con autor.
  const bubble = b.locator('.bubble', { hasText: text });
  await expect(bubble).toBeVisible();
  await expect(bubble.locator('.author')).toContainText('Alba E2E');

  // Y la respuesta llega a A.
  const reply = `Respuesta de Bruno ${Date.now()}`;
  await b.getByLabel('Escribe un mensaje').fill(reply);
  await b.getByRole('button', { name: 'Enviar' }).click();
  // En directo o, si Realtime está arrancando, por la comprobación periódica (15 s).
  await expect(a.locator('.bubble', { hasText: reply })).toBeVisible({ timeout: 25_000 });

  // Persisten tras recargar.
  await b.reload();
  await expect(b.locator('.bubble', { hasText: text })).toBeVisible();
});

test('una persona que no es miembro no puede leer el chat', async ({ page }) => {
  await register(page, 'Curiosa E2E');
  await page.goto('/comunidades/la-casa-del-groove?canal=chat');
  await expect(page.getByRole('heading', { name: 'Únete para participar' })).toBeVisible();
  await expect(page.locator('.bubble')).toHaveCount(0);
});

test('un administrador publica un evento y aparece en el mapa y en la lista', async ({ page }) => {
  await login(page, 'casagroove@demo.youin.local');
  await page.goto('/panel/casa-groove?tab=eventos');
  await page.getByRole('button', { name: /Crear evento gratis/ }).click();
  const title = `E2E Noche ${Date.now()}`;
  const day = addDaysKey(madridDateKey(new Date()), 3);
  await page.getByLabel('Nombre del evento').fill(title);
  const dates = page.locator('input[type=date]');
  await dates.nth(0).fill(day);
  await page.locator('input[name=startTime]').fill('23:00');
  await dates.nth(1).fill(addDaysKey(day, 1));
  await page.locator('input[name=endTime]').fill('05:30');
  await page.getByLabel('Nombre del espacio').fill('Sala E2E');
  await page.getByLabel('Dirección').fill('Carrer de Prova 1');
  await page.getByLabel('Latitud').fill('39.4699');
  await page.getByLabel('Longitud').fill('-0.3763');
  await page.getByLabel('Precio (€)').fill('9');
  await page.getByRole('button', { name: /Publicar evento gratis/ }).click();
  await expect(page.getByText(title)).toBeVisible();

  await page.goto(`/?q=${encodeURIComponent(title)}`);
  await expect(page.locator('.event-card', { hasText: title })).toBeVisible();
  await expect(page.locator('.result-top')).toContainText('1 eventos');
  // Un único marcador en el mapa para el resultado.
  await expect(page.locator('.leaflet-marker-icon.youin-pin')).toHaveCount(1);
  await page.locator('.leaflet-marker-icon.youin-pin .map-pin').click();
  await expect(page.locator('.map-feature')).toContainText(title);
});

test('favoritos y membresías persisten al cerrar sesión y volver a entrar', async ({ page }) => {
  const creds = await register(page, 'Persistente E2E');
  await page.goto('/?origen=demo');
  const card = page.locator('.event-card').first();
  const title = (await card.locator('h3').textContent())!.trim();
  await card.getByRole('button', { name: /Guardar .* en favoritos/ }).click();
  await expect(card.getByRole('button', { name: /Quitar .* de favoritos/ })).toBeVisible();
  await page.goto('/comunidades/en-la-misma-onda');
  await page.getByRole('button', { name: /Unirme gratis/ }).click();
  await expect(page.locator('.realtime-status')).toBeVisible();

  await page.goto('/perfil');
  await page.getByRole('button', { name: /Cerrar sesión/ }).click();
  await page.waitForURL((u) => u.pathname === '/');
  await login(page, creds.email, creds.password);

  await page.goto('/favoritos');
  await expect(page.locator('.large-card-grid .event-card', { hasText: title })).toBeVisible();
  await page.goto('/comunidades');
  await expect(page.locator('.my-community', { hasText: 'En la misma onda' })).toBeVisible();
});

test('ocultar un evento de la agenda del DJ no lo borra de la plataforma', async ({ page }) => {
  await login(page, 'luna@demo.youin.local');
  const row = page.locator('.agenda-row').filter({ has: page.getByRole('button', { name: 'Ocultar' }) }).first();
  const title = (await row.locator('strong').textContent())!.trim();
  const href = await row.locator('a').getAttribute('href');
  await row.getByRole('button', { name: 'Ocultar' }).click();
  await expect(page.locator('.agenda-row', { hasText: title }).getByRole('button', { name: 'Mostrar' })).toBeVisible();

  // El evento sigue existiendo para cualquiera.
  const other = await newPage(page.context().browser()!);
  await other.goto(href!);
  await expect(other.getByRole('heading', { level: 1 })).toContainText(title);
  // Restaurar para no afectar a otras pruebas.
  await page.locator('.agenda-row', { hasText: title }).getByRole('button', { name: 'Mostrar' }).click();
});

test('referidos House Arena: límites, operación repetida y canje único', async ({ page, browser }) => {
  await register(page, 'Referidora E2E');
  await page.goto('/comunidades/house-arena?canal=info');
  await page.getByRole('button', { name: /Unirme gratis/ }).click();
  await page.goto('/comunidades/house-arena?canal=info');
  await page.locator('.list-row', { hasText: 'Trae a tu gente' }).getByRole('link', { name: 'Mi enlace' }).click();
  await expect(page.locator('.link-box code')).toContainText('/r/');
  await expect(page.locator('.status-badge.sim').first()).toBeVisible();

  const qty = page.getByLabel('Entradas en la compra');
  const buy = page.getByRole('button', { name: 'Registrar compra de prueba' });
  const invites = page.locator('.reward-hero .big-number').nth(1);
  const valid = page.locator('.reward-hero .big-number').nth(0);

  await qty.fill('4'); await buy.click();
  await expect(valid).toHaveText('4'); await expect(invites).toHaveText('0');
  await qty.fill('1'); await buy.click();
  await expect(valid).toHaveText('5'); await expect(invites).toHaveText('1');
  // Repetir exactamente la misma operación no duplica.
  await page.getByRole('button', { name: 'Repetir la última operación' }).click();
  await expect(page.locator('.sim-result')).toContainText('"replayed": true');
  await expect(valid).toHaveText('5'); await expect(invites).toHaveText('1');
  await qty.fill('4'); await buy.click();
  await expect(valid).toHaveText('9'); await expect(invites).toHaveText('1');
  await qty.fill('1'); await buy.click();
  await expect(valid).toHaveText('10'); await expect(invites).toHaveText('2');
  await qty.fill('10'); await buy.click();
  await expect(valid).toHaveText('20'); await expect(invites).toHaveText('3');
  await qty.fill('10'); await buy.click();
  await expect(valid).toHaveText('30'); await expect(invites).toHaveText('4');

  const code = (await page.locator('.reward-item code').first().textContent())!.trim();
  // Canje en puerta por la administración: una sola vez.
  const admin = await newPage(browser);
  await login(admin, 'arena@demo.youin.local');
  await admin.goto('/panel/house-arena-demo?tab=campanas');
  await admin.getByLabel('Código de invitación').fill(code);
  await admin.locator('form', { has: admin.getByLabel('Código de invitación') }).getByRole('button', { name: 'Canjear', exact: true }).click();
  await expect(admin.locator('#toast')).toContainText('Invitación canjeada');
  await admin.getByLabel('Código de invitación').fill(code);
  await admin.locator('form', { has: admin.getByLabel('Código de invitación') }).getByRole('button', { name: 'Canjear', exact: true }).click();
  await expect(admin.locator('#toast')).toContainText('ya se canjeó');
});
