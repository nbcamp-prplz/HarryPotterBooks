//
//  Date + Extension.swift
//  HarryPotterNovelInfo
//
//  Created by GO on 3/26/25.
//

import Foundation

extension Date {
    func DateToString() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM dd, yyyy"
        let result = formatter.string(from: self)
        return result
    }
}
