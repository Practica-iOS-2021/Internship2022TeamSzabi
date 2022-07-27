//
//  RegisterViewController.swift
//  LoginForm
//
//  Created by Alin Huzmezan on 26.07.2022.
//

import UIKit

class RegisterViewController: UIViewController {
    // outlets
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var personalIDTextfield: UITextField!
    @IBOutlet private weak var passwordTextfield: UITextField!
    @IBOutlet private weak var studentIDTextfield: UITextField!
    @IBOutlet private weak var registerButton: UIButton!
   
    // input validation error strings
    private var emailError: String = ""
    private var passwordError: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        // Add style to all textfields
        for textField in self.view.subviews {
            if type(of: textField) == UITextField.self
            {
                addStyleToTextfield(textField: textField as! UITextField)
            }
        }
        // Add style to button
        addStyleToButton(button: registerButton)
        // Set initial state of 'registerButton' to disabled
        registerButton.isEnabled = false
    }
    
    // actions
    @IBAction private func emailChanged(_ sender: Any) {
        validateIfFormFilled()
    }
    @IBAction private func passwordChanged(_ sender: Any) {
        validateIfFormFilled()
    }
    @IBAction private func personalIDChanged(_ sender: Any) {
        validateIfFormFilled()
    }
    @IBAction private func studentIDChanged(_ sender: Any) {
        validateIfFormFilled()
    }
    @IBAction private func submitAction(_ sender: Any) {
        handleFormValidation()
    }
    
    func handleFormValidation() {
        let email = emailTextField.text ?? ""
        let password =  passwordTextfield.text ?? ""
        
        emailError = validateEmail(email) ?? ""
        passwordError = validatePassword(password) ?? ""
        
        if emailError != ""  {
            alertError(emailError)
        } else if passwordError != "" {
            alertError(passwordError)
        }
        else {
            handleRegister()
        }
    }
    
    func handleRegister() {
        print("ready to register")
    }
    
    func validateEmail(_ email: String) -> String? {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        // must be of valid type *@*.*
        guard emailPred.evaluate(with: email) else {
            return "Invalid email."
        }
        // valid email
        return nil
    }
    
    func validatePassword(_ password: String) -> String? {
        let passwordRegEx = "^(?=.{8,})(?=.*[A-Z])(?=.*[@#$%^&+=]).*$"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", passwordRegEx)
        // must be of valid type:
        //  at least 1 uppercase character
        //  at least 1 special character
        //  at leat 8 characters total
        guard emailPred.evaluate(with: password) else {
            return "Invalid password."
        }
        // valid password
        return nil
    }
    
    func validateIfFormFilled() {
        var foundEmpty: Bool = false
        // test subvies of type UITextField if not empty
        for textField in self.view.subviews {
            if type(of: textField) == UITextField.self {
                if isEmptyTextfield(textField as! UITextField) {
                    foundEmpty = true
                    break
                }
            }
        }
        // enable/disable 'register' button
        registerButton.isEnabled = !foundEmpty
    }
    
    func isEmptyTextfield(_ textField: UITextField) -> Bool {
        if textField.text != nil {
            return textField.text!.isEmpty
        }
        return true
    }
    
    func alertError(_ error: String) {
        let dialogMessage = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        // Create OK button with action handler
        let ok = UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
        })
        dialogMessage.addAction(ok)
        self.present(dialogMessage, animated: true, completion: nil)
    }
    
    func addStyleToButton(button: UIButton) {
        // shadow
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(
            width: 1,
            height: 4)
        button.layer.shadowRadius = 2
        button.layer.shadowOpacity = 0.2
    }
    
    func addStyleToTextfield(textField: UITextField)
    {
        // border bottom
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(
            x: 0.0,
            y: textField.frame.height - 1,
            width: textField.frame.width,
            height: 1.0)
        bottomLine.backgroundColor = UIColor(
            red: 0.486,
            green: 0.478,
            blue: 0.478,
            alpha: 1).cgColor
        textField.borderStyle = UITextField.BorderStyle.none
        textField.layer.addSublayer(bottomLine)
    }
    
}
