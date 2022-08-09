//
//  UserDataApiManager.swift
//  Internship2022TeamSzabi
//
//  Created by Cristian Vasile Kui-cs on 04.08.2022.
//

import Foundation
import FirebaseFirestore

class DataApiManager {
    static let sharedUserData = DataApiManager()
    
    // MARK: - fetch UserData
    func fetchUserData(completion: @escaping (UserModel?, String?) -> Void) {
        guard let uid = FirestoreManager.auth.currentUser?.uid else {
            completion(nil, "User is not found")
            return
        }
        let userRefrence = FirestoreManager.dbConn.collection(usersCollection).document(uid)
        userRefrence.getDocument { document, error in
            if let error = error {
                completion(nil, error.localizedDescription)
                return
            }
            guard let document = document, document.exists else {
                completion(nil, "Cannot assign data to document")
                return
            }
            let data = document.data()
            let email = data?["email"] as? String ?? ""
            let name = data?["name"] as? String ?? ""
            let personalID = data?["personalID"] as? String ?? ""
            let photo = data?["photo"] as? String ?? ""
            let studentID = data?["studentID"] as? String ?? ""
            
            let currentUser = UserModel(email: email, name: name, personalID: personalID,
                                        studentID: studentID, photo: photo)
            completion(currentUser, nil)
        }
    }
}
