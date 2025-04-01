import XCTest
import Combine

final class MainViewModelTests: XCTestCase {
    private var mainViewModel: MainViewModel!
    private var books: Books!
    private var cancellables: Set<AnyCancellable>!

    override func setUpWithError() throws {
        try super.setUpWithError()
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
        try super.tearDownWithError()
    }

    func testLoadBooksSuccess() throws {
        let mock = MockFetchBooksUseCase(result: .success(books))
        mainViewModel = MainViewModel(fetchBooksUseCase: mock)

        mainViewModel.selectedBook
            .dropFirst()
            .sink { book in
                XCTAssertEqual(book?.title, "First Book")
            }
            .store(in: &cancellables)
    }

    func testLoadBooksFailure() throws {
        let error = DataError.parsingFailed
        let mock = MockFetchBooksUseCase(result: .failure(error))
        mainViewModel = MainViewModel(fetchBooksUseCase: mock)

        mainViewModel.errorMessage
            .dropFirst()
            .sink { message in
                XCTAssertEqual(message, error.localizedDescription)
            }
            .store(in: &cancellables)
    }

    func testSelectBookAtValidIndex() throws {
        let mock = MockFetchBooksUseCase(result: .success(books))
        mainViewModel = MainViewModel(fetchBooksUseCase: mock)

        let nextIndex = 1

        mainViewModel.selectedBook
            .dropFirst()
            .compactMap { $0 }
            .sink { book in
                XCTAssertEqual(book.seriesNumber, nextIndex)
            }
            .store(in: &cancellables)

        mainViewModel.selectBook(at: nextIndex)
    }

    func testSelectBookAtInvalidIndex() throws {
        let mock = MockFetchBooksUseCase(result: .success(books))
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

    func testToggleExpandedStateOfSelectedBook() throws {
        let mockTrue = MockFetchExpandedStateUseCase(result: true)
        mainViewModel = MainViewModel(fetchExpandedStateUseCase: mockTrue)
        mainViewModel.toggleExpandedStateOfSelectedBook()
        XCTAssertEqual(mainViewModel.selectedBook.value?.isExpanded, false)

        let mockFalse = MockFetchExpandedStateUseCase(result: false)
        mainViewModel = MainViewModel(fetchExpandedStateUseCase: mockFalse)
        mainViewModel.toggleExpandedStateOfSelectedBook()
        XCTAssertEqual(mainViewModel.selectedBook.value?.isExpanded, true)
    }
}
