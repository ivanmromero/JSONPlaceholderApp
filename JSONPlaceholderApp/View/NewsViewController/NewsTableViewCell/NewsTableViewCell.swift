//
//  NewsTableViewCell.swift
//  JSONPlaceholderApp
//
//  Created by Ivan Romero on 18/07/2024.
//

import UIKit

class NewsTableViewCell: UITableViewCell {
    @IBOutlet weak var thumbnailImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var littleContent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
