import { registerPlugin } from '@capacitor/core';

import type { KeyboardLanguagePlugin } from './definitions';

const KeyboardLanguage = registerPlugin<KeyboardLanguagePlugin>('KeyboardLanguage', {
  web: () => import('./web').then((m) => new m.KeyboardLanguageWeb()),
});

export * from './definitions';
export { KeyboardLanguage };
