import XCTest

final class AppStatesStorageTests: XCTestCase {
    private var userDefaults: UserDefaults!
    private var storage: AppStatesStorageProtocol!

    override func setUpWithError() throws {
        userDefaults = UserDefaults.init(suiteName: "Test")!
        userDefaults.removePersistentDomain(forName: "Test")
        storage = AppStatesStorage(userDefaults)
    }

    override func tearDownWithError() throws {
        userDefaults.removePersistentDomain(forName: "Test")
        userDefaults = nil
        storage = nil
    }

    func testIsExpanded() throws {
        XCTAssertEqual(storage.isExpanded(at: 3), false)

        storage.updateIsExpanded(at: 3, value: true)
        XCTAssertEqual(storage.isExpanded(at: 3), true)
    }

    func testLastSelectedSeriesNumber() throws {
        XCTAssertEqual(storage.lastSelectedSeriesNumber(), 1)

        storage.updateLastSelectedSeriesNumber(to: 6)
        XCTAssertEqual(storage.lastSelectedSeriesNumber(), 6)
    }
}
