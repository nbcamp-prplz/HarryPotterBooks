import Foundation
import Combine

protocol MainViewModelInput {
    func selectBook(at seriesNumber: Int)
}

protocol MainViewModelOutput {
    var selectedBook: CurrentValueSubject<Book?, Never> { get }
    var errorMessage: CurrentValueSubject<String?, Never> { get }
}

final class MainViewModel: MainViewModelInput, MainViewModelOutput {
    var selectedBook = CurrentValueSubject<Book?, Never>(nil)
    var errorMessage = CurrentValueSubject<String?, Never>(nil)

    private var books = Books()

    private let fetchBooksUseCase: FetchableBooksUseCase
    private let fetchExpandedStateUseCase: FetchExpandedStateUseCase

    init(
        fetchBooksUseCase: FetchableBooksUseCase = FetchBooksUseCase(),
        fetchExpandedStateUseCase: FetchExpandedStateUseCase = FetchExpandedStateUseCase()
    ) {
        self.fetchBooksUseCase = fetchBooksUseCase
        self.fetchExpandedStateUseCase = fetchExpandedStateUseCase

        loadBooks()
    }

    func selectBook(at seriesNumber: Int) {
        guard books.indices.contains(seriesNumber - 1) else { return }

        books[seriesNumber - 1].isExpanded = fetchExpandedStateUseCase.execute(at: seriesNumber)
        selectedBook.send(books[seriesNumber - 1])
    }

    private func loadBooks() {
        switch fetchBooksUseCase.execute() {
        case .failure(let error):
            errorMessage.send(error.localizedDescription)
        case .success(let books):
            self.books = books
            selectBook(at: 1)
        }
    }
}
