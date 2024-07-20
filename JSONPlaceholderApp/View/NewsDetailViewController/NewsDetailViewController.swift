//
//  NewsDetailViewController.swift
//  JSONPlaceholderApp
//
//  Created by Ivan Romero on 19/07/2024.
//

import UIKit

class NewsDetailViewController: UIViewController {
    
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var publishedAtLabel: UILabel!
    
    private let viewModel: NewsDetailViewModel
    
    init(viewModel: NewsDetailViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        coverImage.image = viewModel.coverImage
        titleLabel.text = viewModel.title
        contentLabel.text = viewModel.content
        categoryLabel.text = viewModel.category
        publishedAtLabel.text = viewModel.publishedAt
    }
}
