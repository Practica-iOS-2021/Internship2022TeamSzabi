//
//  ProfileViewController.swift
//  Internship2022TeamSzabi
//
//  Created by Cristian Vasile Kui-cs on 26.07.2022.
//

import UIKit

final class ProfileViewController: UIViewController {
    @IBOutlet private weak var profilePhoto: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Profile"
        
        profilePhoto.layer.cornerRadius = profilePhoto.layer.frame.width / 2
        profilePhoto.layer.masksToBounds = false
    }
}
