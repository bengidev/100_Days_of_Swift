//
//  ViewController.swift
//  Secret Swift
//
//  Created by Bambang Tri Rahmat Doni on 31/10/23.
//

import LocalAuthentication
import UIKit

class ViewController: UIViewController {
    @IBOutlet var secret: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupApplicationState()
        setupKeyboardNotification()
    }


    @IBAction func authenticateTapped(_ sender: UIButton) {
        let context = LAContext()
        let reason = "Identify yourself!"
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) {
                [weak self] success, error  in
                
                DispatchQueue.main.async {
                    if success {
                        self?.unlockSecretMessage()
                    } else {
                        self?.showAlert(title: "Authentication Failed",
                                        message: "You could not be verified, please try again.")
                    }
                }
            }
        } else {
            showAlert(title: "Biometry Unavailable",
                      message: "Your device is not configured for biometric authentication.")
        }
    }
    
    private func setupNavigation() -> Void {
        title = "Nothing to see here"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "lock.doc"),
                                                            style: .plain,
                                                            target: self,
                                                            action: #selector(saveSecretMessage))
    }
    
    private func setupKeyboardNotification() -> Void {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self,
                                       selector: #selector(adjustForKeyboard),
                                       name: UIResponder.keyboardWillHideNotification,
                                       object: nil)
        notificationCenter.addObserver(self,
                                       selector: #selector(adjustForKeyboard),
                                       name: UIResponder.keyboardWillChangeFrameNotification,
                                       object: nil)
    }
    
    private func setupApplicationState() -> Void {
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self,
                                       selector: #selector(saveSecretMessage),
                                       name: UIApplication.willResignActiveNotification,
                                       object: nil)
    }
    
    private func showAlert(title: String? = nil,
                           message: String? = nil,
                           style: UIAlertController.Style? = .alert) -> Void {
        let ac = UIAlertController(title: title, message: message, preferredStyle: style ?? .alert)
        ac.addAction(UIAlertAction(title: "OK", style: .default))
        present(ac, animated: true)
    }
    
    @objc private func adjustForKeyboard(notification: Notification) -> Void {
        guard let keyboardValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue else { return }
        
        let keyboardScreenEndFrame = keyboardValue.cgRectValue
        let keyboardViewEndFrame = view.convert(keyboardScreenEndFrame, from: view.window)
        
        if notification.name == UIResponder.keyboardWillHideNotification {
            secret.contentInset = .zero
        } else {
            secret.contentInset = UIEdgeInsets(top: 0,
                                               left: 0,
                                               bottom: keyboardViewEndFrame.height - view.safeAreaInsets.bottom,
                                               right: 0)
        }
        
        secret.scrollIndicatorInsets = secret.contentInset
        
        let selectedRange = secret.selectedRange
        secret.scrollRangeToVisible(selectedRange)
    }
    
    @objc private func saveSecretMessage() -> Void {
        guard !self.secret.isHidden else { return }
        
        KeychainWrapper.standard.set(secret.text, forKey: "SecretMessage")
        
        UIView.animate(withDuration: 1) { [weak self] in
            self?.title = "Nothing to see here"
            
            self?.secret.resignFirstResponder()
            self?.secret.isHidden = true
        }
    }
    
    @objc private func unlockSecretMessage() -> Void {
        UIView.animate(withDuration: 1) { [weak self] in
            self?.title = "Secret stuff!"
            
            self?.secret.isHidden = false
            self?.secret.text = KeychainWrapper.standard.string(forKey: "SecretMessage") ?? ""
        }
    }
}
