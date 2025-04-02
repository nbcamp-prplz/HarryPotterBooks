import Foundation

enum UserDefaultsKeyType: String {
    case isExpanded
    case lastSelectedSeriesNumber
}

protocol AppStatesStorageProtocol {
    func isExpanded(at seriesNumber: Int) -> Bool
    func updateIsExpanded(at seriesNumber: Int, value: Bool)
    func lastSelectedSeriesNumber() -> Int
    func updateLastSelectedSeriesNumber(to seriesNumber: Int)
}

final class AppStatesStorage: AppStatesStorageProtocol {
    private let userDefaults: UserDefaults

    init(_ userDefaults: UserDefaults = .standard) {
        self.userDefaults = userDefaults
    }

    func isExpanded(at seriesNumber: Int) -> Bool {
        let key = userDefaultsKey(.isExpanded, at: seriesNumber)

        return userDefaults.bool(forKey: key)
    }

    func updateIsExpanded(at seriesNumber: Int, value: Bool) {
        let key = userDefaultsKey(.isExpanded, at: seriesNumber)

        userDefaults.set(value, forKey: key)
    }

    func lastSelectedSeriesNumber() -> Int {
        let key = userDefaultsKey(.lastSelectedSeriesNumber)
        let value = userDefaults.integer(forKey: key)

        return value == 0 ? 1 : value // 기본값(0)일 경우, 1권을 기본값으로 지정
    }

    func updateLastSelectedSeriesNumber(to seriesNumber: Int) {
        let key = userDefaultsKey(.lastSelectedSeriesNumber)

        return userDefaults.set(seriesNumber, forKey: key)
    }

    // index에 따라 동적인 UserDefaultsKey를 만들기 위한 메서드
    private func userDefaultsKey(_ type: UserDefaultsKeyType, at index: Int? = nil) -> String {
        let suffix = index == nil ? "" : "at\(index!)"

        return "\(type.rawValue)\(suffix)"
    }
}
