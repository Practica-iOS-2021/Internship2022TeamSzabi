//
//  GradesViewController.swift
//  Internship2022TeamSzabi
//
//  Created by Cristian Vasile Kui-cs on 26.07.2022.
//  Modified by Andreea Laura Bogdan on 10.08.2022.

import UIKit

final class GradesViewController: UIViewController,
                                  UITableViewDelegate,
                                  UITableViewDataSource {
    @IBOutlet private var gradesTableView: UITableView!
    @IBOutlet private var navStackView: UIStackView!
    @IBOutlet private var firstSemesterButton: UIButton!
    @IBOutlet private var secondSemesterButton: UIButton!
    @IBOutlet private var navView: UIView!
    // MARK: - Enum for selected nav button
    private enum NavButtons {
        case firstSemesterButton
        case secondSemesterButton
    }
    
    // I only put these as placeholders/templates for the time being
    private var gradeName: [String] = [ "Chemistry", "Informatics", "Mathematics", "Geography", "Biology" ]
    private var gradeIcon: [String] = [ "Chemistry", "Informatics", "Mathematics", "Geography", "Biology" ]
    private var gradeValue: [String] = [ "5", "9.3", "10", "7.2", "8.6" ]
    
    private var currentButton = NavButtons.firstSemesterButton
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // register cells Nib
        gradesTableView.register(
            UINib(nibName: "ActiveGradesTableViewCell", bundle: nil),
            forCellReuseIdentifier: "ActiveGradesTableViewCell")
        navigationItem.title = "Grades"
        
        // remove cell separator
        gradesTableView.separatorColor = .clear
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setAppearance()
        gradesTableView.reloadData()
    }
    
    // MARK: - nav buttons tapped actions
    @IBAction private func firstSemesterTap(_ sender: Any) {
        currentButton = .firstSemesterButton
        makeButtonSelected()
    }
    @IBAction private func secondSemesterTap(_ sender: Any) {
        currentButton = .secondSemesterButton
        makeButtonSelected()
    }
    
    // MARK: - Appearance
    private func setAppearance() {
        view.backgroundColor = .white
        navAppearance()
    }
    
    private func navAppearance() {
        // MARK: - navView containing nav components appearence
        // shadow
        navView.layer.masksToBounds = false
        navView.layer.shadowOffset = CGSize(width: 0, height: 4)
        navView.layer.shadowColor = UIColor.lightGray.cgColor
        navView.layer.shadowOpacity = 0.25
        // MARK: - StackView inside navView appearence
        // padding and item spacing
        navStackView.isLayoutMarginsRelativeArrangement = true
        navStackView.directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: 6, leading: 7, bottom: 6, trailing: 7)
        navStackView.spacing = 6
        // MARK: - Buttons inside StackView appearence
        // subview (buttons) corner radius
        navStackView.subviews.forEach { button in
            if let button = button as? UIButton {
                button.layer.cornerRadius = 20
            }
        }
        // set currentSelected button ('first semester') appearence
        makeButtonSelected()
    }
    
    // set coolours of unselected button
    private func setNormalButtonAppearance(button: UIButton) {
        button.backgroundColor = .white
        button.tintColor = UIColor(named: "ProfileLabelColor")
    }
    
    // set colours of selected button
    private func setSelectedButtonAppearance(button: UIButton) {
        button.backgroundColor = UIColor(named: "TabBarSelectedColor")
        button.tintColor = .white
    }
    
    // changes appearance of buttons depending on which one of them is selected
    private func makeButtonSelected() {
        switch currentButton {
        case .firstSemesterButton:
            setSelectedButtonAppearance(button: firstSemesterButton)
            setNormalButtonAppearance(button: secondSemesterButton)
            
        case .secondSemesterButton:
            setSelectedButtonAppearance(button: secondSemesterButton)
            setNormalButtonAppearance(button: firstSemesterButton)
        }
        gradesTableView.reloadData()
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.currentButton {
        case .firstSemesterButton:
            return gradeName.count
        case .secondSemesterButton:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = gradesTableView.dequeueReusableCell(withIdentifier: "ActiveGradesTableViewCell",
                                                       for: indexPath) as! ActiveGradesTableViewCell
        cell.setup(gradeIcon: gradeIcon[indexPath.row],
                   gradeName: gradeName[indexPath.row],
                   gradeValue: gradeValue[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch self.currentButton {
        case NavButtons.firstSemesterButton:
            // height + top
            // 90     + 25
            return 115
        case .secondSemesterButton:
            // height + top
            // 90     + 25
            return 115
        }
    }
}
