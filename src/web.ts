import { WebPlugin } from '@capacitor/core';

import type { KeyboardLanguagePlugin } from './definitions';

export class KeyboardLanguageWeb extends WebPlugin implements KeyboardLanguagePlugin {
  async echo(options: { value: string }): Promise<{ value: string }> {
    console.log('ECHO', options);
    return options;
  }
}
