//
//  SplashViewController.swift
//  Internship2022TeamSzabi
//
//  Created by Cristian Vasile Kui-cs on 02.08.2022.
//

import UIKit

class SplashViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
            if StorageManager.shared.userLoggedIn() {
                StorageManager.shared.setUserLoggedIn(value: true)
                let appDelegate = UIApplication.shared.delegate as? AppDelegate
                appDelegate?.window?.rootViewController = TabBarController()
            } else {
                StorageManager.shared.setUserLoggedIn(value: false)
                let appDelegate = UIApplication.shared.delegate as? AppDelegate
                appDelegate?.window?.rootViewController = LoginViewController()
            }
        }
    }
