import Foundation
import Combine

final class MainViewModel {
    private var books = Books()
    @Published var selectedBook: Book?
    @Published var errorMessage: String?

    private let fetchBooksUseCase: FetchableBooksUseCase

    init() {
        fetchBooksUseCase = FetchBooksUseCase()
        loadBooks()
    }

    func loadBooks() {
        switch fetchBooksUseCase.execute() {
        case .failure(let error):
            errorMessage = error.localizedDescription
        case .success(let books):
            self.books = books
            selectBook(at: books.startIndex)
        }
    }

    func selectBook(at index: Int) {
        guard books.indices.contains(index) else { return }
        selectedBook = books[index]
    }
}
