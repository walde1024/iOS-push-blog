//
//  AppLogonHelper.swift
//  iOS-on-boarding
//
//  Created by Schlegel, Waldemar on 13/06/2017.
//  Copyright © 2017 SAP. All rights reserved.
//

import Foundation
import LocalAuthentication

/**
 This class provides helper functions for local authentication (touchId and passcode)
 and gives access to the basic auth user credentials.
 **/
class AppLogonHelper {
    
    private static let context = LAContext()
    
    enum AppLogonError: Error {
        case maxRetriesReached
        case passcodeMismatch(remainingRetries: Int)
    }
    
    enum AppLogonKeychain {
        static let username = "usernameKey"
        static let password = "passwordKey"
        
        static let passcodeRetriesRemaining = "passcodeRetriesRemainingKey"
        static let currentPasscode = "currentPasscodeKey"
        static let passcodeRetriesLimit = "passcodeRetryLimitKey"
    }
    
    /**
     Return true if the user credentials for the basic auth are available in the keychain.
     **/
    static func userCredentialsAreAvailableInTheKeychain() -> Bool {
        let username = loadKeychainString(key: AppLogonKeychain.username)
        let password = loadKeychainString(key: AppLogonKeychain.password)
        
        guard username != nil, password != nil else {
            return false
        }
        
        return true
    }
    
    /**
     Authenticates user with touch id if touch is enabled. Completion handler returns:
     string with a potential error message for the user
     bool value which indicates if the logon was successfull.
     string with the username for the basic authentication
     string with the password for the basic authentication
     bool value which is true if the user requested a passcode fallback
     **/
    static func authenticateUserWithTouchId(completion: @escaping (String?, Bool, String?, String?, Bool) -> Void) {
        
        guard isTouchIdAvailable() else {
            completion("Touch ID not available", false, nil, nil, false)
            return
        }
        
        context.localizedFallbackTitle = "Enter Passcode"
        
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: "Logging in with Touch ID") {
            (success, evaluateError) in
            
            if success {
                let username = loadKeychainString(key: AppLogonKeychain.username)
                let password = loadKeychainString(key: AppLogonKeychain.password)
                
                DispatchQueue.main.async {
                    completion(nil, true, username, password, false)
                }
            } else {
                let message: String?
                var requestedPasswordFallback = false
                
                switch evaluateError {
                case LAError.authenticationFailed?:
                    message = "There was a problem verifying your identity."
                case LAError.userCancel?:
                    message = nil
                case LAError.userFallback?:
                    message = nil
                    requestedPasswordFallback = true
                default:
                    message = nil
                }
                
                DispatchQueue.main.async {
                    completion(message, false, nil, nil, requestedPasswordFallback)
                }
            }
        }
    }
    
    static func isTouchIdAvailable() -> Bool {
        return context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: nil)
    }
    
    // MARK: - Passcode Helper
    
    static func storeUserCredentials(username: String, password: String, passcode: String, maxPasscodeRetries: Int) {
        saveKeychainString(key: AppLogonKeychain.currentPasscode, value: passcode)
        saveKeychainInt(key: AppLogonKeychain.passcodeRetriesRemaining, value: maxPasscodeRetries)
        saveKeychainInt(key: AppLogonKeychain.passcodeRetriesLimit, value: maxPasscodeRetries)
        saveKeychainString(key: AppLogonKeychain.username, value: username)
        saveKeychainString(key: AppLogonKeychain.password, value: password)
    }
    
    static func resetUserCredentials() {
        removeKeychainValue(key: AppLogonKeychain.currentPasscode)
        removeKeychainValue(key: AppLogonKeychain.username)
        removeKeychainValue(key: AppLogonKeychain.password)
        removeKeychainValue(key: AppLogonKeychain.passcodeRetriesLimit)
        removeKeychainValue(key: AppLogonKeychain.passcodeRetriesRemaining)
    }
    
    static func areThereRemainingPasscodeRetries() -> Bool {
        let retryRemainingSaved = loadKeychainInt(key: AppLogonKeychain.passcodeRetriesRemaining)
        if retryRemainingSaved == 0 {
            return false
        }
        
        return true
    }
    
    /**
     Updates the retries count and returns the username and password with the completion handler if the passcode matches with the passcode stored in the keychain.
     
     Throws error if maximum retries are already reached or the passcode does not match.
     **/
    static func tryPasscodeLogon(with passcode: String, completion: @escaping (String, String) -> Void) throws {
        guard areThereRemainingPasscodeRetries() else {
            throw AppLogonError.maxRetriesReached
        }
        
        let passcodeInKeychain = loadKeychainString(key: AppLogonKeychain.currentPasscode)
        
        if (passcodeInKeychain == passcode) {
            let maxRetries = loadKeychainInt(key: AppLogonKeychain.passcodeRetriesLimit)
            if maxRetries != nil {
                saveKeychainInt(key: AppLogonKeychain.passcodeRetriesRemaining, value: maxRetries!)
            }
            
            let username = loadKeychainString(key: AppLogonKeychain.username)
            let password = loadKeychainString(key: AppLogonKeychain.password)
            
            //return true
            completion(username!, password!)
        }
        else {
            var retryRemaining = -1
            let retryRemainingSaved = loadKeychainInt(key: AppLogonKeychain.passcodeRetriesRemaining)
            
            if retryRemainingSaved != nil {
                retryRemaining = retryRemainingSaved!
            }
            
            if retryRemaining >= 0 {
                retryRemaining -= 1
                saveKeychainInt(key: AppLogonKeychain.passcodeRetriesRemaining, value: retryRemaining)
                
                if retryRemaining == 0 {
                    resetUserCredentials()
                }
            }
            
            throw AppLogonError.passcodeMismatch(remainingRetries: retryRemaining)
        }
    }
    
}
