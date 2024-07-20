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

extension UIImage {
    static func fetchImage(from urlString: String, completion: @escaping (Result<UIImage, ServiceError>) -> ()) {
        guard let url = URL(string: urlString) else {
            completion(.failure(.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                let statusCode = (response as? HTTPURLResponse)?.statusCode ?? 0
                completion(.failure(.requestFailed(statusCode: statusCode, localizedDescription: error.localizedDescription)))
                return
            }

            guard let data = data, let image = UIImage(data: data) else {
                completion(.failure(.nilData))
                return
            }

            completion(.success(image))
        }.resume()
    }
}
