//
//  UIViewController+Extensions.swift
//  JSONPlaceholder
//
//  Created by Ivan Romero on 18/07/2024.
//

import UIKit

extension UIViewController {
    func setTabBarItem(title: String?, image: UIImage?) {
        tabBarItem = UITabBarItem(title: title, image: image, selectedImage: nil)
    }
}
