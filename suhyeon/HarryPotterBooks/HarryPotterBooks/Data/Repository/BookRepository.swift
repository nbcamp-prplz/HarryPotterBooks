//
//  BookRepository.swift
//  HarryPotterBooks
//
//  Created by 이수현 on 3/25/25.
//

import Foundation

class BookRepository: BookRepositoryProtocol {
    private let network: BookNetworkProtocol
    private let userDefaults = UserDefaults.standard
    
    init(network: BookNetworkProtocol) {
        self.network = network
    }
    
    func fetchBooks() async -> Result<[Book], DataError> {
        await network.fetchBooks()
    }
    
    // UserDefaults에 저장되어 있는지 확인
    func isSavedBooks(books: [Book]) -> Bool {
        let key = UserDefaultsKey.summaryExpandStatus.rawValue
        let summaryExpandStatus = userDefaults.dictionary(forKey: key) as? [String: Bool]
        return summaryExpandStatus != nil
    }
    
    // UserDefaults에 저장되어 있는 값 세팅
    func loadSummaryExpandStatus(books: [Book]) -> [(Book, Bool)]? {
        let key = UserDefaultsKey.summaryExpandStatus.rawValue
        guard let summaryExpandStatusDictionary = userDefaults.dictionary(forKey: key) as? [String: Bool] else {
            return nil
        }

        let bookStatus = books.map{ book in
            let isSummaryExpandStatus = summaryExpandStatusDictionary.filter{$0.key == book.title}
                .first?.value
            return (book, isSummaryExpandStatus ?? false)
        }
        return bookStatus
    }
    
    // UserDefaults에 저장되어 있지 않다면(첫 로드 시) UserDefaults에 더보기 유무 저장
    func saveSummaryExpandStatus(books: [Book]) {
        let key = UserDefaultsKey.summaryExpandStatus.rawValue
        let summaryExpandStatusDictionary = Dictionary(uniqueKeysWithValues: books.map { ($0.title, false) })
        userDefaults.set(summaryExpandStatusDictionary, forKey: key)
    }
    
    // 더보기/접기 정보저장 (일부만 저장)
    func saveSummaryExpandStatus(title: String, isExpandedSummary: Bool) {
        let key = UserDefaultsKey.summaryExpandStatus.rawValue
        
        // 딕셔너리 형태 [String: Bool] = [BookTitle: isExpandContent]
        var summaryExpandStatusDictionary = userDefaults.dictionary(forKey: key) as? [String: Bool]
        summaryExpandStatusDictionary?[title] = isExpandedSummary
        userDefaults.set(summaryExpandStatusDictionary, forKey: key) // UserDefaults에 저장
    }
}
