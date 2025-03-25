//
//  BookRepositoryProtocol.swift
//  HarryPotterBooks
//
//  Created by 이수현 on 3/25/25.
//

import Foundation

protocol BookRepositoryProtocol {
    func fetchBookList() async -> Result<[Book], DataError> // 책 리스트 가져오기
}
