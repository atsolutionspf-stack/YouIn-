import { describe, expect, it } from 'vitest';
import { DEFAULT_RULE, rewardEntitlement, rewardProgress, ruleTiers } from './rewards';

describe('rewardEntitlement (regla 5 / 10)', () => {
  const cases: [number, number][] = [
    [0, 0], [4, 0], [5, 1], [9, 1], [10, 2], [19, 2], [20, 3], [29, 3], [30, 4], [39, 4], [40, 5],
  ];
  it.each(cases)('%i entradas => %i invitaciones', (tickets, expected) => {
    expect(rewardEntitlement(tickets, DEFAULT_RULE)).toBe(expected);
  });

  it('respeta el máximo de adicionales', () => {
    expect(rewardEntitlement(45, { ...DEFAULT_RULE, maxExtra: 2 })).toBe(3);
  });
});

describe('rewardProgress', () => {
  it('antes del umbral apunta a la invitación propia', () => {
    expect(rewardProgress(3, DEFAULT_RULE)).toMatchObject({ entitled: 0, nextTarget: 5, remaining: 2 });
  });
  it('entre 5 y 9 apunta a 10', () => {
    expect(rewardProgress(7, DEFAULT_RULE)).toMatchObject({ entitled: 1, nextTarget: 10, remaining: 3 });
  });
  it('en 10 apunta a 20', () => {
    expect(rewardProgress(10, DEFAULT_RULE)).toMatchObject({ entitled: 2, nextTarget: 20, remaining: 10, ratio: 0 });
  });
  it('con máximo alcanzado no hay siguiente objetivo', () => {
    expect(rewardProgress(25, { ...DEFAULT_RULE, maxExtra: 1 })).toMatchObject({ entitled: 2, nextTarget: null });
  });
});

describe('ruleTiers', () => {
  it('describe los tramos de la regla por defecto', () => {
    expect(ruleTiers(DEFAULT_RULE, 3)).toEqual([
      { from: 0, to: 4, total: 0 },
      { from: 5, to: 9, total: 1 },
      { from: 10, to: 19, total: 2 },
      { from: 20, to: 29, total: 3 },
      { from: 30, to: 39, total: 4 },
    ]);
  });
});
