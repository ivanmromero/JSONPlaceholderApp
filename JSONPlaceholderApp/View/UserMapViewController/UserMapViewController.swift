//
//  UserMapViewController.swift
//  JSONPlaceholderApp
//
//  Created by Ivan Romero on 20/07/2024.
//

import UIKit
import WebKit

class UserMapViewController: UIViewController {
    @IBOutlet weak var streetLabel: UILabel!
    @IBOutlet weak var zipCodeLabel: UILabel!
    @IBOutlet weak var webView: WKWebView!

    private let viewModel: UserMapViewModel

    init(viewModel: UserMapViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        set(text: viewModel.street, for: streetLabel)
        set(text: viewModel.zipCode, for: zipCodeLabel)
        loadRequest()
    }

    private func loadRequest() {
        if let url = viewModel.createGoogleMapsURL() {
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }

    private func set(text: String, for label: UILabel) {
        label.text = text
    }
}
