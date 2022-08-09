//
//  QuizQuestionTableViewCell.swift
//  Internship2022TeamSzabi
//
//  Created by Cristian Vasile Kui-cs on 08.08.2022.
//

import UIKit

class QuizQuestionTableViewCell: UITableViewCell {
    @IBOutlet private var buttonCollection: [UIButton]!
    @IBOutlet weak var quizContainer: UIView!
    
    static let identifier = "QuizQuestionTableViewCell"

    static func nib() -> UINib {
        return UINib(nibName: "QuizQuestionTableViewCell", bundle: nil)
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        quizContainer.layer.cornerRadius = 20
        quizContainer.layer.masksToBounds = false
        buttonCollection.forEach {
            $0.isSelected = false
            $0.setImage(UIImage(named: "circle-unselected-icon"), for: UIControl.State.normal)
            $0.setImage(UIImage(named: "circle-selected-icon"), for: UIControl.State.selected)
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
       super.init(style: style, reuseIdentifier: reuseIdentifier)
       contentView.isUserInteractionEnabled = true
   }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
}
    @IBAction func buttonSelected(_ sender: UIButton) {
        buttonCollection.forEach { $0.isSelected = false }
        buttonCollection[sender.tag].isSelected = true
    }
}
