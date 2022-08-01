//
//  CustomTabBarViewController.swift
//  Internship2022TeamSzabi
//
//  Created by Cristian Vasile Kui-cs on 26.07.2022.
//

import UIKit

class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setViewController()
        tabBarConfiguration()
    }
    // MARK: - UINavigationController
    private func createNavigationController(viewController: UIViewController, tabBarImage: UIImage?) -> UINavigationController {
        let navigationController = NavigationBar(rootViewController: viewController)
        navigationController.tabBarItem.image = tabBarImage
        
        return navigationController
    }
    // MARK: - Instantiate view controllers
    private func setViewController() {
        let gradesController = createNavigationController(viewController: GradesViewController(),
                                                          tabBarImage: UIImage(named: "grades-tabbar-icon"))
        let coursesController = createNavigationController(viewController: CoursesViewController(),
                                                           tabBarImage: UIImage(named: "courses-tabbar-icon"))
        let profileController = createNavigationController(viewController: ProfileViewController(),
                                                           tabBarImage: UIImage(named: "profile-tabbar-icon"))
        // MARK: - Asigning view controllers
        setViewControllers([gradesController, coursesController, profileController], animated: false)
        // MARK: - Setting CoursesView as initial display view
        selectedIndex = 1
    }
    // MARK: - TabBar configuration
    private func tabBarConfiguration() {
        tabBar.itemPositioning = .fill
        tabBar.tintColor = UIColor(named: "TabBarSelectedColor")
        tabBar.unselectedItemTintColor = UIColor(named: "TabBarColor")
        tabBar.backgroundColor = .white
        // TabBar shadow
        tabBar.layer.borderWidth = 1
        tabBar.layer.borderColor = UIColor.lightGray.cgColor
        // TabBar items
        tabBar.items?.forEach { tabItems in
            // Insets are needed centering items for Iphone 11 and above
            tabItems.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
            tabItems.title = ""
        }
    }
}
// MARK: - NavigationBar Configuration
class NavigationBar: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // NavigationBar shadow
        navigationBar.backgroundColor = .white
        navigationBar.layer.shadowOffset = CGSize(width: 0, height: 4)
        navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
        navigationBar.layer.shadowOpacity = 0.25
        navigationBar.layer.masksToBounds = false
        // Navigation title configuration
        navigationBar.titleTextAttributes = [
            NSAttributedString.Key.font: UIFont(name: "InterV", size: 32) as Any,
            NSAttributedString.Key.foregroundColor: UIColor(named: "ProfileLabelColor") as Any
        ]
    }
}
