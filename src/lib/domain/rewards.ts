// Reglas de invitaciones por entradas referidas.
// Debe coincidir con public.reward_entitlement() en la migración de recompensas;
// las pruebas comprueban ambos lados con los mismos límites.

export type RewardRule = {
  version: number;
  baseThreshold: number;
  stepSize: number;
  maxExtra: number | null;
  conditions?: string | null;
};

export const DEFAULT_RULE: RewardRule = { version: 1, baseThreshold: 5, stepSize: 10, maxExtra: null };

/** Número total de invitaciones (la propia + adicionales) para un número de entradas válidas. */
export function rewardEntitlement(validTickets: number, rule: Pick<RewardRule, 'baseThreshold' | 'stepSize' | 'maxExtra'>): number {
  const valid = Math.max(0, Math.floor(validTickets));
  if (valid < rule.baseThreshold) return 0;
  const extra = Math.floor(valid / rule.stepSize);
  return 1 + (rule.maxExtra === null ? extra : Math.min(extra, rule.maxExtra));
}

export type RewardProgress = {
  entitled: number;
  /** Entradas válidas necesarias para la siguiente invitación, o null si se alcanzó el máximo. */
  nextTarget: number | null;
  remaining: number | null;
  /** 0..1 dentro del tramo actual. */
  ratio: number;
  label: string;
};

export function rewardProgress(validTickets: number, rule: Pick<RewardRule, 'baseThreshold' | 'stepSize' | 'maxExtra'>): RewardProgress {
  const valid = Math.max(0, Math.floor(validTickets));
  const entitled = rewardEntitlement(valid, rule);
  let nextTarget: number | null;
  let from: number;
  if (valid < rule.baseThreshold) {
    nextTarget = rule.baseThreshold;
    from = 0;
  } else {
    const extra = entitled - 1;
    if (rule.maxExtra !== null && extra >= rule.maxExtra) {
      nextTarget = null;
      from = valid;
    } else {
      nextTarget = (Math.floor(valid / rule.stepSize) + 1) * rule.stepSize;
      from = Math.max(rule.baseThreshold, Math.floor(valid / rule.stepSize) * rule.stepSize);
      if (from > valid) from = rule.baseThreshold;
    }
  }
  const remaining = nextTarget === null ? null : nextTarget - valid;
  const ratio = nextTarget === null ? 1 : Math.min(1, Math.max(0, (valid - from) / Math.max(1, nextTarget - from)));
  const label =
    nextTarget === null
      ? 'Has alcanzado el máximo de invitaciones de esta campaña'
      : entitled === 0
        ? `Te faltan ${remaining} entrada${remaining === 1 ? '' : 's'} para tu invitación`
        : `Te faltan ${remaining} entrada${remaining === 1 ? '' : 's'} para otra invitación adicional`;
  return { entitled, nextTarget, remaining, ratio, label };
}

export function describeRule(rule: Pick<RewardRule, 'baseThreshold' | 'stepSize' | 'maxExtra'>): string {
  const cap = rule.maxExtra === null ? '' : ` (máximo ${rule.maxExtra} adicional${rule.maxExtra === 1 ? '' : 'es'})`;
  return `Desde ${rule.baseThreshold} entradas válidas: tu invitación. A partir de ${rule.stepSize}, una adicional por cada bloque de ${rule.stepSize}${cap}.`;
}

/** Tabla de tramos para mostrar al usuario o al administrador. */
export function ruleTiers(rule: Pick<RewardRule, 'baseThreshold' | 'stepSize' | 'maxExtra'>, upTo = 4) {
  const tiers: { from: number; to: number | null; total: number }[] = [];
  tiers.push({ from: 0, to: rule.baseThreshold - 1, total: 0 });
  let from = rule.baseThreshold;
  for (let total = 1; total <= upTo + 1; total++) {
    const nextFrom = total * rule.stepSize;
    const capped = rule.maxExtra !== null && total - 1 >= rule.maxExtra;
    tiers.push({ from, to: capped ? null : nextFrom - 1, total });
    if (capped) break;
    from = nextFrom;
  }
  return tiers;
}
