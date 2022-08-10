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

    // MARK: - DataSet for 'chapters', 'final' 'passed' tests
    var courseName: String = "Tests"
    var chaptersDataSource: [ChapterModel] = []
    var passedDataSource: [String] = []
    let finalDataSource: [FinalTestModel] = [
        FinalTestModel(title: "Generate final random test"),
        FinalTestModel(title: "Scan the QR code and start the coresponding test")
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        // register cells Nib's
        testsTableView.register(
            UINib(nibName: "ChaptersTableViewCell", bundle: nil),
            forCellReuseIdentifier: ChaptersTableViewCell.Details.identifier)
        testsTableView.register(
            UINib(nibName: "FinalTableViewCell", bundle: nil),
            forCellReuseIdentifier: FinalTableViewCell.Details.identifier)
        // set dataSource & delegate
        testsTableView.dataSource = self
        testsTableView.delegate = self
        // remove cell separator
        testsTableView.separatorColor = .clear
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationItem.title = courseName
        //chaptersDataSource = self.getChapters()
        //passedDataSource = self.getPassed()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setAppearance()
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
        // set currentSelected button ('chapter') appearence
        makeButtonSelected()
    }

    private func setNormalButtonAppearance(button: UIButton) {
        button.backgroundColor = .white
        button.tintColor = UIColor(named: "TabBarSelectedColor")
    }

    private func setSelectedButtonAppearance(button: UIButton) {
        button.backgroundColor = UIColor(named: "TabBarSelectedColor")
        button.tintColor = .white
    }

    private func makeButtonSelected() {
        switch currentButton {
        case .chaptersButton:
            setSelectedButtonAppearance(button: chaptersButton)
            setNormalButtonAppearance(button: finalButton)
            setNormalButtonAppearance(button: passedButton)
        case .finalButton:
            setNormalButtonAppearance(button: chaptersButton)
            setSelectedButtonAppearance(button: finalButton)
            setNormalButtonAppearance(button: passedButton)
        case .passedButton:
            setNormalButtonAppearance(button: chaptersButton)
            setNormalButtonAppearance(button: finalButton)
            setSelectedButtonAppearance(button: passedButton)
        }
        testsTableView.reloadData()
    }

//    private func getChapters() -> [ChapterModel] {
//        return courseData.chapters ?? []
//    }
//
//    private func getPassed() -> [String] {
//        return ["1", "2", "3"]
//    }
}

extension TestsViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch self.currentButton {
        case .chaptersButton:
            return self.chaptersDataSource.count
        case .finalButton:
            return self.finalDataSource.count
        case .passedButton:
            return self.passedDataSource.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // MARK: - let cell = chaptersCell/ finalCell/ passedCell
        // depending on 'currentButton'
        switch self.currentButton {
        case NavButtons.chaptersButton:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ChaptersTableViewCell.Details.identifier, for: indexPath)
            as? ChaptersTableViewCell else { return UITableViewCell() }
            cell.updateCellViewForChapter(chapter: chaptersDataSource[indexPath.row], iconName: courseName)
            return cell
        case NavButtons.finalButton:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: FinalTableViewCell.Details.identifier, for: indexPath)
            as? FinalTableViewCell else { return UITableViewCell() }
            cell.updateCellView(finalModel: finalDataSource[indexPath.row])
            return cell
        case NavButtons.passedButton:
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: ChaptersTableViewCell.Details.identifier, for: indexPath)
            as? ChaptersTableViewCell else { return UITableViewCell() }
            cell.updateCellViewforPassed(/* PassedModel @ indexPath */)
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch self.currentButton {
        case NavButtons.chaptersButton:
            // height + top
            // 90     + 25
            return 115
        case .passedButton:
            // height + top
            // 90     + 25
            return 115
        case .finalButton:
            // height + top + bottom
            // 250    + 65  + 5
            return 320
        }
    }
}
