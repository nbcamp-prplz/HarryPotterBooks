import Foundation

enum DataError: Error {
    case fileNotFound
    case parsingFailed

    var localizedDescription: String {
        switch self {
        case .fileNotFound:
            return "파일을 찾을 수 없습니다."
        case .parsingFailed:
            return "데이터 파싱에 실패했습니다."
        }
    }
}

protocol DataServiceProtocol {
    func fetchBooks() -> Result<Books, DataError>
}

final class DataService: DataServiceProtocol {
    func fetchBooks() -> Result<Books, DataError> {
        guard let path = Bundle.main.path(forResource: "data", ofType: "json") else {
            return .failure(.fileNotFound)
        }

        do {
            let data = try Data(contentsOf: URL(filePath: path))
            let booksResponse = try JSONDecoder().decode(BooksResponseDTO.self, from: data)
            let books = booksResponse.data
                .enumerated()
                .map { Book(from: $0.element.attributes, with: $0.offset + 1) }
            // JSON에 seriesNumber가 없기 때문에, index + 1을 seriesNumber로 부여

            return .success(books)
        } catch {
            return .failure(.parsingFailed)
        }
    }
}
