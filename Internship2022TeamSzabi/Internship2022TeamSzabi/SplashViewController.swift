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
        
        // nsuserdefaults here
        let isLoggedIn = true
        
        if isLoggedIn {
            perform(#selector(showTabBarController), with: nil, afterDelay: 2.00)
        } else {
            perform(#selector(showLoginViewController), with: nil, afterDelay: 2.00)
        }
    }
    
    @objc func showLoginViewController() {
        let loginViewController = LoginViewController()
        loginViewController.modalPresentationStyle = .fullScreen
        present(loginViewController, animated: true, completion: {
        })
    }
    
    @objc func showTabBarController() {
        let tabBarController = TabBarController()
        tabBarController.modalPresentationStyle = .fullScreen
        present(tabBarController, animated: true, completion: {
        })
    }
}
