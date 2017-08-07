//
//  WelcomeControllerDelegate.swift
//  iOS-on-boarding
//
//  Created by Schlegel, Waldemar on 20.07.17.
//  Copyright © 2017 SAP. All rights reserved.
//

import Foundation
import SAPFiori

class WelcomeControllerDelegate: FUIWelcomeControllerDelegate {
    
    private weak var onboardingViewController: OnBoardingViewController?
    
    private weak var welcomeController: FUIWelcomeController?
    
    private var loadingIndicator: FUILoadingIndicatorView?
    
    init(onboardingViewController: OnBoardingViewController) {
        self.onboardingViewController = onboardingViewController
    }
    
    struct Storyboard {
        static let showLoginScreen = "showLoginScreen"
    }
    
    func shouldContinueUserOnboarding(_ welcomeController: FUIWelcomeController) {
        self.welcomeController = welcomeController
        
        if AppLogonHelper.userCredentialsAreAvailableInTheKeychain() {
            onboardingViewController?.showPasscodeInputScreen();
        } else {
            onboardingViewController?.showLoginScreen();
        }
    }
    
    private func showLoadingIndicator() {
        if let welcomeController = welcomeController {
            if self.loadingIndicator == nil {
                let indicator = FUILoadingIndicatorView(frame: welcomeController.view.frame)
                indicator.text = "Logging in..."
                self.loadingIndicator = indicator
            }
            let indicator = self.loadingIndicator!
            
            DispatchQueue.main.async {
                welcomeController.view.addSubview(indicator)
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







