//
//  QuizViewController.swift
//  Internship2022TeamSzabi
//
//  Created by Cristian Vasile Kui-cs on 08.08.2022.
//

import UIKit

struct QuestionModel {
var question: String
var answers: [String]
var correctAnswer:Int
}

class QuizViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var finishButton: UIButton!
    @IBOutlet private weak var fadeView: UIView!
    
    private var questionString: String?
    private var grade: Int? = 0
    private var correctAnswer: Int? = 0
    private var questionNumber: Int = 0
    
//    private var quizModel = [courseModel]
    let questionair = QuestionModel(question: "is this working", answers: [ "yes", "no", "maybe", "wut"], correctAnswer: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(QuizQuestionTableViewCell.nib(),
                           forCellReuseIdentifier: QuizQuestionTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delaysContentTouches = false
        tableView.separatorColor = .clear
        
        finishButton.layer.cornerRadius = 20
        finishButton.layer.masksToBounds = false
        setGradient()
    }
    
    // MARK: - Gradient fade
    private func setGradient() {
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.colors = [
            UIColor.white.withAlphaComponent(0.1).cgColor, UIColor.white.withAlphaComponent(0.6).cgColor,
            UIColor.white.withAlphaComponent(0.9).cgColor, UIColor.white.cgColor
        ]
        gradient.locations = [0.0, 0.3, 0.5, 1.0]
        gradient.frame = fadeView.layer.bounds
        fadeView.layer.addSublayer(gradient)
    }
}

//extension QuizViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 5
//    }
//
//      func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        guard let cell = tableView.dequeueReusableCell(withIdentifier: QuizQuestionTableViewCell.identifier,
//                                                       for: indexPath) as? QuizQuestionTableViewCell else {
//
//            return UITableViewCell()
//        }
//        cell.questionLabel.text = questionair.question
//
//                if questionNumber <= (questionair.question.count - 1) {
//
//                    cell.questionLabel.text = questionair.question
//                    let letterArray = ["A. ","B. ","C. ","D. "]
//                    for i in 0..<cell.buttonCollection.count {
//                        cell.buttonCollection[i].setTitle("\(letterArray[i]) \(questionair.answers[i])", for: UIControl.State.normal)
//                    }
//                    correctAnswer = questionair.correctAnswer
//                }else{
////                    let alert = UIAlertController(title: "Awesome!!!", message: "You scored: \(grade)", preferredStyle: .alert)
////                    let restartAction = UIAlertAction(title: "restart", style: .default, handler: {action in self.restartQuiz()})
////                    alert.addAction(restartAction)
////                    present(alert,animated: true, completion: nil)
//                    print("made it this far ,,,,asdajsdlasdlamsdlamsldmals")
//                    return cell
//                }
//    }
// }

extension QuizViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: QuizQuestionTableViewCell.identifier,
                                                       for: indexPath) as? QuizQuestionTableViewCell else {
            return UITableViewCell()
        }
            cell.questionLabel.text = questionair.question
        
                        if questionNumber <= (questionair.question.count - 1) {
                            cell.questionLabel.text = questionair.question
                            let letterArray = ["A. ", "B. ", "C. ", "D. "]
                            for i in 0..<cell.buttonCollection.count {
                                cell.buttonCollection[i].setTitle("\(letterArray[i]) \(questionair.answers[i])", for: UIControl.State.normal)
                            }
                            correctAnswer = questionair.correctAnswer
                        } else {
        //                    let alert = UIAlertController(title: "Awesome!!!", message: "You scored: \(grade)", preferredStyle: .alert)
        //                    let restartAction = UIAlertAction(title: "restart", style: .default, handler: {action in self.restartQuiz()})
        //                    alert.addAction(restartAction)
        //                    present(alert,animated: true, completion: nil)
                            print("made it this far ,,,,asdajsdlasdlamsdlamsldmals")
                        }
        return cell
    }
}
