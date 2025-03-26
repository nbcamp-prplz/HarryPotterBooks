import Foundation
import Combine

final class MainViewModel {
    private var books = Books()

    @Published var selectedBook: Book?
    @Published var errorMessage: String?

    init() {
        loadBooks()
    }

    func loadBooks() {
        switch FetchBooksUseCase.execute() {
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
