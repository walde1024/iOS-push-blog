//
//  OnBoardingViewController.swift
//  iOS-on-boarding
//
//  Created by Schlegel, Waldemar on 19/07/2017.
//  Copyright © 2017 SAP. All rights reserved.
//

import UIKit
import SAPFiori
import LocalAuthentication

class OnBoardingViewController: UIViewController, FUIWelcomeControllerDelegate, BasicAuthViewControllerDelegate, Notifier {
    
    struct Storyboard {
        static let showFUIWelcomeScreen = "showFUIWelcomeScreen"
        static let showLoginScreen = "showLoginScreen"
        static let showCreatePasscodeScreen = "showCreatePasscodeScreen"
        static let showFUIPasscodeInput = "showFUIPasscodeInput"
        static let split = "Split"
    }
    
    private var passcodeDelegate: PasscodeControllerDelegate!
    private var welcomeDelegate: WelcomeControllerDelegate!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        welcomeDelegate = WelcomeControllerDelegate(onboardingViewController: self)
        passcodeDelegate = PasscodeControllerDelegate(onboardingViewController: self)
        
        self.performSegue(withIdentifier: Storyboard.showFUIWelcomeScreen, sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - BasicAuthViewControllerListener
    
    func onLoginSuccess(username: String, password: String) {
        passcodeDelegate.password = password
        passcodeDelegate.username = username
        
        self.performSegue(withIdentifier: Storyboard.showCreatePasscodeScreen, sender: self)
    }
    
    // MARK: - Navigation
    
    func showLoginScreen() {
        self.performSegue(withIdentifier: Storyboard.showLoginScreen, sender: self)
    }
    
    func showAppHomeScreen() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let splitView = storyboard.instantiateViewController(withIdentifier: Storyboard.split) as! UISplitViewController
        let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
        
        splitView.delegate = appDelegate
        appDelegate.window!.rootViewController = splitView
    }
    
    func showPasscodeInputScreen() {
        self.performSegue(withIdentifier: Storyboard.showFUIPasscodeInput, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Storyboard.showFUIWelcomeScreen {
            let vc = segue.destination as! FUIWelcomeScreen
            vc.state = .isConfigured
            vc.delegate = welcomeDelegate
            vc.isDemoAvailable = false
            vc.primaryActionButton.setTitle("Login", for: .normal)
            
            vc.detailLabel.text = "SAP Cloud Platform iOS SDK On Boarding Sample Application"
        }
        else if segue.identifier == Storyboard.showLoginScreen {
            let nvc = segue.destination as! UINavigationController
            let vc = nvc.visibleViewController as! BasicAuthViewController
            vc.setBasicAuthDelegate(self);
        }
        else if segue.identifier == Storyboard.showCreatePasscodeScreen {
            let nvc = segue.destination as! UINavigationController
            let vc = nvc.visibleViewController as! FUIPasscodeCreateController
            vc.canEnableTouchID = true;
            
            vc.delegate = passcodeDelegate
        }
        else if segue.identifier == Storyboard.showFUIPasscodeInput {
            let nvc = segue.destination as! UINavigationController
            let vc = nvc.visibleViewController as! FUIPasscodeInputController
            vc.isToShowCancelBarItem = true
            
            vc.delegate = passcodeDelegate
        }
    }
    
}
