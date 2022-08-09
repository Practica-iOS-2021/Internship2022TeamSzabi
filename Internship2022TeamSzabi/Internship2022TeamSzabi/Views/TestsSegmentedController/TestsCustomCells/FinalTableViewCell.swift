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

    static let identifier = "finalCell"

    func updateCellView(finalModel: FinalTestModel) {
        titleLabel.text = finalModel.title
        subTitleLabel.text = finalModel.subTitle
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellView.layer.cornerRadius = 20
        cellView.layer.masksToBounds = false
        // shadow
        cellView.layer.masksToBounds = false
        cellView.layer.shadowOffset = CGSize(width: 0, height: 4)
        cellView.layer.shadowColor = UIColor.lightGray.cgColor
        cellView.layer.shadowOpacity = 0.25
    }
}
