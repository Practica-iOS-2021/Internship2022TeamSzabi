//
//  GradesTableViewCell.swift
//  Internship2022TeamSzabi
//
//  Created by Andreea Laura Bogdan on 10.08.2022.
//

import UIKit

class ActiveGradesTableViewCell: UITableViewCell {
    @IBOutlet private var activeCellView: UIView!
    @IBOutlet private var icon: UIImageView!
    @IBOutlet private var name: UILabel!
    @IBOutlet private var grade: UILabel!
    
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
    
    func setup(gradeIcon: String, gradeName: String, gradeValue: String) {
        icon.image = UIImage(named: gradeIcon)
        name.text = gradeName
        grade.text = gradeValue
    }
    private func setAppearance() {
        activeCellView?.layer.cornerRadius = Details.cornerRadius
        activeCellView?.layer.masksToBounds = false
    }
}
