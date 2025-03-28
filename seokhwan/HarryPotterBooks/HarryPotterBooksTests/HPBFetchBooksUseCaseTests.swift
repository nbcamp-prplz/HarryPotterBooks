import XCTest

final class HPBFetchBooksUseCaseTests: XCTestCase {
    var fetchBooksUseCase: FetchableBooksUseCase!

    override func setUpWithError() throws {
        let dataServiceMock = DataServiceMock()
        fetchBooksUseCase = FetchBooksUseCase(dataService: dataServiceMock)
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
