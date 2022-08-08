//
//  TestsSegmentedController.swift
//  Internship2022TeamSzabi
//
//  Created by Alin Huzmezan on 8/4/22.
//

import UIKit

class TestsViewController: UIViewController {
    @IBOutlet private weak var testsTableView: UITableView!
    @IBOutlet private weak var navStackView: UIStackView!
    @IBOutlet private weak var chaptersButton: UIButton!
    @IBOutlet private weak var finalButton: UIButton!
    @IBOutlet private weak var passedButton: UIButton!
    @IBOutlet private weak var navView: UIView!
    // MARK: - Enum for selected nav button
    private enum NavButtons {
        case chaptersButton
        case finalButton
        case passedButton
    }
    private var currentButton = NavButtons.chaptersButton
    
    // MARK: - Cells reuse identifiers
    let chapterCellIdentifier = "chapterCell"
    let finalCellIdentifier = "finalCell"
    //let passedCellIdentifier = "passedCell"
    
    // MARK: - DataSet for 'chapters', 'final' 'passed' tests
    let chaptersDataSource: [String] = ["1", "2", "3"]
    let finalDataSource: [String] = ["1", "2"]
    let passedDataSource: [String] = ["1", "2", "3", "4"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // register cells Nib's
        testsTableView.register(
            UINib(nibName: "ChaptersTableViewCell", bundle: nil), forCellReuseIdentifier: chapterCellIdentifier)
        testsTableView.register(
            UINib(nibName: "FinalTableViewCell", bundle: nil), forCellReuseIdentifier: finalCellIdentifier)
       // testsTableView.register(
       //     UINib(nibName: "ChaptersTableViewCell", bundle: nil), forCellReuseIdentifier: chapterCellIdentifier)
        // set dataSource & delegate
        testsTableView.dataSource = self
        testsTableView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setAppearence()
        testsTableView.reloadData()
    }
    
    // MARK: - nav buttons tapped actions
    @IBAction private func chaptersTap(_ sender: Any) {
        currentButton = .chaptersButton
        makeButtonSelected()
    }
    @IBAction private func finalTap(_ sender: Any) {
        currentButton = .finalButton
        makeButtonSelected()
    }
    @IBAction private func passedTap(_ sender: Any) {
        currentButton = .passedButton
        makeButtonSelected()
    }
    
    // MARK: - Appearence
    private func setAppearence() {
        view.backgroundColor = .white
        navAppearence()
    }
    
    private func navAppearence() {
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
        // set currentSelected button ('chapter') appearence
        makeButtonSelected()
    }
    
    private func setNormalButtonAppearence(button: UIButton) {
        button.backgroundColor = .white
        button.tintColor = UIColor(named: "TabBarSelectedColor")
    }
    
    private func setSelectedButtonAppearence(button: UIButton) {
        button.backgroundColor = UIColor(named: "TabBarSelectedColor")
        button.tintColor = .white
    }
    
    private func makeButtonSelected() {
        switch currentButton {
        case NavButtons.chaptersButton:
            setSelectedButtonAppearence(button: chaptersButton)
            setNormalButtonAppearence(button: finalButton)
            setNormalButtonAppearence(button: passedButton)
        case NavButtons.finalButton:
            setNormalButtonAppearence(button: chaptersButton)
            setSelectedButtonAppearence(button: finalButton)
            setNormalButtonAppearence(button: passedButton)
        case NavButtons.passedButton:
            setNormalButtonAppearence(button: chaptersButton)
            setNormalButtonAppearence(button: finalButton)
            setSelectedButtonAppearence(button: passedButton)
        }
        testsTableView.reloadData()
    }
}

extension TestsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.currentButton {
        case NavButtons.chaptersButton:
            return self.chaptersDataSource.count
        case NavButtons.finalButton:
            return self.finalDataSource.count
        case NavButtons.passedButton:
            return self.passedDataSource.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // MARK: - let cell = chaptersCell/ finalCell/ passedCell
        // depending on 'currentButton'
        switch self.currentButton {
        case NavButtons.chaptersButton:
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: chapterCellIdentifier, for: indexPath)
                    as? ChaptersTableViewCell
            else {
                return UITableViewCell()
            }
            cell.updateCellView(/* ChapterModel @ indexPath */)
            return cell
        case NavButtons.finalButton:
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: finalCellIdentifier, for: indexPath)
                    as? FinalTableViewCell
            else {
                return UITableViewCell()
            }
            cell.updateCellView()
            return cell
        case NavButtons.passedButton:
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: chapterCellIdentifier, for: indexPath)
                    as? PassedTableViewCell
            else {
                return UITableViewCell()
            }
            cell.updateCellView(/* PassedModel @ indexPath */)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return 115
      }
}
