import XCTest

final class AppStatesStorageTests: XCTestCase {
    private var userDefaults: UserDefaults!
    private var storage: AppStatesStorageProtocol!

    override func setUpWithError() throws {
        try super.setUpWithError()
        userDefaults = UserDefaults.init(suiteName: "Test")!
        userDefaults.removePersistentDomain(forName: "Test")
        storage = AppStatesStorage(userDefaults)
    }

    override func tearDownWithError() throws {
        userDefaults.removePersistentDomain(forName: "Test")
        userDefaults = nil
        storage = nil
        try super.tearDownWithError()
    }

    // Summary Section 확장 여부 테스트
    func testIsExpanded() throws {
        // 지정한 적이 없으면, 기본값은 false
        XCTAssertEqual(storage.isExpanded(at: 3), false)

        // true로 변경 후 확인
        storage.updateIsExpanded(at: 3, value: true)
        XCTAssertEqual(storage.isExpanded(at: 3), true)
    }

    // 마지막으로 열람한 seriesNumber 테스트
    func testLastSelectedSeriesNumber() throws {
        // 지정한 적이 없으면, 기본값은 1권
        XCTAssertEqual(storage.lastSelectedSeriesNumber(), 1)

        // 6권으로 변경 후 테스트
        storage.updateLastSelectedSeriesNumber(to: 6)
        XCTAssertEqual(storage.lastSelectedSeriesNumber(), 6)
    }
}
