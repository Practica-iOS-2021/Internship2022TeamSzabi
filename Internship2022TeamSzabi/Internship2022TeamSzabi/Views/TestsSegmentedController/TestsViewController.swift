//
//  TestsSegmentedController.swift
//  Internship2022TeamSzabi
//
//  Created by Alin Huzmezan on 8/4/22.
//

import UIKit


class TestsViewController: UIViewController {
    @IBOutlet private weak var navStackView: UIStackView!
    @IBOutlet private weak var chaptersButton: UIButton!
    @IBOutlet private weak var finalButton: UIButton!
    @IBOutlet private weak var passedButton: UIButton!
    @IBOutlet private weak var navView: UIView!
    
    private enum NavButtons {
        case chaptersButton
        case finalButton
        case passedButton
    }
    private var currentButton = NavButtons.chaptersButton
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setAppearence()
    }
    
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
    }
}
