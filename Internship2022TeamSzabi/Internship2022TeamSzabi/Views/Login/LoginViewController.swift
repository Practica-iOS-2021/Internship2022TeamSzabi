//
//  LoginViewController.swift
//  Internship2022TeamSzabi
//
//  Created by Andreea Laura Bogdan on 26.07.2022.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
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
        
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        // alert label is initially hidden from the user
        validationLabel.isHidden = true
        
        // calling the method for textfield bottom border
        bottomBorder(textFields: emailTextField)
        bottomBorder(textFields: passwordTextField)
        
        //calling the method for loginButton shadow
        buttonShadow(button: loginButton)
    }
    
    @IBAction private func loginButton(_ sender: UIButton) {
 
        // validation for empty email textfield
        guard !emailTextField.text!.isEmpty
        else {
            validationLabel.isHidden = false
            validationLabel.text = "Please enter Email"
            return
             }
       
        // validation for valid email format
        if !isValidEmail(emailAddress: emailTextField.text!) {
            validationLabel.isHidden = false
            validationLabel.text = "Email is invalid"}
        else {
                validationLabel.isHidden = true
             }
        
        // validation for empty password textfield
        guard !passwordTextField.text!.isEmpty
        else {
            validationLabel.isHidden = false
            validationLabel.text = "Please enter Password"
            return
             }
    }

    @IBAction private func signupButton(_ sender: UIButton) {
        
    }
    
    //email RegEx function to verify if the email address introduced by the user is valid
    func isValidEmail(emailAddress: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}"
        let emailTest = NSPredicate( format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailAddress)
    }
    
    // method for the customization of the emailTextField and passwordTextField to only have a black bottom border
    func bottomBorder(textFields: UITextField) {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 0.0, y: textFields.frame.height - 3, width: textFields.frame.width, height: 1.0)
        bottomLine.backgroundColor = UIColor.black.cgColor
        textFields.borderStyle = UITextField.BorderStyle.none
        textFields.layer.addSublayer(bottomLine)
        textFields.borderStyle = UITextField.BorderStyle.none
    }
    
    // method for the shadow of the login button
    func buttonShadow(button: UIButton) {
        button.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        button.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        button.layer.shadowOpacity = 0.8
        button.layer.shadowRadius = 0.0
        button.layer.masksToBounds = false
    }
    
}
