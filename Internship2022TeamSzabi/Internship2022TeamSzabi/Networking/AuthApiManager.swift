//
//  AuthApiManager.swift
//  Internship2022TeamSzabi
//
//  Created by Alin Huzmezan on 30.07.2022.
//

import Foundation
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class AuthApiManager {
    static let sharedInstance = AuthApiManager()
    private let db = Firestore.firestore()

    func createUser(newUser: UserModel) -> String? {
        // check if email and password were given for FirebaseAuth
        guard let email = newUser.email,
              let password = newUser.password,
              let personalID = newUser.personalID
        else { return "Not enough credentials." }

        // check if 'personalID' of newUser is already in use
        if !isUniquePersonalID(personalID: personalID) {
            return "Personal ID already in use."
        }

        // createUser in FirebaseAuth with email and password
        var displayError: String? = nil
        Auth.auth().createUser(withEmail: email, password: password, completion: { authResult, error in

            guard let newUserDocumentID = authResult?.user.uid else { return }
            print("successfully created user:  \(String(describing: newUserDocumentID))")

            let docData: [String: Any] = [
                "email": newUser.email ?? "",
                "name": newUser.name ?? "",
                "personalID": newUser.personalID ?? "",
                "studentID": newUser.studentID ?? ""
            ]
            self.db.collection(usersCollection).document(newUserDocumentID).setData(docData) { err in
                if let err = err {
                    displayError = "Error writing document: \(err)"
                }
            }

        })
        return displayError
    }

    func isUniquePersonalID(personalID: String) {
        let docRef = db.collection(usersCollection).document(personalID)
        docRef.getDocument { (document, error) in
            if let document = document, document.exists {
                print("Document data: ")
                //completion(false)
            } else {
                print("Document does not exist")
                //completion(true)
            }
            return
                        
        }
    }

}
