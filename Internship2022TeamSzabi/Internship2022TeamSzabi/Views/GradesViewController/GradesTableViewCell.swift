//
//  GradesTableViewCell.swift
//  Internship2022TeamSzabi
//
//  Created by Andreea Laura Bogdan on 10.08.2022.
//

import UIKit

class GradesTableViewCell: UITableViewCell {
    @IBOutlet private var cellView: UIView!
    @IBOutlet private var icon: UIImageView!
    @IBOutlet private var name: UILabel!
    @IBOutlet private var grade: UILabel!
    @IBOutlet private var slash: UILabel!
    
    enum Details {
        static let cornerRadius = 20.0
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setAppearance()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private func activeCell() {
        grade.isHidden = false
        slash.isHidden = true
    }
    
    private func inactiveCell() {
        grade.isHidden = true
        slash.isHidden = false
    }
    
    func setup(gradeIcon: String, gradeName: String, gradeValue: String?) {
        icon.image = UIImage(named: gradeIcon)
        name.text = gradeName
        if let gradeValue = gradeValue {
            activeCell()
            grade.text = gradeValue
        } else {
            inactiveCell()
        }
    }
    
    private func setAppearance() {
        cellView?.layer.cornerRadius = Details.cornerRadius
        cellView?.layer.masksToBounds = false
    }
}
