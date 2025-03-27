//
//  Date + Extension.swift
//  HarryPotterNovelInfo
//
//  Created by GO on 3/26/25.
//

import Foundation

extension Date {
    func dateFormatter() -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        formatter.dateStyle = .long
        let result = formatter.string(from: self)
        return "Released : \(result)"
    }
}

