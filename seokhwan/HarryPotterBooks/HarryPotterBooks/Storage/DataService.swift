import Foundation

enum DataService {
    enum DataError: Error {
        case fileNotFound
        case parsingFailed
    }

    static func fetchBooks() -> Result<Books, DataError> {
        guard let path = Bundle.main.path(forResource: "data", ofType: "json") else {
            return .failure(.fileNotFound)
        }

        do {
            let data = try Data(contentsOf: URL(filePath: path))
            let booksResponse = try JSONDecoder().decode(BooksResponseDTO.self, from: data)
            let books = booksResponse.data
                .enumerated()
                .map { Book(from: $0.element.attributes, with: $0.offset + 1) }

            return .success(books)
        } catch {
            return .failure(.parsingFailed)
        }
    }
}
