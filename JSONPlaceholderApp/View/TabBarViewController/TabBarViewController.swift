//
//  TabBarViewController.swift
//  JSONPlaceholderApp
//
//  Created by Ivan Romero on 18/07/2024.
//

import UIKit

class TabBarViewController: UITabBarController {
    private let service: Service = Service()

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        setupViewControllers()
        setupAppearance()
    }

    private func setupViewControllers() {
        let viewControllers = [
            createNavigationController(viewController: createNewsViewController(),
                                       title: "News",
                                       imageName: "newspaper"),
            createNavigationController(viewController: createUsersViewController(),
                                       title: "Users",
                                       imageName: "person.crop.circle.fill")
        ]

        self.setViewControllers(viewControllers, animated: false)
    }

    private func createNavigationController(viewController: UIViewController,
                                            title: String,
                                            imageName: String) -> UINavigationController {
        let navigationController = UINavigationController(rootViewController: viewController)
        navigationController.setTabBarItem(title: title, image: UIImage(systemName: imageName))

        return navigationController
    }

    private func createNewsViewController() -> NewsViewController {
        let viewModel = NewsViewModel(service: service)

        return NewsViewController(viewModel: viewModel)
    }

    private func createUsersViewController() -> UsersViewController {
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
