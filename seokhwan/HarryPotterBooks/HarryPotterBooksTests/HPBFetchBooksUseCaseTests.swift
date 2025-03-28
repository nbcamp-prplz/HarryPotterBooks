import XCTest

final class DataServiceMock: DataServiceProtocol {
    func fetchBooks() -> Result<Books, DataError> {
        let firstBookDTO = BookDTO(
            title: "First Book",
            author: "author",
            pages: 100,
            releaseDate: "2025-03-26",
            dedication: "dedication",
            summary: "summary",
            wiki: "wiki",
            chapters: [ChapterDTO(title: "title"), ChapterDTO(title: "title")]
        )
        let secondBookDTO = BookDTO(
            title: "Second Book",
            author: "author",
            pages: 100,
            releaseDate: "2025-03-26",
            dedication: "dedication",
            summary: "summary",
            wiki: "wiki",
            chapters: [ChapterDTO(title: "title"), ChapterDTO(title: "title")]
        )
        let books: Books = [
            Book(from: firstBookDTO, with: 1),
            Book(from: secondBookDTO, with: 2),
        ]

        return .success(books)
    }
}

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
