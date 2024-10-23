import { Plugin, PluginListenerHandle } from '@capacitor/core';

export interface KeyboardLanguagePlugin extends Plugin {
  getKeyboardLanguage(): Promise<{ language: string }>;

  addListener(
    eventName: 'keyboardLanguageChange',
    listenerFunc: (info: { language: string }) => void,
  ): Promise<PluginListenerHandle>;
}
