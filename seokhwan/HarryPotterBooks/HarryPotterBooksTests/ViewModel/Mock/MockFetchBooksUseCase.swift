import Foundation

struct MockFetchBooksUseCase: FetchableBooksUseCase {
    var result: Result<Books, DataError>

    func execute() -> Result<Books, DataError> {
        return result
    }
}
