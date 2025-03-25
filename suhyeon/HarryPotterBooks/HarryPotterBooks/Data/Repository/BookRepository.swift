//
//  BookRepository.swift
//  HarryPotterBooks
//
//  Created by 이수현 on 3/25/25.
//

import Foundation

class BookRepository: BookRepositoryProtocol {
    private let network: BookNetworkProtocol
    
    init(network: BookNetworkProtocol) {
        self.network = network
    }
    
    func fetchBookList() async -> Result<[Book], DataError> {
        await network.fetchBookList()
    }
}
