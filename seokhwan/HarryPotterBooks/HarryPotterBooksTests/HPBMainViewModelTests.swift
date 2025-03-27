import XCTest
import Combine

struct FetchBooksUseCaseMock: FetchableBooksUseCase {
    var result: Result<Books, DataError>

    func execute() -> Result<Books, DataError> {
        return result
    }
}

final class HPBMainViewModelTests: XCTestCase {
    var mainViewModel: MainViewModel!
    var books: Books!
    var cancellables: Set<AnyCancellable>!

    override func setUpWithError() throws {
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
        books = [
            Book(from: firstBookDTO, with: 1),
            Book(from: secondBookDTO, with: 2)
        ]
        cancellables = []
    }

    override func tearDownWithError() throws {
        mainViewModel = nil
        books = nil
        cancellables = nil
    }

    func testLoadBooksSuccess() throws {
        let fetchBooksUseCaseMock = FetchBooksUseCaseMock(result: .success(books))
        mainViewModel = MainViewModel(fetchBooksUseCase: fetchBooksUseCaseMock)

        mainViewModel.selectedBook
            .dropFirst()
            .sink { book in
                XCTAssertEqual(book?.title, "First Book")
            }
            .store(in: &cancellables)
    }

    func testLoadBooksFailure() throws {
        let error = DataError.parsingFailed
        let fetchBooksUseCaseMock = FetchBooksUseCaseMock(result: .failure(error))
        mainViewModel = MainViewModel(fetchBooksUseCase: fetchBooksUseCaseMock)

        mainViewModel.errorMessage
            .dropFirst()
            .sink { message in
                XCTAssertEqual(message, error.localizedDescription)
            }
            .store(in: &cancellables)
    }

    func testSelectBookAtValidIndex() throws {
        let mock = FetchBooksUseCaseMock(result: .success(books))
        mainViewModel = MainViewModel(fetchBooksUseCase: mock)

        let nextIndex = 1

        mainViewModel.selectedBook
            .dropFirst()
            .compactMap { $0 }
            .sink { book in
                XCTAssertEqual(book.seriesNumber - 1, nextIndex)
            }
            .store(in: &cancellables)

        mainViewModel.selectBook(at: nextIndex)
    }

    func testSelectBookAtInvalidIndex() throws {
        let mock = FetchBooksUseCaseMock(result: .success(books))
        mainViewModel = MainViewModel(fetchBooksUseCase: mock)

        var updateCount = 0

        mainViewModel.selectedBook
            .dropFirst()
            .sink { _ in
                updateCount += 1
            }
            .store(in: &cancellables)

        mainViewModel.selectBook(at: -5)
        XCTAssertEqual(updateCount, 0)

        mainViewModel.selectBook(at: 9)
        XCTAssertEqual(updateCount, 0)
    }
}
