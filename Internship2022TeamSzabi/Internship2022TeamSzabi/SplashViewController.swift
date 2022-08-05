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
        let defaults = UserDefaults.standard
        if defaults.bool(forKey: "isUserLoggedIn") {
            perform(#selector(showTabBarController), with: nil, afterDelay: 1.00)
        }
        perform(#selector(showLoginViewController), with: nil, afterDelay: 1.00)
    }
    
    @objc func showLoginViewController() {
        let loginViewController = LoginViewController()
        loginViewController.modalPresentationStyle = .fullScreen
        present(loginViewController, animated: true)
    }
    
    @objc func showTabBarController() {
        let tabBarController = TabBarController()
        tabBarController.modalPresentationStyle = .fullScreen
        present(tabBarController, animated: true)
    }
}
