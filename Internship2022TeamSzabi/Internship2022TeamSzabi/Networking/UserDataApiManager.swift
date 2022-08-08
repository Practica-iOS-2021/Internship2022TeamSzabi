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
    func fetchUserData(completion: @escaping (UserModel?) -> Void) {
        guard let uid = FirestoreManager.auth.currentUser?.uid else {
            completion(nil)
            return
        }
        let userRefrence = FirestoreManager.dbConn.collection(usersCollection).document(uid)
        userRefrence.getDocument { document, _  in
            if let document = document, document.exists {
                let data = document.data()
                let email = data?["email"] as? String ?? ""
                let name = data?["name"] as? String ?? ""
                let personalID = data?["personalID"] as? String ?? ""
                let photo = data?["photo"] as? String ?? ""
                let studentID = data?["studentID"] as? String ?? ""
                
                let currentUser = UserModel(email: email, name: name, personalID: personalID,
                                            studentID: studentID, photo: photo)
                completion(currentUser)
            } else {
                completion(nil)
            }
        }
    }
}
