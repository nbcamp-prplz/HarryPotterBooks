import XCTest

final class FetchBooksUseCaseTests: XCTestCase {
    private var fetchBooksUseCase: FetchableBooksUseCase!

    override func setUpWithError() throws {
        try super.setUpWithError()
        let mock = MockDataService()
        fetchBooksUseCase = FetchBooksUseCase(dataService: mock)
    }

    override func tearDownWithError() throws {
        fetchBooksUseCase = nil
        try super.tearDownWithError()
    }

    func testExecute() throws {
        let expectedBooksCount = 2
        let expectedFirstBookTitle = "First Book"

        switch fetchBooksUseCase.execute() {
        case .success(let books):
            XCTAssertEqual(books.count, expectedBooksCount)
            XCTAssertEqual(books.first?.title, expectedFirstBookTitle)
        case .failure:
            XCTFail()
        }
    }
}
