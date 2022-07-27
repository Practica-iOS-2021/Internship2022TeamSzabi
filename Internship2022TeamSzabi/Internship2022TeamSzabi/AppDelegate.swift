//
//  AppDelegate.swift
//  Internship2022TeamSzabi
//
//  Created by Szabolcs Orban on 25.07.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        // ============================================================

                self.window = UIWindow(frame: UIScreen.main.bounds)

                self.window?.rootViewController = LoginViewController()
               
                self.window?.makeKeyAndVisible()

        // ============================================================
        return true
    }

}

