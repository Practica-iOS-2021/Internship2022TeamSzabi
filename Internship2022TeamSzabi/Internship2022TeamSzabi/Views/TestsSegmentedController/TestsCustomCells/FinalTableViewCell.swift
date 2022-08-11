//
//  FinalTableViewCell.swift
//  Internship2022TeamSzabi
//
//  Created by Alin Huzmezan on 8/5/22.
//

import UIKit

class FinalTableViewCell: UITableViewCell {
    @IBOutlet private weak var cellView: UIView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subTitleLabel: UILabel!
    
    enum Details {
        static let identifier = "finalCell"
        static let cornerRadius = 20.0
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setAppearance()
    }
    
    func updateCellView(finalModel: FinalTestModel) {
        titleLabel.text = finalModel.title
        subTitleLabel.text = finalModel.subTitle
        isUserInteractionEnabled = false
    }
    
    private func setAppearance() {
        cellView.layer.masksToBounds = false
        cellView.layer.cornerRadius = Details.cornerRadius
        // shadow
        cellView.layer.masksToBounds = false
        cellView.layer.shadowOffset = CGSize(width: 0, height: 4)
        cellView.layer.shadowColor = UIColor.lightGray.cgColor
        cellView.layer.shadowOpacity = 0.25
    }
}
