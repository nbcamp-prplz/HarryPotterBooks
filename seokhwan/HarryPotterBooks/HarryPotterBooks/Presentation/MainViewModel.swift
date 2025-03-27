import Foundation
import Combine

protocol MainViewModelInput {
    func selectBook(at index: Int)
}

protocol MainViewModelOutput {
    var selectedBook: CurrentValueSubject<Book?, Never> { get }
    var errorMessage: CurrentValueSubject<String?, Never> { get }
}

final class MainViewModel: MainViewModelInput, MainViewModelOutput {
    private var books = Books()
    private let fetchBooksUseCase: FetchableBooksUseCase

    var selectedBook = CurrentValueSubject<Book?, Never>(nil)
    var errorMessage = CurrentValueSubject<String?, Never>(nil)

    init(fetchBooksUseCase: FetchableBooksUseCase = FetchBooksUseCase()) {
        self.fetchBooksUseCase = fetchBooksUseCase
        loadBooks()
    }

    func selectBook(at index: Int) {
        guard let selectedIndex = selectedBook.value?.seriesNumber,
              selectedIndex != index,
              books.indices.contains(index) else { return }
        selectedBook.send(books[index])
    }

    private func loadBooks() {
        switch fetchBooksUseCase.execute() {
        case .failure(let error):
            errorMessage.send(error.localizedDescription)
        case .success(let books):
            self.books = books
            selectBook(at: books.startIndex)
        }
    }
}
