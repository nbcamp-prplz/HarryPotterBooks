import Foundation

enum FetchBooksUseCase {
    static func execute() -> Result<Books, DataService.DataError> {
        return DataService.fetchBooks()
    }
}
