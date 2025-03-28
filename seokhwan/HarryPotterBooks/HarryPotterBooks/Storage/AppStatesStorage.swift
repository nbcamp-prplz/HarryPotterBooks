import Foundation

final class AppStatesStorage {
    enum KeyType: String {
        case isExpanded
        case lastSelectedSeriesNumber
    }

    func isExpanded(at seriesNumber: Int) -> Bool {
        let key = userDefaultsKey(.isExpanded, at: seriesNumber)

        return UserDefaults.standard.bool(forKey: key)
    }

    func updateIsExpanded(at seriesNumber: Int, value: Bool) {
        let key = userDefaultsKey(.isExpanded, at: seriesNumber)

        UserDefaults.standard.set(value, forKey: key)
    }

    func lastSelectedSeriesNumber() -> Int {
        let key = userDefaultsKey(.lastSelectedSeriesNumber)
        let value = UserDefaults.standard.integer(forKey: key)

        return value == 0 ? 1 : value
    }

    func updateLastSelectedSeriesNumber(to seriesNumber: Int) {
        let key = userDefaultsKey(.lastSelectedSeriesNumber)

        return UserDefaults.standard.set(seriesNumber, forKey: key)
    }

    private func userDefaultsKey(_ type: AppStatesStorage.KeyType, at index: Int? = nil) -> String {
        let postfix = index == nil ? "" : "at\(index!)"

        return "\(type.rawValue)\(postfix)"
    }
}
