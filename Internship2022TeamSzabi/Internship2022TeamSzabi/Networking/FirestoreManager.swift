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

class FirestoreManager {
    static let db = Firestore.firestore()
    static let auth = Auth.auth()
}
