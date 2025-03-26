import Foundation

final class FetchBooksUseCase {
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
