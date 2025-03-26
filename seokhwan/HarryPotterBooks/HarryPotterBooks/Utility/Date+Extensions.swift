import Foundation

extension Date {
    static func from(dateString: String, with format: String) -> Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.locale = Locale(identifier: "en_US")

        return dateFormatter.date(from: dateString)
    }

    func releasedString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        dateFormatter.locale = Locale(identifier: "en_US")

        return dateFormatter.string(from: self)
    }
}
