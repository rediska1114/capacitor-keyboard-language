export interface KeyboardLanguagePlugin {
  echo(options: { value: string }): Promise<{ value: string }>;
}
