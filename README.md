# capacitor-keyboard-language

Capacitor plugin for detecting the current keyboard language.

## Install

```bash
npm install capacitor-keyboard-language
npx cap sync
```

## API

#### Methods:

- `getKeyboardLanguage`: Returns the current keyboard language.
- `addListener(eventName: 'keyboardLanguageChange', listenerFunc: (info: { language: string }) => void)`: Adds a listener for keyboard language changes.
- `removeAllListeners`: Removes all listeners.

### Example usage in an Ionic Angular application:


```typescript
import { Component } from '@angular/core';
import { KeyboardLanguage } from 'capacitor-keyboard-language';

@Component({
  selector: 'app-example',
  standalone: true,
  templateUrl: './example.component.html',
  styleUrls: ['./example.component.css'],
  providers: [KeyboardLanguage],
})
export class ExampleComponent {
  constructor(private plugin: KeyboardLanguage) {}

  ngOnInit() {
    this.getKeyboardLanguage();
    this.plugin.addListener('keyboardLanguageChange', ({ language }) => {
      console.log('Keyboard language changed to: ', language);
    });
  }

  async getKeyboardLanguage() {
    const language = await this.plugin.getKeyboardLanguage();
    console.log('Current keyboard language: ', language);
  }
}
```
