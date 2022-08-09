//
//  CollectionViewCell.swift
//  Internship2022TeamSzabi
//
//  Created by Andreea Laura Bogdan on 02.08.2022.
//

import UIKit

class CoursesCollectionViewCell: UICollectionViewCell {
    static let identifier = "CoursesCollectionViewCell"
    
    @IBOutlet private var courseName: UILabel!
    @IBOutlet private var chapterCount: UIButton!
    @IBOutlet private var courseIcon: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        styleCell()
    }
    
    func styleCell() {
        // Apply rounded corners
        contentView.layer.cornerRadius = 20.0
        contentView.layer.masksToBounds = true
        // Set masks to bounds to false to avoid the shadow from being clipped to the corner radius
        layer.cornerRadius = 20.0
        layer.masksToBounds = false
        // Apply a shadow
        layer.shadowRadius = 2
        layer.shadowOpacity = 0.8
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.3).cgColor
        layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    func setup(course: CoursesModel) {
        courseIcon.image = UIImage(named: course.name)
        courseName.text = course.name
        chapterCount.setTitle("\(course.chapters?.count ?? 0) lessons", for: .normal)
    }
}
