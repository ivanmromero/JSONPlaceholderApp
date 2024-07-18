//
//  TabBarViewController.swift
//  JSONPlaceholder
//
//  Created by Ivan Romero on 18/07/2024.
//

import UIKit

class TabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    private func setup() {
        setupViewControllers()
        setupAppearance()
    }
    
    private func setupViewControllers() {
        let firstVC = UINavigationController(rootViewController: UIViewController())
        firstVC.viewControllers.first?.view.backgroundColor = .white
        let secondVC = UINavigationController(rootViewController: UIViewController())
        secondVC.viewControllers.first?.view.backgroundColor = .gray
        
        firstVC.setTabBarItem(title: "News", image: UIImage(systemName: "newspaper"))
        secondVC.setTabBarItem(title: "Users", image: UIImage(systemName: "person.crop.circle.fill"))
        
        self.setViewControllers([firstVC, secondVC], animated: false)
    }
    
    private func setupAppearance() {
        let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithDefaultBackground()
        tabBar.standardAppearance = tabBarAppearance
        tabBar.scrollEdgeAppearance = tabBarAppearance
    }
}
