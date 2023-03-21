//
//  String.swift
//  MoviesApp
//
//  Created by Muhammad Usman on 17/03/2023.
//

import Foundation

enum DateFormate: String {
    case eeee_mm_yyyy = "EEEE MM,yyyy"
    case yyyy = "yyyy"
}

extension String {
    func formattedDate(formate: DateFormate = .eeee_mm_yyyy) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        dateFormatter.locale = Locale(identifier: "en_us")
        let date = dateFormatter.date(from: self)
        dateFormatter.dateFormat = formate.rawValue
        guard let date = date else { return "" }
        let resultString = dateFormatter.string(from: date)
        return resultString
    }

    var localized: String {
        return NSLocalizedString(self, comment: "\(self)_comment")
    }
}
