import { registerPlugin } from '@capacitor/core';

import type { KeyboardLanguagePlugin } from './definitions';

const KeyboardLanguageCapacitor = registerPlugin<KeyboardLanguagePlugin>('KeyboardLanguage', {});

export class KeyboardLanguage {
  private plugin = KeyboardLanguageCapacitor;

  async getKeyboardLanguage(): Promise<string> {
    return this.plugin.getKeyboardLanguage().then((result) => result.language);
  }

  addListener(eventName: 'keyboardLanguageChange', listenerFunc: (info: { language: string }) => void) {
    return this.plugin.addListener(eventName, listenerFunc);
  }

  removeAllListeners() {
    return this.plugin.removeAllListeners();
  }
}

export * from './definitions';
