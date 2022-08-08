//
//  ChaptersTableViewCell.swift
//  Internship2022TeamSzabi
//
//  Created by Alin Huzmezan on 8/5/22.
//

import UIKit

class ChaptersTableViewCell: UITableViewCell {
    @IBOutlet private weak var cellView: UIView!
    @IBOutlet private weak var icon: UIImageView!
    @IBOutlet private weak var title: UILabel!
    @IBOutlet private weak var subTitle: UILabel!
    @IBOutlet private weak var grade: UILabel!
    @IBOutlet private weak var arrow: UIImageView!

    func updateCellView(/* ChapterModel */) {
        grade.isHidden = true
        arrow.isHidden = false
        self.backgroundColor = .blue
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellView.layer.cornerRadius = 20
        cellView.layer.masksToBounds = false
    }
}

class PassedTableViewCell: ChaptersTableViewCell {
    override func updateCellView(/* PassedModel */) {
        //grade.isHidden = false
        //arrow.isHidden = true
        self.backgroundColor = .red
    }
}
