//
//  QuizViewController.swift
//  Internship2022TeamSzabi
//
//  Created by Cristian Vasile Kui-cs on 08.08.2022.
//

import UIKit

class QuizViewController: UIViewController {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var finishButton: UIButton!
    @IBOutlet private weak var fadeView: UIView!
    
    private var selectedAnswers: [Int] = []
    private var questionsModel: [QuestionModel] = []
    var chapterModel: ChapterModel?
    private var score = 0
    
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
        
        navigationItem.title = chapterModel?.name
        questionsModel = chapterModel?.questions ?? []
        if !questionsModel.isEmpty {
            selectedAnswers = [Int](repeating: -1, count: questionsModel.count)
        }
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
    
    private func computeGrade() {
        if selectedAnswers.first(where: { $0 == -1 }) != nil {
            print("please fill all questions")
            // error if question not answered
            return
        }
        questionsModel.enumerated().forEach { index, question in
            if question.correntAnswer == selectedAnswers[index] {
                score += 1
            }
        }
        // Check if minimum grade is 4
        let finalGrade = max(round(Double(score) / Double(questionsModel.count) * 10), 4)
        print(finalGrade)
    }
    
    @IBAction private func finishExam() {
        computeGrade()
//        GradesModel
    }
}

extension QuizViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return questionsModel.count
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 150
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: QuizQuestionTableViewCell.identifier,
                                                       for: indexPath) as? QuizQuestionTableViewCell else {
            return UITableViewCell()
        }
        cell.setup(question: questionsModel[indexPath.row], number: indexPath.row)
        cell.delegate = self
        return cell
    }
}

extension QuizViewController: QuizQuestionProtocol {
    func didSelectAnswer(answer: Int, number: Int) {
        selectedAnswers[number] = answer
    }
}
