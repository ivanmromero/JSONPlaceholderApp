//
//  UsersViewController.swift
//  JSONPlaceholderApp
//
//  Created by Ivan Romero on 20/07/2024.
//

import UIKit

class UsersViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!

    private let viewModel: UsersViewModel

    init(viewModel: UsersViewModel) {
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
        title = "Users"
        setup(tableView: tableView)
        fetchUsers()
    }

    private func setup(tableView: UITableView) {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: String(describing: UserTableViewCell.self), bundle: nil),
                           forCellReuseIdentifier: "usercell" )
    }

    private func fetchUsers() {
        viewModel.fetchUsers {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension UsersViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.getCountOfUsers()
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "usercell", for: indexPath) as? UserTableViewCell
        else {
            return UITableViewCell()
        }

        if let user = viewModel.getUser(for: indexPath.row) {
            cell.set(text: user.firstname, for: .firstName)
            cell.set(text: user.lastname, for: .lastName)
            cell.set(text: user.birthDate, for: .birthDate)
            cell.set(text: user.email, for: .email)
            cell.set(text: user.website, for: .website)
        }

        cell.accessoryType = .disclosureIndicator

        return cell
    }
}

// MARK: - UITableViewDelegate
extension UsersViewController: UITableViewDelegate {

}
