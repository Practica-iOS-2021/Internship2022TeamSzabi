//
//  RegisterViewController.swift
//  Internship2022TeamSzabi
//
//  Created by Alin Huzmezan on 26.07.2022.
//

import UIKit

class RegisterViewController: UIViewController {
    @IBOutlet private weak var formView: UIView!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var nameTextField: UITextField!
    @IBOutlet private weak var personalIDTextfield: UITextField!
    @IBOutlet private weak var passwordTextfield: UITextField!
    @IBOutlet private weak var studentIDTextfield: UITextField!
    @IBOutlet private weak var registerButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupAppearence()
    }
    
    @IBAction private func emailChanged(_ sender: Any) {
        validateForm()
    }
    @IBAction func nameChanged(_ sender: Any) {
        validateForm()
    }
    @IBAction private func passwordChanged(_ sender: Any) {
        validateForm()
    }
    @IBAction private func personalIDChanged(_ sender: Any) {
        validateForm()
    }
    @IBAction private func studentIDChanged(_ sender: Any) {
        validateForm()
    }
    @IBAction private func submitAction(_ sender: Any) {
        handleFormValidation()
    }
    
    private func handleRegister() {
        print("ready to register")
        guard let emailText = emailTextField.text,
              let nameText = nameTextField.text,
              let personalIDText = personalIDTextfield.text,
              let studentIDText = studentIDTextfield.text,
              let passwordText = passwordTextfield.text
        else { return }
        
        let newUser = UserModel(
            email: emailText,
            name: nameText,
            personalID: personalIDText,
            studentID: studentIDText,
            photo: "")
        
        AuthApiManager.sharedInstance.registerUser(
            newUser: newUser, password: passwordText) { authenticated, errorString in
            if let error = errorString {
                self.alertError(error)
            } else if authenticated {
                // save to NSDefault
                // redirect to tabBarController
                let appDelegate = UIApplication.shared.delegate as? AppDelegate
                appDelegate?.window?.rootViewController = TabBarController()
            }
        }}
    
    private func handleFormValidation() {
        guard validateForm() else { return }
        
        // all validations passed
        handleRegister()
    }
    
    // MARK: - Check against invalidations in form
    @discardableResult
    private func validateForm() -> Bool {
        // supose form initially valid
        var valid = true
        
        // 1) if not all textFields filled
        formView.subviews.forEach { view in
            if let textField = view as? UITextField {
                if textField.text?.isEmpty ?? true {
                    valid = false
                }
            }
        }
        
        // get text from need-be valid textFields
        guard let emailText = emailTextField.text,
              let personalIDText = personalIDTextfield.text,
              let passwordText = passwordTextfield.text,
              let nameText = nameTextField.text
        else { return false }
        
        // 2) if said texts aren't valid
        guard checkInputError(text: emailText,
                              validationFunction: validateEmail),
              checkInputError(text: nameText,
                              validationFunction: validateName),
              checkInputError(text: personalIDText,
                              validationFunction: validatePersonalID),
              checkInputError(text: passwordText,
                              validationFunction: validatePassword)
        else { return false }
        
        // enable/disable 'register' button and return verdict
        registerButton.isEnabled = valid
        return valid
    }
    
    // MARK: - Validation methods
    // checkInputError uses given 'text'
    // validated by given 'validationFunction'
    func checkInputError(text: String, validationFunction: (String) -> String?) -> Bool {
        if let foundError = validationFunction(text) {
            errorLabel.text = foundError
            errorLabel.isHidden = false
            return false
        }
        errorLabel.text = ""
        errorLabel.isHidden = true
        return true
    }
    
    func validateEmail(_ email: String) -> String? {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        // must be of valid type *@*.*
        guard emailPred.evaluate(with: email) else {
            return "* Invalid email."
        }
        // valid email
        return nil
    }
    
    func validatePassword(_ password: String) -> String? {
        let passwordRegEx = "^(?=.{8,})(?=.*[A-Z])(?=.*[@#$%^&+=!]).*$"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
        // must be of valid type:
        //  at least 1 uppercase character
        //  at least 1 special character
        //  at leat 8 characters total
        guard emailPred.evaluate(with: password) else {
            return """
* Invalid password.
 - Must contain at least:
    1 uppercase letter
    1 special character
 - Must be at least 8 characters long.
"""
        }
        // valid password
        return nil
    }
    
    func validateName(_ name: String) -> String? {
        let personalIDRegEx = "^([a-zA-Z0-9]+(\\s|-))*[a-zA-Z0-9]+$"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", personalIDRegEx)
        // must be of valid type:
        // 1 space or 1 '-' between characters
        guard emailPred.evaluate(with: name) else {
            return """
*Invalid Name.
 - Can only be separated by single space or '-'.
"""
        }
        // valid password
        return nil
    }
    
    func validatePersonalID(_ personalID: String) -> String? {
        let personalIDRegEx = "^[1-9]\\d{2}(0[1-9]|1[0-2])(0[1-9]|[12]\\d|3[01])" +
        "(0[1-9]|[1-4]\\d|5[0-2]|99)(00[1-9]|0[1-9]\\d|[1-9]\\d\\d)\\d$"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", personalIDRegEx)
        // must be of valid type:
        // 1 space or 1 '-' between characters
        guard emailPred.evaluate(with: personalID) else {
            return """
*Invalid personal ID.
 - Must be a valid Romanian CNP.
"""
        }
        // valid password
        return nil
    }
    
    // MARK: - Alert for errors
    func alertError(_ error: String) {
        let dialogMessage = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        dialogMessage.addAction(okAction)
        present(dialogMessage, animated: true, completion: nil)
    }
    
    // MARK: - Appearence methods
    private func setupAppearence() {
        // for each view in subviews of type 'UITextField':
        // set style to said view
        formView.subviews.forEach { view in
            guard let textField = view as? UITextField else { return }
            addStyleToTextfield(textField: textField)
        }
        
        addStyleToButton(button: registerButton)
        passwordTextfield.isSecureTextEntry = true
        errorLabel.isHidden = true
        registerButton.isEnabled = false
    }
    
    func addStyleToButton(button: UIButton) {
        // shadow
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 1, height: 4)
        button.layer.shadowRadius = 2
        button.layer.shadowOpacity = 0.2
    }
    
    func addStyleToTextfield(textField: UITextField) {
        // border bottom
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: textField.frame.height - 1, width: textField.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor(named: "TextFieldBorderColor")?.cgColor
        textField.borderStyle = UITextField.BorderStyle.none
        textField.layer.addSublayer(bottomLine)
    }
}
