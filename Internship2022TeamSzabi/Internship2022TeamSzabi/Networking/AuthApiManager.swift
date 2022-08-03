//
//  AuthApiManager.swift
//  Internship2022TeamSzabi
//
//  Created by Alin Huzmezan on 30.07.2022.
//

import Foundation

class AuthApiManager {
    static let sharedInstance = AuthApiManager()    
    
    func registerUser(newUser: UserModel, completion: @escaping (Bool, String?) -> Void) {
        // validate newUser's data for uniqueness
        validateUserData(newUser: newUser) { unique, errorMessage in
            // if newUser's validated data is unique
            if let errorMessage = errorMessage {
                completion(false, errorMessage)
            } else if unique {
                // create FirebaseAuth for user
                self.createFirebaseAuthUser(newUser: newUser) { userID, _ in
                    if let userID = userID {
                        // create document for user
                        self.createUserDocument(newUser: newUser, newUserDocumentID: userID) { succes, errorMessage in
                            completion(succes, errorMessage)
                        }
                    } else {
                        completion(false, "Email already in use")
                    }
                }
            } else {
                completion(false, "Personal ID not unique")
            }
        }
    }
    
    private func validateUserData(newUser: UserModel, completion: @escaping (Bool, String?) -> Void) {
        // check if 'personalID' of newUser is already in use
        isUniquePersonalID(personalID: newUser.personalID) { unique, errorMessage in
            let errorMessage = unique ? nil : errorMessage
            completion(unique, errorMessage)
        }
    }
    
    private func createFirebaseAuthUser(newUser: UserModel, completion: @escaping ((String?, Error?) -> Void)) {
        // createUser in FirebaseAuth with email and password
        FirestoreManager.auth.createUser(withEmail: newUser.email,
                                         password: newUser.password) { authResult, error in
            completion(authResult?.user.uid, error)
        }
    }
    
    private func createUserDocument(newUser: UserModel, newUserDocumentID: String, completion: @escaping (Bool, String?) -> Void) {
        guard let newUserData = newUser.dict else {
            completion(false, "Unable to encode user")
            return
        }
        
        FirestoreManager.db.collection(usersCollection).document(newUserDocumentID).setData(newUserData) { error in
            if error != nil {
                completion(false, "Error writing user document")
            } else {
                completion(true, nil)
            }
        }
    }
    
    private func isUniquePersonalID(personalID: String, completion: @escaping (Bool, String?) -> Void) {
        FirestoreManager.db.collection(usersCollection)
            .whereField("personalID", isEqualTo: personalID)
            .getDocuments { querySnapshot, err in
                if err != nil {
                    // error occured while getting document
                    completion(false, "Error getting documents")
                } else if let empty = querySnapshot?.documents.isEmpty {
                        completion(empty, nil)
                } else {
                    completion(false, err?.localizedDescription)
                }
            }
    }
}
