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
        var currentUser = UserModel(email: "", name: "", personalID: "", studentID: "", photo: "")
        let uid = FirestoreManager.auth.currentUser?.uid ?? ""
        let userRefrence = FirestoreManager.dbConn.collection(usersCollection).document(uid)
        userRefrence.getDocument { document, _  in
            if let document = document, document.exists {
                let data = document.data()
                    let emailData = data?["email"] as? String ?? ""
                    let nameData = data?["name"] as? String ?? ""
                    let personalIDData = data?["personalID"] as? String ?? ""
                    let photoData = data?["photo"] as? String ?? ""
                    let studentIDData = data?["studentID"] as? String ?? ""
                    
                    currentUser = UserModel(email: emailData, name: nameData, personalID: personalIDData,
                                            studentID: studentIDData, photo: photoData)
                    completion(currentUser)
            } else {
                    completion(nil)
            }
        }
    }
}
