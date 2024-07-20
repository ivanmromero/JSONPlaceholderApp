//
//  UserTableViewCell.swift
//  JSONPlaceholderApp
//
//  Created by Ivan Romero on 20/07/2024.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var stackView: UIStackView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        addLabelsOnStackView()
    }
    
    private func addLabelsOnStackView() {
        UserDataCell.allCases.forEach( { _ in stackView.addArrangedSubview(UILabel()) } )
    }
    
    func set(text: String, for data: UserDataCell) {
        guard let label = stackView.subviews[data.rawValue] as? UILabel else { return }
        
        label.text = data != .birthDate ? text : text.convertDate()
    }
    
    enum UserDataCell: Int, CaseIterable {
        case firstName
        case lastName
        case birthDate
        case email
        case website
    }
}
