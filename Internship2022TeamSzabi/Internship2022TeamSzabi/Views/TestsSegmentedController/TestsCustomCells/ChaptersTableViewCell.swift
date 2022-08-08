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

    static let identifier = "chapterCell"
    
    func updateCellViewForChapter(/* ChapterModel */) {
        grade.isHidden = true
        arrow.isHidden = false
    }
    
    func updateCellViewforPassed(/* PassedModel */) {
        grade.isHidden = false
        arrow.isHidden = true
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        cellView.layer.cornerRadius = 20
        cellView.layer.masksToBounds = false
    }
}
