import XCTest

final class ExtensionsTests: XCTestCase {
    // 챕터들이 하나의 String으로 올바르게 join됐는지 테스트
    func testChaptersJoinedTitles() throws {
        let chapters1 = [
            Chapter(from: ChapterDTO(title: "first")),
            Chapter(from: ChapterDTO(title: "second")),
            Chapter(from: ChapterDTO(title: "third")),
        ]
        let chapters2 = [Chapter(from: ChapterDTO(title: "first"))]
        let chapters3 = Chapters()

        XCTAssertEqual(chapters1.joinedTitles, "first\nsecond\nthird")
        XCTAssertEqual(chapters2.joinedTitles, "first")
        XCTAssertEqual(chapters3.joinedTitles, "")
    }

    // String 값을 Date 타입으로 초기화가 올바르게 됐는지 테스트
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

    // 출시일 항목에 맞게 올바르게 formatting 됐는지 테스트
    func testReleasedString() throws {
        let dateString = "2025-03-26"
        let format = "yyyy-MM-dd"
        let date = Date.from(dateString: dateString, with: format)

        XCTAssertNotNil(date)

        let releasedString = date!.releasedString()
        let expectedReleasedString = "March 26, 2025"

        XCTAssertEqual(releasedString, expectedReleasedString)
    }
}
