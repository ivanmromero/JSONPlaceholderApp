//
//  MockNavigationController.swift
//  JSONPlaceholderAppTests
//
//  Created by Ivan Romero on 21/07/2024.
//

import UIKit

class MockNavigationController: UINavigationController {
    var didPushViewController = false
    var viewControllerToPush: UIViewController?

    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        super.pushViewController(viewController, animated: animated)
        didPushViewController = true
        viewControllerToPush = viewController
    }
}
