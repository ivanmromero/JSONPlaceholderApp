//
//  NewsViewController.swift
//  JSONPlaceholderApp
//
//  Created by Ivan Romero on 18/07/2024.
//

import UIKit

final class NewsViewController: UIViewController {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!

    private let viewModel: NewsViewModel

    init(viewModel: NewsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    private func setup() {
        title = "News"
        setup(tableView: tableView)
        setup(searchBar: searchBar)
        fetchNews()
    }

    private func setup(tableView: UITableView) {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "NewsTableViewCell", bundle: nil), forCellReuseIdentifier: "NewsCell")
    }

    private func setup(searchBar: UISearchBar) {
        searchBar.delegate = self
        searchBar.placeholder = "Search news"
    }

    private func fetchNews() {
        viewModel.fetchNews { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getCountOfNews()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsTableViewCell
        else {
            return UITableViewCell()
        }

        if let newsElement = viewModel.getNewsElement(at: indexPath.row) {
            cell.titleLabel.text = newsElement.title
            cell.littleContentLabel.text = newsElement.content
            cell.thumbnailImage.image = viewModel.getThumbnailImage(for: newsElement.thumbnail)
            cell.accessoryType = .disclosureIndicator
        }

        return cell
    }
}

// MARK: - UITableViewDelegate
extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let newsElement = viewModel.getNewsElement(at: indexPath.row) {

            viewModel.getImage(for: newsElement) { [weak self] coverImage in
                DispatchQueue.main.async {
                    let viewModel = NewsDetailViewModel(newsElement: newsElement, coverImage: coverImage)
                    let viewController = NewsDetailViewController(viewModel: viewModel)

                    self?.navigationController?.pushViewController(viewController, animated: true)
                }
            }
        }
    }
}

// MARK: - UISearchBarDelegate
extension NewsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterNews(for: searchText)
        tableView.reloadData()
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        tableView.reloadData()
    }
}
