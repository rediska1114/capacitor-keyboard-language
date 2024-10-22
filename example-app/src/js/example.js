import { KeyboardLanguage } from 'capacitor-keyboard-language';

window.testEcho = () => {
    const inputValue = document.getElementById("echoInput").value;
    KeyboardLanguage.echo({ value: inputValue })
}
