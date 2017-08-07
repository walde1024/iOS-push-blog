//
//  KeychainUtils.swift
//  iOS-on-boarding
//
//  Created by Schlegel, Waldemar on 19/07/2017.
//  Copyright © 2017 SAP. All rights reserved.
//

import Foundation

// functions for keychain save and retrieve data
// Note: The "Keychain Sharing" capability for the app needs to be turned on
// in order for all these operations to be successful.


/**
 Saving a String to keychain.
 Note: The "Keychain Sharing" capability for the app needs to be turned on
 in order for this operation be successful.
 - parameter key: The key for the String.
 - parameter value: The String value to be saved.
 */
func saveKeychainString(key: String, value: String) {
    let data = value.data(using: .utf8)
    saveKeychainData(key: key, data: data!)
}

/**
 Saving a Bool value to keychain.
 Note: The "Keychain Sharing" capability for the app needs to be turned on
 in order for this operation be successful.
 - parameter key: The key for the Bool.
 - parameter value: The Bool value to be saved.
 */
func saveKeychainBool(key: String, value: Bool) {
    let byte = value ? 0x1 : 0 as UInt8
    let data = Data.init(bytes: [byte])
    saveKeychainData(key: key, data: data)
}

/**
 Saving an Int value to keychain.
 Note: The "Keychain Sharing" capability for the app needs to be turned on
 in order for this operation be successful.
 - parameter key: The key for the Int.
 - parameter value: The Int value to be saved.
 */
func saveKeychainInt(key: String, value: Int) {
    let s = String(value)
    saveKeychainString(key: key, value: s)
}

/**
 Load the Bool value previously saved in the keychain.
 Note: The "Keychain Sharing" capability for the app needs to be turned on
 in order for this operation be successful.
 - parameter key: The key for the Bool value.
 - returns: The previously stored Bool value. Or, nil if there was no value saved for this key.
 */
func loadKeychainBool(key: String) -> Bool? {
    let data = loadKeychainData(key: key)
    if data != nil {
        guard let firstByte = data!.first else {
            return nil
        }
        return firstByte == 0x1
    }
    return nil
}

/**
 Load the String value previously saved in the keychain.
 Note: The "Keychain Sharing" capability for the app needs to be turned on
 in order for this operation be successful.
 - parameter key: The key for the String value.
 - returns: The previously stored String value. Or, nil if there was no value saved for this key.
 */
func loadKeychainString(key: String) -> String? {
    let data = loadKeychainData(key: key)
    if data != nil {
        return String(data: data!, encoding: .utf8)
    }
    return nil
}

/**
 Load the Int value previously saved in the keychain.
 Note: The "Keychain Sharing" capability for the app needs to be turned on
 in order for this operation be successful.
 - parameter key: The key for the Int value.
 - returns: The previously stored Int value. Or, nil if there was no value saved for this key.
 */
func loadKeychainInt(key: String) -> Int? {
    let s = loadKeychainString(key: key)
    if s != nil {
        // let sb: String = s!
        return Int.init(s!)
    }
    return nil
}

// First implementation using kSecClassGenericPassword.
// Device runs fine without turning on the "Keychain Sharing" capability.
// However, simulator needs to turn on "Keychain Sharing" capbility.
// Otherwise, error -34018 is returned.
private func saveKeychainData(key: String, data: Data) {
    removeKeychainValue(key: key)
    
    var keychainQuery: [String: AnyObject] = [String: AnyObject]()
    keychainQuery[kSecClass as String] = kSecClassGenericPassword
    keychainQuery[kSecAttrAccount as String] = key as AnyObject
    keychainQuery[kSecValueData as String] = data as AnyObject
    keychainQuery[kSecAttrAccessible as String] = kSecAttrAccessibleAlwaysThisDeviceOnly
    
    let result = SecItemAdd(keychainQuery as CFDictionary, nil)
    print("result = \(result)")
}

private func loadKeychainData(key: String) -> Data? {
    
    var keychainQuery: [String: AnyObject] = [String: AnyObject]()
    keychainQuery[kSecClass as String] = kSecClassGenericPassword
    keychainQuery[kSecAttrAccount as String] = key as AnyObject
    keychainQuery[kSecMatchLimit as String] = kSecMatchLimitOne
    keychainQuery[kSecReturnData as String] = kCFBooleanTrue
    
    var resultValue: AnyObject?
    
    let result = withUnsafeMutablePointer(to: &resultValue) {
        SecItemCopyMatching(keychainQuery as CFDictionary, UnsafeMutablePointer($0))
    }
    
    if result == noErr {
        return resultValue as? Data
    }
    
    return nil
}


func removeKeychainValue(key: String) {
    let keychainQuery: NSMutableDictionary = NSMutableDictionary(
        objects: [kSecClassGenericPassword as NSString, key],
        forKeys: [kSecClass as NSString, kSecAttrAccount as NSString])
    SecItemDelete(keychainQuery)
}

// Second implementation using kSecClassKey.
// Both device and simulator need to turn on "Keychain Sharing" capbility.
// Otherwise, error -34018 is returned.
private func saveKeychainData1(key: String, data: Data) {
    removeKeychainValue(key: key)
    
    var keychainQuery: [String: AnyObject] = [String: AnyObject]()
    keychainQuery[kSecClass as String] = kSecClassKey
    keychainQuery[kSecAttrApplicationTag as String] = key as AnyObject
    
    keychainQuery[kSecValueData as String] = data as AnyObject
    keychainQuery[kSecAttrAccessible as String] = kSecAttrAccessibleAlwaysThisDeviceOnly
    
    let result = SecItemAdd(keychainQuery as CFDictionary, nil)
    print("result = \(result)")
}

private func loadKeychainData1(key: String) -> Data? {
    
    var keychainQuery: [String: AnyObject] = [String: AnyObject]()
    keychainQuery[kSecClass as String] = kSecClassKey
    keychainQuery[kSecAttrApplicationTag as String] = key as AnyObject
    keychainQuery[kSecAttrAccessible as String] = kSecAttrAccessibleAlwaysThisDeviceOnly
    keychainQuery[kSecMatchLimit as String] = kSecMatchLimitOne
    keychainQuery[kSecReturnData as String] = kCFBooleanTrue
    keychainQuery[kSecReturnAttributes as String] = kCFBooleanTrue
    
    var resultValue: AnyObject?
    
    let result = withUnsafeMutablePointer(to: &resultValue) {
        SecItemCopyMatching(keychainQuery as CFDictionary, UnsafeMutablePointer($0))
    }
    
    if result == noErr {
        let resultDict:[String: NSObject] = resultValue as! [String: NSObject]
        return resultDict[kSecValueData as String] as? Data
    }
    
    return nil
}

private func removeKeychainValue1(key: String) {
    var keychainQuery: [String: AnyObject] = [String: AnyObject]()
    keychainQuery[kSecClass as String] = kSecClassKey
    keychainQuery[kSecAttrApplicationTag as String] = key as AnyObject
    
    SecItemDelete(keychainQuery as CFDictionary)
}
