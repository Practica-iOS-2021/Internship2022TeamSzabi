//
//  HomeViewController.swift
//  Internship2022TeamSzabi
//
//  Created by Cristian Vasile Kui-cs on 26.07.2022.
//  Modified by Andreea Laura Bogdan on 02.08.2022.

import UIKit

final class CoursesViewController: UIViewController,
                                   UICollectionViewDelegate,
                                   UICollectionViewDataSource,
                                   UICollectionViewDelegateFlowLayout {
    @IBOutlet private var courseCollectionView: UICollectionView!
    private var courseNames: [String] = ["Geography", "Mathematics", "Biology", "Chemistry", "Informatics"]
    private var courseIcons: [String] = ["Geography", "Mathematics", "Biology", "Chemistry", "Informatics"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = "Courses"
        
        let nibCell = UINib(nibName: CoursesCollectionViewCell.identifier, bundle: nil)
        courseCollectionView.register(nibCell, forCellWithReuseIdentifier: "CoursesCollectionViewCell")
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let flowlayout = collectionViewLayout as? UICollectionViewFlowLayout
        let space: CGFloat = (flowlayout?.minimumInteritemSpacing ?? 0.0) +
        (flowlayout?.sectionInset.left ?? 0.0) +
        (flowlayout?.sectionInset.right ?? 0.0)
        let size: CGFloat = (collectionView.frame.size.width - space) / 2.0
        return CGSize(width: size, height: size)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return courseNames.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = courseCollectionView.dequeueReusableCell(withReuseIdentifier: "CoursesCollectionViewCell",
                                                               for: indexPath) as? CoursesCollectionViewCell {
            cell.setup(imageName: courseNames[indexPath.row], name: courseIcons[indexPath.row])
            return cell
        }
        return UICollectionViewCell()
    }
}
