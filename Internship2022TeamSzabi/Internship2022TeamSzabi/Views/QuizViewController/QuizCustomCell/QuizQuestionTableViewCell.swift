//
//  QuizQuestionTableViewCell.swift
//  Internship2022TeamSzabi
//
//  Created by Cristian Vasile Kui-cs on 08.08.2022.
//

import UIKit

class QuizQuestionTableViewCell: UITableViewCell {
    @IBOutlet var buttonCollection: [UIButton]!
    @IBOutlet private weak var quizContainer: UIView!
    @IBOutlet weak var questionLabel: UILabel!
    
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
    
    @IBAction private func buttonSelected(_ sender: UIButton) {
        buttonCollection.forEach { $0.isSelected = false }
        buttonCollection[sender.tag].isSelected = true
//        if sender.tag == correctAnswer {
//        grade += 1
//        }
    }
}
