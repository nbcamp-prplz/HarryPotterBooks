import XCTest

final class FetchBooksUseCaseTests: XCTestCase {
    private var useCase: FetchableBooksUseCase!

    override func setUpWithError() throws {
        try super.setUpWithError()
        let mock = MockDataService()
        useCase = FetchBooksUseCase(dataService: mock)
    }

    override func tearDownWithError() throws {
        useCase = nil
        try super.tearDownWithError()
    }

    func testExecute() throws {
        let expectedBooksCount = 2
        let expectedFirstBookTitle = "First Book"

        switch useCase.execute() {
        case .success(let books):
            XCTAssertEqual(books.count, expectedBooksCount)
            XCTAssertEqual(books.first?.title, expectedFirstBookTitle)
        case .failure:
            XCTFail()
        }
    }
}
