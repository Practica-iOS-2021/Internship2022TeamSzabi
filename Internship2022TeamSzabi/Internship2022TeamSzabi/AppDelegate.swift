//
//  AppDelegate.swift
//  Internship2022TeamSzabi
//
//  Created by Szabolcs Orban on 25.07.2022.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        
        // MARK: - Assigning initial display view
        window = UIWindow()
        window?.frame = UIScreen.main.bounds
        let navigationController = UINavigationController()
        let mainView = LoginViewController()
        navigationController.viewControllers = [mainView]
        window?.rootViewController = navigationController
        window?.frame = UIScreen.main.bounds
        window?.makeKeyAndVisible()
        return true
    }
}
