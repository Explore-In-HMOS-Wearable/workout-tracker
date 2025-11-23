import dataPreferences from '@ohos.data.preferences';
import common from '@ohos.app.ability.common';

export class LocalStore {
  private static prefs: dataPreferences.Preferences | undefined;

  static async init(ctx: common.Context): Promise<void> {
    if (!LocalStore.prefs) {
      LocalStore.prefs = await dataPreferences.getPreferences(ctx, 'workout_prefs');
    }
  }

  static async setLastWeight(exName: string, value: number): Promise<void> {
    if (!LocalStore.prefs) {
      return;
    }
    await LocalStore.prefs.put(exName, value);
    await LocalStore.prefs.flush();
  }

  static async getLastWeight(exName: string, def: number): Promise<number> {
    if (!LocalStore.prefs) {
      return def;
    }
    const has: boolean = await LocalStore.prefs.has(exName);
    if (!has) {
      return def;
    }
    const v = await LocalStore.prefs.get(exName, def);
    if (typeof v === 'number') {
      return v;
    }
    if (typeof v === 'string') {
      const n = Number(v);
      return Number.isFinite(n) ? n : def;
    }
    return def;
  }
}
