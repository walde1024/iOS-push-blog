//
// BasicAuthViewController.swift
// iOS-on-boarding
//
// Created by SAP Cloud Platform SDK for iOS Assistant application on 18/07/17
//

import SAPFiori
import SAPFoundation
import SAPCommon

protocol BasicAuthViewControllerDelegate {
    func onLoginSuccess(username: String, password: String)
}

class BasicAuthViewController: UIViewController, UITextFieldDelegate, Notifier, LoadingIndicator {
    
    var loadingIndicator: FUILoadingIndicatorView?
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet var usernameTextField: UITextField!
    @IBOutlet var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    
    var activeTextField: UITextField?
    
    private var basicAuthListener: BasicAuthViewControllerDelegate?
    
    private var espmService = ESPMService.shared
    
    // MARK: - Actions
    
    @IBAction func onCancelLogin(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func loginButtonTapped(_ sender: AnyObject) {
        
        // Validate
        if (self.usernameTextField.text!.isEmpty || self.passwordTextField.text!.isEmpty) {
            displayAlert(title: NSLocalizedString("keyErrorLoginTitle", value: "Error", comment: "XTIT: Title of alert message about login failure."),
                         message: NSLocalizedString("keyErrorLoginBody", value: "Username or Password is missing", comment: "XMSG: Body of alert message about login failure."))
            return
        }
        
        self.showIndicator()
        self.loginButton.isEnabled = false
        
        espmService.performBasicAuthentication(username: self.usernameTextField.text!, password: self.passwordTextField.text!) { (success, message) in
            
            self.hideIndicator()
            
            if success {
                self.dismiss(animated: true) {
                    if let basicAuthListener = self.basicAuthListener {
                        basicAuthListener.onLoginSuccess(username: self.usernameTextField.text!, password: self.passwordTextField.text!)
                    }
                }
            }
            else {
                if let message = message {
                    self.displayAlert(title: NSLocalizedString("keyErrorLogonProcessFailedNoResponseTitle", value: "Logon process failed!", comment: "XTIT: Title of alert message about logon process failure."),
                                      message: message)
                }
                
                self.loginButton.isEnabled = true
            }
        }
    }
    
    //MARK: - Controller Lifecycle
    
    override func viewDidLoad() {
        self.usernameTextField.delegate = self
        self.passwordTextField.delegate = self
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    // MARK: - BasicAuthViewControllerListener
    
    func setBasicAuthDelegate(_ listener: BasicAuthViewControllerDelegate) {
        self.basicAuthListener = listener
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // Notification for keyboard show/hide
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    // MARK: Notification and TextField
    
    // Shrink Table if keyboard show notification comes
    func keyboardWillShow(notification: NSNotification) {
        self.scrollView.isScrollEnabled = true
        if let info = notification.userInfo, let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size {
            // Need to calculate keyboard exact size due to Apple suggestions
            let contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardSize.height, 0.0)
            
            self.scrollView.contentInset = contentInsets
            self.scrollView.scrollIndicatorInsets = contentInsets
            
            var aRect = self.view.frame
            aRect.size.height -= keyboardSize.height
            if let activeField = self.activeTextField, (!self.view.frame.contains(activeField.frame.origin)) {
                let scrollPoint = CGPoint(x: 0, y: activeField.frame.origin.y - keyboardSize.height)
                self.scrollView.scrollRectToVisible(activeField.frame, animated: true)
                self.scrollView.setContentOffset(scrollPoint, animated: true)
            }
        }
    }
    
    // Resize Table if keyboard hide notification comes
    func keyboardWillHide(notification: NSNotification) {
        // Once keyboard disappears, restore original positions
        let contentInsets = UIEdgeInsetsMake(0.0, 0.0, 0.0, 0.0)
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
        self.scrollView.isScrollEnabled = false
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeTextField = nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.activeTextField?.resignFirstResponder()
        return true
    }
    
}
