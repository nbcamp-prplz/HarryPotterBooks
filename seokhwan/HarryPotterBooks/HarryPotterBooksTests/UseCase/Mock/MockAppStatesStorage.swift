import Foundation

final class MockAppStatesStorage: AppStatesStorageProtocol {
    private var mock = [String: Any]()

    func isExpanded(at seriesNumber: Int) -> Bool {
        let key = userDefaultsKey(.isExpanded, at: seriesNumber)
        return mock[key] as? Bool ?? false
    }

    func updateIsExpanded(at seriesNumber: Int, value: Bool) {
        let key = userDefaultsKey(.isExpanded, at: seriesNumber)
        mock[key] = value
    }

    func lastSelectedSeriesNumber() -> Int {
        let key = userDefaultsKey(.lastSelectedSeriesNumber)
        return mock[key] as? Int ?? 1
    }

    func updateLastSelectedSeriesNumber(to seriesNumber: Int) {
        let key = userDefaultsKey(.lastSelectedSeriesNumber)
        mock[key] = seriesNumber
    }

    private func userDefaultsKey(_ type: UserDefaultsKeyType, at index: Int? = nil) -> String {
        let postfix = index == nil ? "" : "at\(index!)"
        return "\(type.rawValue)\(postfix)"
    }
}
