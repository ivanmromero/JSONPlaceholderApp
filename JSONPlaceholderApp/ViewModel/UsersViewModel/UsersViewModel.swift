//
//  UsersViewModel.swift
//  JSONPlaceholderApp
//
//  Created by Ivan Romero on 20/07/2024.
//

import Foundation

final class UsersViewModel {
    private let service: Service
    private var users: Users

    init(service: Service) {
        self.service = service
        self.users = []
    }

    func fetchUsers(completion: @escaping () -> Void) {
        service.fetchData(for: .allUsers) { [weak self] (result: Result<Users, ServiceError>) in
            switch result {
            case .success(let users):
                self?.users = users
                completion()
            case .failure(let error):
                error.handleError()
            }
        }
    }

    func getCountOfUsers() -> Int {
        users.count
    }

    func getUser(at index: Int) -> User? {
        guard index >= 0 && index < getCountOfUsers() else { return nil }

        return users[index]
    }
}
