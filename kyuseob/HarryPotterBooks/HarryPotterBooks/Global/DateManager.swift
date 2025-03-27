//
//  DateManager.swift
//  HarryPotterBooks
//
//  Created by 송규섭 on 3/26/25.
//

import Foundation

//"release_date": "1997-06-26"
class DateManager {
    static let shared = DateManager()
    
    func convertDate(from released: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        let convertDate = dateFormatter.date(from: released)
        
        let myDateFormatter = DateFormatter()
        myDateFormatter.dateFormat = "MMMM dd, yyyy"
        
        return myDateFormatter.string(from: convertDate!)
    }
}
