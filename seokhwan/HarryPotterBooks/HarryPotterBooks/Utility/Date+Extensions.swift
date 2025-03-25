import Foundation

extension Date {
    static func from(dateString: String, with format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format

        return dateFormatter.date(from: dateString)
    }
}
