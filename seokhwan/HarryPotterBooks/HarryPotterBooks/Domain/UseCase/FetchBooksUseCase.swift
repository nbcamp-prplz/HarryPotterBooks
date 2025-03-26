import Foundation

protocol FetchableBooksUseCase {
    func execute() -> Result<Books, DataError>
}

final class FetchBooksUseCase: FetchableBooksUseCase {
    let dataService: DataServiceProtocol

    init() {
        dataService = DataService()
    }

    init(dataService: DataServiceProtocol) {
        self.dataService = dataService
    }

    func execute() -> Result<Books, DataError> {
        return dataService.fetchBooks()
    }
}
