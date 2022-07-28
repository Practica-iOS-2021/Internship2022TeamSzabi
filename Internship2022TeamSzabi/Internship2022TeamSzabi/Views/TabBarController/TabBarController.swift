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
        
        // MARK: - Instantiate view controllers
        let gradesController = createNavController(vc: GradesViewController(), tabBarImage: UIImage(named: "grades-tabbar-icon"))
        let coursesController = createNavController(vc: CoursesViewController(), tabBarImage: UIImage(named: "courses-tabbar-icon"))
        let profileController = createNavController(vc: ProfileViewController(), tabBarImage: UIImage(named: "profile-tabbar-icon"))
        
        // MARK: - Asigning view controllers
        setViewControllers([gradesController, coursesController, profileController], animated: false)
        
        // MARK: - Setting CoursesView as initial display view
        self.selectedIndex = 1
        
        // MARK: - TabBar configuration
        tabBar.itemPositioning = .fill;
        tabBar.tintColor = UIColor(named: "TabBarSelectedColor")
        tabBar.unselectedItemTintColor = UIColor(named: "TabBarColor")
        tabBar.backgroundColor = .white
        
        tabBar.items?.forEach { tabItems in
            //Insets are needed centering items for Iphone 11 and above
            tabItems.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: 0, right: 0)
            tabItems.title = ""
        }
    }
}

extension TabBarController {
    
    // MARK: - UINavigationController
    private func createNavController(vc: UIViewController, tabBarImage: UIImage?) -> UINavigationController {
        let viewController = vc
        let navController = UINavigationController(rootViewController: viewController)
        navController.tabBarItem.image = tabBarImage
        return navController
    }
}
