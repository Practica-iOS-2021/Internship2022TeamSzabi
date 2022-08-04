//
//  TestsSegmentedController.swift
//  Internship2022TeamSzabi
//
//  Created by Alin Huzmezan on 8/4/22.
//

import UIKit


class TestsViewController: UIViewController {
    @IBOutlet weak var segmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setAppearence()
    }
    
    func setAppearence() {
        view.backgroundColor = .white
        setSegmentedControlAppearence()
        
    }
    
    private func setSegmentedControlAppearence() {
        segmentedControl.layer.masksToBounds = false
        // segmentedControl background
        segmentedControl.layer.cornerRadius = 20
        // segmentedControl shadow
        segmentedControl.layer.shadowOffset = CGSize(width: 0, height: 4)
        segmentedControl.layer.shadowColor = UIColor.lightGray.cgColor
        segmentedControl.layer.shadowOpacity = 0.25
// segmentedControl corner radius
        //segmentedControl.layer.borderColor = UIColor.white.cgColor
        //segmentedControl.layer.borderWidth = 1.0
        //segmentedControl.layer.cornerRadius = 25.0
// segmentedControl font
        let font = UIFont.interFont(size: 22) ?? UIFont.systemFont(ofSize: 22)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .normal)
        segmentedControl.setTitleTextAttributes([NSAttributedString.Key.font: font], for: .selected)

        // colors
        let selectedFontColor = [NSAttributedString.Key.foregroundColor: UIColor.white]
        let normalFontColor = [NSAttributedString.Key.foregroundColor: UIColor(named: "TabBarSelectedColor")]
        // default background color
        segmentedControl.backgroundColor = UIColor(ciColor: .white)
        // selected background color
        segmentedControl.tintColor = UIColor(named: "TabBarSelectedColor")
        // selected title text color
        segmentedControl.setTitleTextAttributes(selectedFontColor, for: .selected)
        // default title text color
        segmentedControl.setTitleTextAttributes(normalFontColor, for: .normal)
    }
}
