//
//  StorageManager.swift
//  Internship2022TeamSzabi
//
//  Created by Cristian Vasile Kui-cs on 05.08.2022.
//

import Foundation

class StorageManager {
    static let shared = StorageManager()
    
    private  let defaults = UserDefaults.standard
    private  let isUserLoggedIn = "isUserLoggedIn"
    
    func userLoggedIn() -> Bool {
        return defaults.bool(forKey: isUserLoggedIn)
    }
    
    func setUserLoggedIn(value: Bool) {
        defaults.set(value, forKey: isUserLoggedIn)
    }
}
