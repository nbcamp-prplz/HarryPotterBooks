import Foundation
import Combine

protocol MainViewModelInput {
    func selectBook(at seriesNumber: Int)
    func toggleExpandedStateOfSelectedBook()
}

protocol MainViewModelOutput {
    var numberOfBooks: CurrentValueSubject<Int, Never> { get }
    var selectedBook: CurrentValueSubject<Book?, Never> { get }
    var errorMessage: CurrentValueSubject<String?, Never> { get }
}

final class MainViewModel: MainViewModelInput, MainViewModelOutput {
    var numberOfBooks = CurrentValueSubject<Int, Never>(0)
    var selectedBook = CurrentValueSubject<Book?, Never>(nil)
    var errorMessage = CurrentValueSubject<String?, Never>(nil)

    private var books = Books()

    private let fetchBooksUseCase: FetchableBooksUseCase
    private let fetchExpandedStateUseCase: FetchExpandedStateUseCase
    private let updateExpandedStateUseCase: UpdateExpandedStateUseCase
    private let fetchLastSelectedSeriesNumberUseCase: FetchLastSelectedSeriesNumberUseCase
    private let updateLastSelectedSeriesNumberUseCase: UpdateLastSelectedSeriesNumberUseCase

    init(
        fetchBooksUseCase: FetchableBooksUseCase = FetchBooksUseCase(),
        fetchExpandedStateUseCase: FetchExpandedStateUseCase = FetchExpandedStateUseCase(),
        updateExpandedStateUseCase: UpdateExpandedStateUseCase = UpdateExpandedStateUseCase(),
        fetchLastSelectedSeriesNumberUseCase: FetchLastSelectedSeriesNumberUseCase = FetchLastSelectedSeriesNumberUseCase(),
        updateLastSelectedSeriesNumberUseCase: UpdateLastSelectedSeriesNumberUseCase = UpdateLastSelectedSeriesNumberUseCase()
    ) {
        self.fetchBooksUseCase = fetchBooksUseCase
        self.fetchExpandedStateUseCase = fetchExpandedStateUseCase
        self.updateExpandedStateUseCase = updateExpandedStateUseCase
        self.fetchLastSelectedSeriesNumberUseCase = fetchLastSelectedSeriesNumberUseCase
        self.updateLastSelectedSeriesNumberUseCase = updateLastSelectedSeriesNumberUseCase

        loadBooks()
    }

    func selectBook(at seriesNumber: Int) {
        guard books.indices.contains(seriesNumber - 1) else { return }

        books[seriesNumber - 1].isExpanded = fetchExpandedStateUseCase.execute(at: seriesNumber)
        selectedBook.send(books[seriesNumber - 1])
        updateLastSelectedSeriesNumberUseCase.execute(to: seriesNumber)
    }

    func toggleExpandedStateOfSelectedBook() {
        guard let seriesNumber = selectedBook.value?.seriesNumber else { return }

        books[seriesNumber - 1].isExpanded.toggle()
        selectedBook.send(books[seriesNumber - 1])

        updateExpandedStateUseCase.execute(at: seriesNumber, isExpanded: books[seriesNumber - 1].isExpanded)
    }

    private func loadBooks() {
        switch fetchBooksUseCase.execute() {
        case .failure(let error):
            errorMessage.send(error.localizedDescription)
        case .success(let books):
            self.books = books
            numberOfBooks.send(books.count)
            let lastSelectedSeriesNumber = fetchLastSelectedSeriesNumberUseCase.execute()
            selectBook(at: lastSelectedSeriesNumber)
        }
    }
}
