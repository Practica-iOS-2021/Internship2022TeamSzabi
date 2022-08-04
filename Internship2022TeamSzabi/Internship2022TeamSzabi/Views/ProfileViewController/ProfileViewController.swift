//
//  ProfileViewController.swift
//  Internship2022TeamSzabi
//
//  Created by Cristian Vasile Kui-cs on 26.07.2022.
//

import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseFirestore

struct CurrentUser {
    let uid, email, name, personalID, photo, studentID: String
}

final class ProfileViewController: UIViewController {
    @IBOutlet private weak var profilePhoto: UIImageView!
    
    var currentUser: CurrentUser?
    let dataBaseRef = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Profile"
        
        profilePhoto.layer.cornerRadius = profilePhoto.layer.frame.width / 2
        profilePhoto.layer.masksToBounds = false
        getUserData()
    }
    
    private func getUserData() {
        //        let defaults = UserDefaults.standard
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        dataBaseRef.collection("users").document(uid).getDocument { snapshot, error in
            if let error = error {
                    print("failed to get user", error)
                return
            }
            guard let data = snapshot?.data() else { return }
            
            let uid = data["uid"] as? String ?? ""
            let email = data["email"] as? String ?? ""
            let name = data["name"] as? String ?? ""
            let personalID = data["personalID"] as? String ?? ""
            let photo = data["photo"] as? String ?? ""
            let studentID = data["studentID"] as? String ?? ""
            
            self.currentUser = CurrentUser(uid: uid, email: email,
                                          name: name, personalID: personalID,
                                          photo: photo, studentID: studentID)
        }
    }
    
    
    func signOut() {
        let firebaseAuth = Auth.auth()
        do {
            try firebaseAuth.signOut()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
        }
    }
}
