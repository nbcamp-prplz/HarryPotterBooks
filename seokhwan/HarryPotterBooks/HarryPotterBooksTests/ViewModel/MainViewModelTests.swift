import XCTest
import Combine

final class MainViewModelTests: XCTestCase {
    private var viewModel: MainViewModel!
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
        viewModel = nil
        books = nil
        cancellables = nil
        try super.tearDownWithError()
    }

    // Books 로드 성공 테스트
    func testLoadBooksSuccess() throws {
        let mock = MockFetchBooksUseCase(result: .success(books))
        viewModel = MainViewModel(fetchBooksUseCase: mock)

        viewModel.selectedBook
            .dropFirst()
            .sink { book in
                XCTAssertEqual(book?.title, "First Book")
            }
            .store(in: &cancellables)
    }

    // Books 로드 실패 테스트
    func testLoadBooksFailure() throws {
        let error = DataError.parsingFailed
        let mock = MockFetchBooksUseCase(result: .failure(error))
        viewModel = MainViewModel(fetchBooksUseCase: mock)

        viewModel.errorMessage
            .dropFirst()
            .sink { message in
                XCTAssertEqual(message, error.localizedDescription)
            }
            .store(in: &cancellables)
    }

    // 올바른 인덱스 선택 테스트
    func testSelectBookAtValidIndex() throws {
        let mock = MockFetchBooksUseCase(result: .success(books))
        viewModel = MainViewModel(fetchBooksUseCase: mock)

        let nextIndex = 1

        viewModel.selectedBook
            .dropFirst()
            .compactMap { $0 }
            .sink { book in
                XCTAssertEqual(book.seriesNumber, nextIndex)
            }
            .store(in: &cancellables)

        viewModel.selectBook(at: nextIndex)
    }

    // 올바르지 않은 인덱스 선택 테스트
    func testSelectBookAtInvalidIndex() throws {
        let mock = MockFetchBooksUseCase(result: .success(books))
        viewModel = MainViewModel(fetchBooksUseCase: mock)

        var updateCount = 0

        viewModel.selectedBook
            .dropFirst()
            .sink { _ in
                updateCount += 1
            }
            .store(in: &cancellables)

        viewModel.selectBook(at: -5)
        XCTAssertEqual(updateCount, 0) // 올바르지 않은 인덱스일 경우 selectBook의 변경이 없어야 하고, updateCount가 증가하면 안됨

        viewModel.selectBook(at: 9)
        XCTAssertEqual(updateCount, 0) // 올바르지 않은 인덱스일 경우 selectBook의 변경이 없어야 하고, updateCount가 증가하면 안됨
    }

    func testToggleExpandedStateOfSelectedBook() throws {
        let mockTrue = MockFetchExpandedStateUseCase(result: true)
        viewModel = MainViewModel(fetchExpandedStateUseCase: mockTrue)
        viewModel.toggleExpandedStateOfSelectedBook()
        XCTAssertEqual(viewModel.selectedBook.value?.isExpanded, false)

        let mockFalse = MockFetchExpandedStateUseCase(result: false)
        viewModel = MainViewModel(fetchExpandedStateUseCase: mockFalse)
        viewModel.toggleExpandedStateOfSelectedBook()
        XCTAssertEqual(viewModel.selectedBook.value?.isExpanded, true)
    }
}
