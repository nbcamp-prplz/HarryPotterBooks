import XCTest

final class HPBExtensionsTests: XCTestCase {
    override func setUpWithError() throws {

    }

    override func tearDownWithError() throws {

    }

    func testInitializeDateFromString() throws {
        let dateString = "2025-03-26"
        let format = "yyyy-MM-dd"
        let date = Date.from(dateString: dateString, with: format)

        XCTAssertNotNil(date)

        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date!)

        XCTAssertEqual(components.year, 2025)
        XCTAssertEqual(components.month, 3)
        XCTAssertEqual(components.day, 26)
    }

    func testtoReleasedString() throws {
        let dateString = "2025-03-26"
        let format = "yyyy-MM-dd"
        let date = Date.from(dateString: dateString, with: format)

        XCTAssertNotNil(date)

        let releasedString = date!.toReleasedString()
        let expectedReleasedString = "March 26, 2025"

        XCTAssertEqual(releasedString, expectedReleasedString)
    }
}
