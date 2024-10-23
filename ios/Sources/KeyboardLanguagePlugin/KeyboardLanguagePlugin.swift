import Capacitor
import Foundation

/// Please read the Capacitor iOS Plugin Development Guide
/// here: https://capacitorjs.com/docs/plugins/ios
@objc(KeyboardLanguagePlugin)
public class KeyboardLanguagePlugin: CAPPlugin, CAPBridgedPlugin {
  public let identifier = "KeyboardLanguagePlugin"
  public let jsName = "KeyboardLanguage"
  public let pluginMethods: [CAPPluginMethod] = [
    CAPPluginMethod(name: "getKeyboardLanguage", returnType: CAPPluginReturnPromise)
  ]

  private var currentLanguage: String?

  public override func load() {
    super.load()

    NotificationCenter.default.addObserver(
      self,
      selector: #selector(keyboardDidChangeLanguage),
      name: UITextInputMode.currentInputModeDidChangeNotification,
      object: nil
    )

    currentLanguage = getCurrentInputModeLanguage()

  }

  @objc func keyboardDidChangeLanguage(_ notification: Notification) {
    // Adding a delay to ensure the language is updated
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
      let newLanguage = self.getCurrentInputModeLanguage()
      if newLanguage != self.currentLanguage {
        self.currentLanguage = newLanguage
        self.notifyLanguageChange()
      }
    }
  }

  @objc func getKeyboardLanguage(_ call: CAPPluginCall) {
    call.resolve(["language": getCurrentInputModeLanguage() ?? nil])
  }

  private func getCurrentInputModeLanguage() -> String? {
    do {
      let inputModes = UITextInputMode.activeInputModes
      let displayedInputMode = inputModes.filter { inputMode in
        let predicate = NSPredicate(format: "isDisplayed == YES")
        return predicate.evaluate(with: inputMode)
      }.last

      return displayedInputMode?.primaryLanguage
    } catch {
      print("Error getting current input mode language: \(error)")
      return nil
    }
  }

  // Notify JavaScript of the language change
  private func notifyLanguageChange() {
    guard let currentLanguage = currentLanguage else { return }

    let data = [
      "language": currentLanguage
    ]

    notifyListeners("keyboardLanguageChange", data: data)
  }

  deinit {
    NotificationCenter.default.removeObserver(self)
  }
}
