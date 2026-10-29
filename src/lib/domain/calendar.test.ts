import { describe, expect, it } from 'vitest';
import { monthCells, sourceColor } from './calendar';

describe('calendario', () => {
  it('octubre de 2026 empieza en lunes 28 de septiembre y termina el domingo 1 de noviembre', () => {
    const cells = monthCells(2026, 9);
    expect(cells[0].key).toBe('2026-09-28');
    expect(cells.at(-1)!.key).toBe('2026-11-01');
    expect(cells.length % 7).toBe(0);
  });
  it('respeta un color personalizado válido y descarta los no válidos', () => {
    expect(sourceColor('x', { x: '#123456' })).toBe('#123456');
    expect(sourceColor('x', { x: 'red' })).toMatch(/^#[0-9A-F]{6}$/i);
  });
});
