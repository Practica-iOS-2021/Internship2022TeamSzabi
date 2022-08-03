//
//  HomeViewController.swift
//  Internship2022TeamSzabi
//
//  Created by Cristian Vasile Kui-cs on 26.07.2022.
//  Modified by Andreea Laura Bogdan on 02.08.2022.

import UIKit

final class CoursesViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet var courseCollectionView: UICollectionView!
    private var courseNames: [String] = ["Geography", "Mathematics", "Biology", "Chemistry", "Informatics"]
    private var courseIcons: [String] = ["Geography", "Mathematics", "Biology", "Chemistry", "Informatics"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Courses"
        
        let nibCell = UINib(nibName: CoursesCollectionViewCell.identifier, bundle: nil)
        courseCollectionView.register(nibCell, forCellWithReuseIdentifier: "CoursesCollectionViewCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return courseNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = courseCollectionView.dequeueReusableCell(withReuseIdentifier: "CoursesCollectionViewCell",
                                                               for: indexPath) as? CoursesCollectionViewCell {
            cell.setup(imageName: courseIcons[indexPath.row], name: courseNames[indexPath.row])
            return cell
        } else {
            return UICollectionViewCell()
        }
    }
}
