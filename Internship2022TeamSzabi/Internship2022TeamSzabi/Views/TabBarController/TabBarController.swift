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
        //TabBar shadow
        tabBar.layer.borderWidth = 1
        tabBar.layer.borderColor = UIColor.lightGray.cgColor
        //TabBar items
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
        let navController = abc(rootViewController: viewController)
        navController.tabBarItem.image = tabBarImage
//
//        navController.navigationBar.layer.shadowOffset = CGSize(width: 0, height: 4)
//        navController.navigationBar.layer.shadowColor = UIColor.black.cgColor
//        navController.navigationBar.layer.shadowOpacity = 0.25
//        navController.navigationBar.layer.masksToBounds = false
//        //NavBar configuration
        
//        let shadowView = UIView(frame: navController.navigationBar.frame)
//        shadowView.backgroundColor = UIColor.white
//        shadowView.layer.masksToBounds = false
//        shadowView.layer.opacity = 0.25
//        shadowView.layer.shadowOffset = CGSize(width: 0, height: 4)
//        shadowView.layer.shadowRadius = 4
//        view.addSubview(shadowView)
        
//        navController.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 32)]
     
//  
        return navController
    }
}


class abc: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
            
//        let shadowView = UIView(frame: self.navigationBar.frame)
//       navigationBarbackgroundColor = UIColor.white
//        shadowView.backgroundColor = UIColor.white
//                shadowView.layer.masksToBounds = false
//                shadowView.layer.opacity = 0.25
//                shadowView.layer.shadowOffset = CGSize(width: 0, height: 4)
//                shadowView.layer.shadowRadius = 4
//                view.addSubview(shadowView)
        
        navigationBar.backgroundColor = .white
        navigationBar.layer.shadowOffset = CGSize(width: 0, height: 4)
        navigationBar.layer.shadowColor = UIColor.lightGray.cgColor
        navigationBar.layer.shadowOpacity = 0.25
        navigationBar.layer.masksToBounds = false
        navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 32)]
}
}
