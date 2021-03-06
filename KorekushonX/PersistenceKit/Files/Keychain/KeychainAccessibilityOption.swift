import Foundation

/// KeychainAccessibilityOption.
public enum KeychainAccessibilityOption: CaseIterable {
	/// The data in the keychain item can always be accessed regardless of whether the device is locked.
	case always

	/// The data in the keychain can only be accessed when the device is unlocked. Only available if a passcode is set on the device.
	case alwaysThisDeviceOnly

	/// The data in the keychain item can be accessed only while the device is unlocked by the user.
	case whenUnlocked

	/// The data in the keychain item can be accessed only while the device is unlocked by the user.
	case whenUnlockedThisDeviceOnly

	/// The data in the keychain item cannot be accessed after a restart until the device has been unlocked once by the user.
	case afterFirstUnlock

	/// The data in the keychain item cannot be accessed after a restart until the device has been unlocked once by the user.
	case afterFirstUnlockThisDeviceOnly

	/// The data in the keychain can only be accessed when the device is unlocked. Only available if a passcode is set on the device.
	case whenPasscodeSetThisDeviceOnly

	/// Create a `KeychainAccessibilityOption` from a `CFString` attribute object
	///
	/// - Parameter attribute: `CFString` attribute object.
	init?(attribute: CFString) {
		for item in KeychainAccessibilityOption.allCases where item.attribute == attribute {
			self = item
			return
		}
		return nil
	}
}

// MARK: - Helpers
internal extension KeychainAccessibilityOption {
	/// `CFString` attribute for a `KeychainAccessibilityOption`
	var attribute: CFString {
        switch self {
        case .whenUnlocked:
            return kSecAttrAccessibleWhenUnlocked
        case .whenUnlockedThisDeviceOnly:
            return kSecAttrAccessibleWhenUnlockedThisDeviceOnly
        case .afterFirstUnlock, .always:
            return kSecAttrAccessibleAfterFirstUnlock
        case .afterFirstUnlockThisDeviceOnly, .alwaysThisDeviceOnly:
            return kSecAttrAccessibleAfterFirstUnlockThisDeviceOnly
        case .whenPasscodeSetThisDeviceOnly:
            return kSecAttrAccessibleWhenPasscodeSetThisDeviceOnly
        }
	}
}
