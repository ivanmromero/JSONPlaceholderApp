//
//  String+Extensions.swift
//  JSONPlaceholderApp
//
//  Created by Ivan Romero on 20/07/2024.
//

import Foundation

extension String {
    func convertDate(fromFormat inputFormat: String = "yyyy-MM-dd",
                     toFormat outputFormat: String = "dd/MM/yyyy") -> String? {
        let inputDateFormatter = DateFormatter()
        inputDateFormatter.dateFormat = inputFormat

        if let date = inputDateFormatter.date(from: self) {
            let outputDateFormatter = DateFormatter()
            outputDateFormatter.dateFormat = outputFormat

            return outputDateFormatter.string(from: date)
        }

        return nil
    }
}
