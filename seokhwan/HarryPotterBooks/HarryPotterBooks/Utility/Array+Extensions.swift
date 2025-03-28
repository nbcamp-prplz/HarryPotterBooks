import Foundation

extension Array where Element == Chapter {
    var joinedTitles: String {
        return map { $0.title }.joined(separator: "\n")
    }
}
