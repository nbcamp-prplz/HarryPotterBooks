import Foundation
import Combine

final class MainViewModel {
    private var books = Books()

    @Published var bookTitle = "HarryPotterBooks"
    @Published var seriesNumber = "1"

    init() {
        loadBooks()
    }

    func loadBooks() {
        switch DataService.fetchBooks() {
        case .failure(let error):
            print(error.localizedDescription)
        case .success(let books):
            bookTitle = books.first?.title ?? ""
            seriesNumber = "\(books.first?.seriesNumber ?? 0)"
        }
    }
}
