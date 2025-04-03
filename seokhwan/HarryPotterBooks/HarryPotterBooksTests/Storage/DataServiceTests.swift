import XCTest

final class DataServiceTests: XCTestCase {
    private var dataService: DataServiceProtocol!

    override func setUpWithError() throws {
        try super.setUpWithError()
        dataService = DataService()
    }

    override func tearDownWithError() throws {
        dataService = nil
        try super.tearDownWithError()
    }

    // JSON 파싱이 잘 되는지 테스트
    func testJSONParsing() throws {
        let expectedBooksCount = 7
        let expectedFirstBookTitle = "Harry Potter and the Philosopher's Stone"

        switch dataService.fetchBooks() {
        case .success(let books):
            XCTAssertEqual(books.count, expectedBooksCount)
            XCTAssertEqual(books.first?.title, expectedFirstBookTitle)
        case .failure:
            XCTFail()
        }
    }
}
