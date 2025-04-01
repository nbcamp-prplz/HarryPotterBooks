import XCTest

final class FetchBooksUseCaseTests: XCTestCase {
    var fetchBooksUseCase: FetchableBooksUseCase!

    override func setUpWithError() throws {
        let mock = MockDataService()
        fetchBooksUseCase = FetchBooksUseCase(dataService: mock)
    }

    override func tearDownWithError() throws {
        fetchBooksUseCase = nil
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
