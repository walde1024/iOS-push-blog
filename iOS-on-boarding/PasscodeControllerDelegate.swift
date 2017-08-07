//
//  PasscodeControllerDelegate.swift
//  iOS-on-boarding
//
//  Created by Schlegel, Waldemar on 20.07.17.
//  Copyright © 2017 SAP. All rights reserved.
//

import Foundation
import SAPFiori

class PasscodeControllerDelegate: FUIPasscodeControllerDelegate {
    
    private weak var onboardingViewController: OnBoardingViewController?
    
    private weak var passcodeController: SAPFiori.FUIPasscodeController?
    
    private var loadingIndicator: FUILoadingIndicatorView?
    
    public var password: String?
    public var username: String?
    
    init(onboardingViewController: OnBoardingViewController) {
        self.onboardingViewController = onboardingViewController
    }
    
    func shouldTryPasscode(_ passcode: String, forInputMode inputMode: SAPFiori.FUIPasscodeInputMode, fromController passcodeController: SAPFiori.FUIPasscodeController) throws {
        self.passcodeController = passcodeController
        
        if inputMode == .create {
            AppLogonHelper.storeUserCredentials(username: username!, password: password!, passcode: passcode, maxPasscodeRetries: passcodePolicy().retryLimit)
            
            passcodeController.dismiss(animated: true) {
                self.onboardingViewController?.showAppHomeScreen()
            }
            
            return
        }
        else if inputMode == .match {
            guard AppLogonHelper.areThereRemainingPasscodeRetries() else {
                throw FUIPasscodeControllerError.invalidPasscode(code: "Passcode Mismatch.", triesRemaining: 0)
            }
            
            do {
                try AppLogonHelper.tryPasscodeLogon(with: passcode) { [weak self] (username, password) in
                    self?.performBasicAuthentication(username: username, password: password)
                }
            }
            catch AppLogonHelper.AppLogonError.passcodeMismatch(let remainingRetries) {
                throw FUIPasscodeControllerError.invalidPasscode(code: "Passcode Mismatch.", triesRemaining: remainingRetries)
            }
        }
    }
    
    public func didCancelPasscodeEntry(fromController passcodeController: SAPFiori.FUIPasscodeController) {
        passcodeController.dismiss(animated: true, completion: nil)
    }
    
    public func didSkipPasscodeSetup(fromController passcodeController: SAPFiori.FUIPasscodeController) {
        
    }
    
    public func shouldResetPasscode(fromController passcodeController: SAPFiori.FUIPasscodeController) {
        AppLogonHelper.resetUserCredentials()
        passcodeController.dismiss(animated: true, completion: nil)
    }
    
    public func passcodePolicy() -> SAPFiori.FUIPasscodePolicy {
        var policy: FUIPasscodePolicy = FUIPasscodePolicy();
        policy.retryLimit = 3
        
        return policy;
    }
    
    // Mark: - Logon for Online Mode
    
    private func performBasicAuthentication(username: String, password: String) {
        showLoadingIndicator()
        
        ESPMService.shared.performBasicAuthentication(username: username, password: password) { (success, erroMessage) in
            self.hideLoadingIndicator()
            
            if success {
                self.onboardingViewController?.showAppHomeScreen();
            }
            else {
                if let message = erroMessage {
                    self.onboardingViewController?.displayAlert(title: "Logon process failed!", message: message)
                }
            }
        }
    }
    
    // MARK: - Loading Indicator
    
    private func showLoadingIndicator() {
        if let passcodeController = passcodeController {
            if self.loadingIndicator == nil {
                let indicator = FUILoadingIndicatorView(frame: passcodeController.view.frame)
                indicator.text = "Logging in"
                self.loadingIndicator = indicator
            }
            let indicator = self.loadingIndicator!
            
            DispatchQueue.main.async {
                passcodeController.view.addSubview(indicator)
                indicator.show()
            }
        }
    }
    
    private func hideLoadingIndicator() {
        DispatchQueue.main.async {
            guard let loadingIndicator = self.loadingIndicator else {
                return
            }
            loadingIndicator.dismiss()
            loadingIndicator.removeFromSuperview()
        }
    }
}
