import Foundation

class DataService {
    func loadBooks() throws -> [Book] {
        guard let path = Bundle.main.path(forResource: "data", ofType: "json") else {
            throw DataError.fileNotFound
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let bookResponse = try JSONDecoder().decode(BookResponse.self, from: data)
            let books = bookResponse.data.map { $0.attributes }
            return books
        } catch {
            print("🚨 JSON 파싱 에러 : \(error)")
            throw DataError.parsingFailed
        }
    }
}

