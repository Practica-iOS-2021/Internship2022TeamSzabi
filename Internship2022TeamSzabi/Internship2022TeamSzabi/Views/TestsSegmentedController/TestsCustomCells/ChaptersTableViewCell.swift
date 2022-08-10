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

    enum Details {
        static let identifier = "chapterCell"
        static let cornerRadius = 20.0
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        setAppearance()
    }

    func updateCellViewForChapter(chapter: ChapterModel, iconName: String) {
        icon.image = UIImage(named: iconName)
        title.text = chapter.name
        subTitle.text = "\(chapter.questions?.count ?? 0) questions"
        grade.isHidden = true
        arrow.isHidden = false
    }

    func updateCellViewforPassed(/* PassedModel */) {
        grade.isHidden = false
        arrow.isHidden = true
    }
    
    private func setAppearance() {
        cellView.layer.cornerRadius = Details.cornerRadius
        cellView.layer.masksToBounds = false
    }
}
