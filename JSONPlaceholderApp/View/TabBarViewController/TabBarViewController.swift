//
//  TabBarViewController.swift
//  JSONPlaceholderApp
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
        let service: Service = Service()
        
        let firstVC = UINavigationController(rootViewController: getNewsViewController(service: service))
        let secondVC = UINavigationController(rootViewController: getUsersViewController(service: service))
        
        firstVC.setTabBarItem(title: "News", image: UIImage(systemName: "newspaper"))
        secondVC.setTabBarItem(title: "Users", image: UIImage(systemName: "person.crop.circle.fill"))
        
        self.setViewControllers([firstVC, secondVC], animated: false)
    }
    
    private func getNewsViewController(service: Service) -> NewsViewController {
        let viewModel = NewsViewModel(service: service)
        
        return NewsViewController(viewModel: viewModel)
    }
    
    private func getUsersViewController(service: Service) -> UsersViewController {
        let viewModel = UsersViewModel(service: service)
        
        return UsersViewController(viewModel: viewModel)
    }
    
    private func setupAppearance() {
        let tabBarAppearance: UITabBarAppearance = UITabBarAppearance()
        tabBarAppearance.configureWithDefaultBackground()
        tabBar.standardAppearance = tabBarAppearance
        tabBar.scrollEdgeAppearance = tabBarAppearance
    }
}
