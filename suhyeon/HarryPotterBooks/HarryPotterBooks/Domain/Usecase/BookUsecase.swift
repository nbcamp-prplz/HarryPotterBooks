//
//  BookUseCase.swift
//  HarryPotterBooks
//
//  Created by 이수현 on 3/25/25.
//

import Foundation

protocol BookUseCaseProtocol {
    func fetchBooks() async -> Result<[Book], DataError> // 책 리스트 가져오기
}

class BookUseCase: BookUseCaseProtocol {
    private let bookRepository: BookRepositoryProtocol
    
    init(bookRepository: BookRepositoryProtocol) {
        self.bookRepository = bookRepository
    }
    
    func fetchBooks() async -> Result<[Book], DataError>{
        await bookRepository.fetchBooks()
    }
}
