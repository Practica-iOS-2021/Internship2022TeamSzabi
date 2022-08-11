//
//  LoginViewController.swift
//  Internship2022TeamSzabi
//
//  Created by Andreea Laura Bogdan on 26.07.2022.
//

import UIKit

final class LoginViewController: BaseViewController, UITextFieldDelegate {
    @IBOutlet private var loginLabel: UILabel!
    @IBOutlet private var emailLabel: UILabel!
    @IBOutlet private var passwordLabel: UILabel!
    @IBOutlet private var notRegisteredLabel: UILabel!
    @IBOutlet private var validationLabel: UILabel!
    @IBOutlet private var emailTextField: UITextField!
    @IBOutlet private var passwordTextField: UITextField!
    @IBOutlet private var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dismissKeyboard()
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        // alert label is initially hidden from the user
        validationLabel.isHidden = true
        
        // calling the method for textfield bottom border
        bottomBorder(textFields: emailTextField)
        bottomBorder(textFields: passwordTextField)
        
        // calling the method for loginButton shadow
        buttonShadow(button: loginButton)
    }
    
    @IBAction private func loginButton(_ sender: UIButton) {
        // validation for empty email textfield
        guard let email = emailTextField.text, !email.isEmpty else {
            validationLabel.isHidden = false
            validationLabel.text = "Please enter Email"
            return
        }
        
        // validation for valid email format
        if let email = emailTextField.text, !isValidEmail(emailAddress: email) {
            validationLabel.isHidden = false
            validationLabel.text = "Email is invalid"
        } else {
            validationLabel.isHidden = true
        }
        
        // validation for empty password textfield
        guard let password = passwordTextField.text, !password.isEmpty else {
            validationLabel.isHidden = false
            validationLabel.text = "Please enter Password"
            return
        }
        
        startLoadingIndicator()
        AuthApiManager.sharedInstance.signin(email: email, password: password) { success, _ in
            if success {
                StorageManager.shared.setUserLoggedIn(value: true)
                self.validationLabel.isHidden = true
                let appDelegate = UIApplication.shared.delegate as? AppDelegate
                appDelegate?.window?.rootViewController = TabBarController()
            } else {
                StorageManager.shared.setUserLoggedIn(value: false)
                self.invalidMessage()
            }
        }
        stopLoadingIndicator()
    }
    
    @IBAction private func signUpButton(_ sender: UIButton) {
        let viewController = RegisterViewController()
        viewController.modalPresentationStyle = .fullScreen
        present(viewController, animated: true)
    }
    
    // email RegEx function to verify if the email address introduced by the user is valid
    func isValidEmail(emailAddress: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}"
        let emailTest = NSPredicate( format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailAddress)
    }
    
    // method for the customization of the emailTextField and passwordTextField to only have a black bottom border
    func bottomBorder(textFields: UITextField) {
        let spaceView = UIView()
        textFields.addSubview(spaceView)
        textFields.borderStyle = UITextField.BorderStyle.none
        spaceView.backgroundColor = .black
        spaceView.translatesAutoresizingMaskIntoConstraints = false
        spaceView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        spaceView.leadingAnchor.constraint(equalTo: textFields.leadingAnchor).isActive = true
        spaceView.trailingAnchor.constraint(equalTo: textFields.trailingAnchor).isActive = true
        spaceView.bottomAnchor.constraint(equalTo: textFields.bottomAnchor, constant: 3).isActive = true
    }
    
    // method for the shadow of the login button
    func buttonShadow(button: UIButton) {
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        button.layer.shadowOpacity = 0.8
        button.layer.shadowRadius = 0.0
        button.layer.masksToBounds = false
    }
    
    func invalidMessage() {
        validationLabel.isHidden = false
        validationLabel.text = "Invalid email or password."
    }
    
    func dismissKeyboard() {
        // this allows the user to dismiss the keyboard by tapping anywhere on the screen
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
}
