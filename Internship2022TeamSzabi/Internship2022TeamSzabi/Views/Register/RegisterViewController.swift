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

        setupAppearence()
    }

    @IBAction private func emailChanged(_ sender: Any) {
        validateIfFormFilled()
        guard let input = emailTextField.text else { return }
        checkForError(text: input, validationFunction: validateEmail)
    }
    @IBAction func nameChanged(_ sender: Any) {
        validateIfFormFilled()
    }
    @IBAction private func passwordChanged(_ sender: Any) {
        validateIfFormFilled()
        guard let input = passwordTextfield.text else { return }
        checkForError(text: input, validationFunction: validatePassword)
    }
    @IBAction private func personalIDChanged(_ sender: Any) {
        validateIfFormFilled()
        guard let input = personalIDTextfield.text else { return }
        checkForError(text: input, validationFunction: validatePersonalID)
    }
    @IBAction private func studentIDChanged(_ sender: Any) {
        validateIfFormFilled()
    }
    @IBAction private func submitAction(_ sender: Any) {
        handleFormValidation()
    }

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

    private func handleFormValidation() {
        guard let errorText = errorLabel.text else { return }
        guard errorText.isEmpty else { return }

        // all validations passed
        handleRegister()
    }

    private func handleRegister() {
        print("ready to register")
    }

    func checkForError(text: String, validationFunction: (String) -> String?) {
        if let foundError = validationFunction(text) {
            errorLabel.text = foundError
            errorLabel.isHidden = false
            return
        }
        errorLabel.text = ""
        errorLabel.isHidden = true
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

    func validatePersonalID(_ personalID: String) -> String? {
        let personalIDRegEx = "^([a-zA-Z0-9]+(\\s|-))*[a-zA-Z0-9]+$"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", personalIDRegEx)
        // must be of valid type:
        // 1 space or 1 '-' between characters
        guard emailPred.evaluate(with: personalID) else {
            return """
*Invalid personal ID.
 - Character(s) can only be separated by single space or '-'.
"""
        }
        // valid password
        return nil
    }


    private func validateIfFormFilled() {
        let firstEmpty = formView.subviews.first { view in
            if let textField = view as? UITextField {
                return textField.text?.isEmpty ?? true
            }
            return false
        }

        // enable/disable 'register' button
        registerButton.isEnabled = firstEmpty == nil
    }

    func alertError(_ error: String) {
        let dialogMessage = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default)
        dialogMessage.addAction(okAction)
        present(dialogMessage, animated: true, completion: nil)
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
