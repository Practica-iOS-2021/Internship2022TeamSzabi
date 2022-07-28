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

    override func viewDidLoad() {
        super.viewDidLoad()

        view.subviews.forEach { gotView in
            guard let textField = gotView as? UITextField else { return }
            addStyleToTextfield(textField: textField)
        }

        passwordTextfield.isSecureTextEntry = true
        addStyleToButton(button: registerButton)
        registerButton.isEnabled = false
    }

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

    private func handleFormValidation() {
        let emailError = validateEmail(emailTextField.text!)
        let passwordError = validatePassword(passwordTextfield.text!)

        guard emailError == nil else {
            alertError(emailError!)
            return
        }
        guard passwordError == nil else {
            alertError(passwordError!)
            return
        }

        // all validations passed
        handleRegister()
    }

    private func handleRegister() {
        print("ready to register")
    }

    func validateEmail(_ email: String) -> String? {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        // must be of valid type *@*.*
        guard emailPred.evaluate(with: email) else {
            return "Invalid email."
        }
        // valid email
        return nil
    }

    func validatePassword(_ password: String) -> String? {
        let passwordRegEx = "^(?=.{8,})(?=.*[A-Z])(?=.*[@#$%^&+=]).*$"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", passwordRegEx)
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
        for gotView in self.view.subviews {
            guard let textField = gotView as? UITextField else { continue }
            if textField.text?.isEmpty ?? true {
                foundEmpty = true
                break
            }
        }
        // enable/disable 'register' button
        registerButton.isEnabled = !foundEmpty
    }

    func alertError(_ error: String) {
        let dialogMessage = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        dialogMessage.addAction(okAction)
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

    func addStyleToTextfield(textField: UITextField) {
        // border bottom
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(
            x: 0.0,
            y: textField.frame.height - 1,
            width: textField.frame.width,
            height: 1.0)
        bottomLine.backgroundColor = UIColor(named: "TextFieldBorderColor")?.cgColor
        textField.borderStyle = UITextField.BorderStyle.none
        textField.layer.addSublayer(bottomLine)
    }
}

// MARK: - for keyboard issues
extension RegisterViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // dismiss keyboard
        emailTextField.resignFirstResponder()
        personalIDTextfield.resignFirstResponder()
        studentIDTextfield.resignFirstResponder()
        passwordTextfield.resignFirstResponder()
        return true
    }
}
