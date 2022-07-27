//
//  LoginViewController.swift
//  Internship2022TeamSzabi
//
//  Created by Andreea Laura Bogdan on 26.07.2022.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var loginLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var notRegisteredLabel: UILabel!
    @IBOutlet weak var validationLabel: UILabel!
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBOutlet weak var loginButton: UIButton!
    @IBAction func loginButton(_ sender: UIButton) {
 
        // validation for empty email textfield
        guard let email = emailTextField.text, emailTextField.text?.count != 0
        else{
            validationLabel.isHidden = false
            validationLabel.text = "Please enter Email"
            return
        }
        
        // validation for valid email format
        if isValidEmail(emailAddress: email) == false {
            validationLabel.isHidden = false
            validationLabel.text = "Email is invalid"}
            else{
                validationLabel.isHidden = true
            }
        
        //validation for empty password textfield
        guard let password = passwordTextField.text,
                password.count != 0
        else{
            validationLabel.isHidden = false
            validationLabel.text = "Please enter password"
            return
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // alert label is initially hidden from the user
        validationLabel.isHidden = true
        
        //
        emailTextField.delegate = self
        passwordTextField.delegate = self
        
        // customization of the emailTextField to only have a black bottom border
        let bottomLine1 = CALayer()
        bottomLine1.frame = CGRect(x: 0.0, y: emailTextField.frame.height - 3, width: emailTextField.frame.width, height: 1.0)
        bottomLine1.backgroundColor = UIColor.black.cgColor
        emailTextField.borderStyle = UITextField.BorderStyle.none
        emailTextField.layer.addSublayer(bottomLine1)
        emailTextField.borderStyle = UITextField.BorderStyle.none
        
        // customization of the passwordTextField to only have a bottom black border
        let bottomLine2 = CALayer()
        bottomLine2.frame = CGRect(x: 0.0, y: passwordTextField.frame.height - 3, width: passwordTextField.frame.width, height: 1.0)
        bottomLine2.backgroundColor = UIColor.black.cgColor
        passwordTextField.borderStyle = UITextField.BorderStyle.none
        passwordTextField.layer.addSublayer(bottomLine2)
        passwordTextField.borderStyle = UITextField.BorderStyle.none
        
        // shadow of the login button
        loginButton.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        loginButton.layer.shadowOffset = CGSize(width: 0.0, height: 4.0)
        loginButton.layer.shadowOpacity = 0.8
        loginButton.layer.shadowRadius = 0.0
        loginButton.layer.masksToBounds = false
    }
    
    //email RegEx function to verify if the email address introduced by the user is valid
    func isValidEmail(emailAddress: String) -> Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,20}"
        let emailTest = NSPredicate( format: "SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailAddress)
    }
    
    
}
