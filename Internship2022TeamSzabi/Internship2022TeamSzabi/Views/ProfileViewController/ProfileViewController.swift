//
//  ProfileViewController.swift
//  Internship2022TeamSzabi
//
//  Created by Cristian Vasile Kui-cs on 26.07.2022.
//

import UIKit

final class ProfileViewController: UIViewController {
    @IBOutlet private weak var profileName: UILabel!
    @IBOutlet private weak var profilePhoto: UIImageView!
    @IBOutlet private weak var profileStudentID: UILabel!
    @IBOutlet private weak var profilePersonalID: UILabel!
    @IBOutlet private weak var profileEmail: UILabel!
    
    private var userData: [UserModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Profile"
        
        profileEmail.text = "-"
        profileName.text = "-"
        profilePersonalID.text = "-"
        profileStudentID.text = "-"
        profilePhoto.image = UIImage(named: "")
        profilePhoto.layer.cornerRadius = profilePhoto.layer.frame.width / 2
        profilePhoto.layer.masksToBounds = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        assignUserData()
    }
    // MARK: - Assign fetched UserData to Profile Screen
    private func assignUserData() {
        DataApiManager.sharedUserData.fetchUserData { [weak self] userData, errorMessage in
            guard let self = self else { return }
            guard errorMessage == nil else {
                self.alertError(errorMessage ?? "Error")
                return
            }
            self.profileEmail.text = userData?.email
            self.profileName.text = userData?.name
            self.profilePersonalID.text = userData?.personalID
            self.profileStudentID.text = userData?.studentID
            self.profilePhoto.image = UIImage(named: "\(userData?.photo ?? "")")
        }
    }
    
    // MARK: - SignOut
    @IBAction private func logOutButton(_ sender: Any) {
        let logOut = FirestoreManager.auth
        do {
            try logOut.signOut()
            StorageManager.shared.setUserLoggedIn(value: false)
            let appDelegate = UIApplication.shared.delegate as? AppDelegate
            appDelegate?.window?.rootViewController = SplashViewController()
        } catch let signOutError as NSError {
            print("error signing out: \(signOutError)")
        }
    }
    
    func alertError(_ errorMessage: String) {
        let dialogMessage = UIAlertController(title: "Error", message: errorMessage, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Data cannot be fetched", style: .default)
        dialogMessage.addAction(okAction)
        present(dialogMessage, animated: true, completion: nil)
    }
}
