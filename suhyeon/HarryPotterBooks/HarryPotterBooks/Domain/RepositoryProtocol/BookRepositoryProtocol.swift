//
//  BookRepositoryProtocol.swift
//  HarryPotterBooks
//
//  Created by 이수현 on 3/25/25.
//

import Foundation

protocol BookRepositoryProtocol {
    func fetchBooks() async -> Result<[Book], DataError> // 책 리스트 가져오기
    func isSavedBooks() -> Bool // // UserDefaults에 저장되어 있는지 확인
    func loadSummaryExpandStatus(books: [Book]) -> [(Book, Bool)]? // UserDefaults에 저장되어 있는 값 반환
    func saveSummaryExpandStatus(books: [Book])  // UserDefaults에 저장되어 있지 않다면(첫 로드 시) UserDefaults에 더보기 유무 저장
    func saveSummaryExpandStatus(title: String, isExpandedSummary: Bool) // 더보기/접기 정보저장 (일부만 저장)
}
