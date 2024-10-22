import Foundation

@objc public class KeyboardLanguage: NSObject {
    @objc public func echo(_ value: String) -> String {
        print(value)
        return value
    }
}
