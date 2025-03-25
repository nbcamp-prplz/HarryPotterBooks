//
//  BookNetwork.swift
//  HarryPotterBooks
//
//  Created by 이수현 on 3/25/25.
//

import Foundation

protocol BookNetworkProtocol {
    func fetchBookList() async -> Result<[Book], DataError>
}

class BookNetwork: BookNetworkProtocol {
    
    func fetchBookList() async -> Result<[Book], DataError> {
        guard let path = Bundle.main.path(forResource: "data", ofType: "json") else {
            return .failure(.fileNotFound)
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let bookResponse = try JSONDecoder().decode(BookResponseDTO.self, from: data)
            return .success(bookResponse.attributes)
        } catch {
            return .failure(.parsingFaild)
        }
    }
}
