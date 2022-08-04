//
//  FirestoreManager.swift
//  Internship2022TeamSzabi
//
//  Created by Alin Huzmezan on 8/2/22.
//

import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

let usersCollection = "users"

enum FirestoreManager {
    static let dbConn = Firestore.firestore()
    static let auth = Auth.auth()
}
