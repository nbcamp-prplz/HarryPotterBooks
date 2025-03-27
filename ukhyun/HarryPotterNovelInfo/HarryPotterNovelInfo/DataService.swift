//
//  Data.swift
//  HarryPotterNovelInfo
//
//  Created by GO on 3/25/25.
//

import UIKit

class DataService: UIViewController {
    
    enum DataError: Error, LocalizedError {
        case fileNotFound
        case parsingFailed(Error)
        
        var errorDescription: String? {
            switch self {
            case .fileNotFound: return "JSON 파일을 찾을 수 없습니다."
            case .parsingFailed(let error): return "JSON 파싱에 실패했습니다: \(error.localizedDescription)"
            }
        }
    }
    
    func loadBooks(completion: @escaping (Result<[BookAttributes], Error>) -> Void) {
        guard let path = Bundle.main.path(forResource: "data", ofType: "json") else {
            completion(.failure(DataError.fileNotFound))
            return
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let bookResponse = try JSONDecoder().decode(BookData.self, from: data)
            let books = bookResponse.data.map { $0.attributes }
            print("JSON 파싱 성공")
            completion(.success(books))
        } catch {
            print("🚨 JSON 파싱 에러 : \(error)")
            showAlert(text: "JSON 데이터 파싱 실패", message: "확인")
            completion(.failure(DataError.parsingFailed(error)))
        }
    }
}


