import Foundation

protocol FetchableBooksUseCase {
    func execute() -> Result<Books, DataError>
}

final class FetchBooksUseCase: FetchableBooksUseCase {
    private let dataService: DataServiceProtocol
    
    init(dataService: DataServiceProtocol = DataService()) {
        self.dataService = dataService
    }

    func execute() -> Result<Books, DataError> {
        return dataService.fetchBooks()
    }
}
