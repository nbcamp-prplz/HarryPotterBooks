//
//  BookUsecase.swift
//  HarryPotterBooks
//
//  Created by 이수현 on 3/25/25.
//

import Foundation

protocol BookUsecaseProtocol {
    func fetchBookList() async -> Result<[Book], DataError> // 책 리스트 가져오기
}

class BookUsecase: BookUsecaseProtocol {
    private let bookRepository: BookRepositoryProtocol
    
    init(bookRepository: BookRepositoryProtocol) {
        self.bookRepository = bookRepository
    }
    
    func fetchBookList() async -> Result<[Book], DataError>{
        await bookRepository.fetchBookList()
    }
}
