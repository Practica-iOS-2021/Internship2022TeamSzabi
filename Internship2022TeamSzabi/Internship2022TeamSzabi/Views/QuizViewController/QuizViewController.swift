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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(QuizQuestionTableViewCell.nib(),
                           forCellReuseIdentifier: QuizQuestionTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.delaysContentTouches = false
        
        finishButton.layer.cornerRadius = 20
        finishButton.layer.masksToBounds = false
        setGradient()
    }
    
    func setGradient() {
        let firstColor = UIColor.red
        let secondColor = firstColor.withAlphaComponent(0.0)
        let gradient = CAGradientLayer()
        gradient.type = .axial
        gradient.colors = [ firstColor, secondColor ]
//        gradient.colors = [ UIColor.white.cgColor, UIColor.white.cgColor ]
        gradient.locations = [0, 1]
        gradient.frame = fadeView.layer.bounds
//        self.fadeView.layer.insertSublayer(gradient, at: 0)
//        fadeView.backgroundColor = .clear
        fadeView.layer.addSublayer(gradient)
    }
}

extension QuizViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: QuizQuestionTableViewCell.identifier,
                                                       for: indexPath) as? QuizQuestionTableViewCell else {
            return UITableViewCell()
        }
        return cell
    }
    
    //    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
    //        UIView.animate(withDuration: 1) {
    //            cell.contentView.alpha = 1
    //        }?
}
