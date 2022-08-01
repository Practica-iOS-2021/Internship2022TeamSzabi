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
        window?.rootViewController = TabBarController()
        window?.makeKeyAndVisible()
        
        print("-------------------------------")
        let newUser: UserModel = UserModel(
            email: "test@222.com",
            name: "test",
            personalID: "test",
            studentID: "test",
            password: "123456")
        
        let error = AuthApiManager.createUser(newUser: newUser)
        print(error ?? "No error.")
        print("-------------------------------")

        return true
    }
}
