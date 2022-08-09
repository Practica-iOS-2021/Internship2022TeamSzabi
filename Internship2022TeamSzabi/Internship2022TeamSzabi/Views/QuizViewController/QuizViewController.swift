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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(QuizQuestionTableViewCell.nib(),
                           forCellReuseIdentifier: QuizQuestionTableViewCell.identifier)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 500
        tableView.delaysContentTouches = false
        
        finishButton.layer.cornerRadius = 20
        finishButton.layer.masksToBounds = false
    }
    let gradient = CAGradientLayer()
    override func viewDidLayoutSubviews() {
        gradient.frame = tableView.superview?.bounds ?? CGRect.null
        gradient.colors = [
            UIColor.clear, UIColor.clear, UIColor.clear,
            UIColor.red, UIColor.clear.cgColor, UIColor.red.cgColor
        ]
        gradient.locations = [0.0, 0.0, 0.0, 0.0, 0.5]
        tableView.superview?.layer.mask = gradient
        
        tableView.backgroundColor = UIColor.clear
    }
}

extension QuizViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: QuizQuestionTableViewCell.identifier,
                                                       for: indexPath) as? QuizQuestionTableViewCell else {
            return UITableViewCell()
        }
//        cell.contentView.alpha = 0.5
        
        cell.backgroundColor = .clear
        return cell
    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        UIView.animate(withDuration: 1) {
//            cell.contentView.alpha = 1
//        }?
}
