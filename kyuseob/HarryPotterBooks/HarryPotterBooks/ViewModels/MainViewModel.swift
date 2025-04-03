//
//  MainViewModel.swift
//  HarryPotterBooks
//
//  Created by 송규섭 on 3/25/25.
//

import Foundation

class MainViewModel {
    private let dataService = DataService()
    
    private(set) var books: [Book] = []
    private var readMoreStates: [Bool] = []
    
    func loadBooks() throws {
        let books = try dataService.loadBooks()
        self.books = books
    }
    
    func book(index: Int) -> Book? {
        guard 0 ..< books.count ~= index else { return nil } // 로드된 책 개수 안에서 하나를 반환하도록 예외 처리
        
        return books[index]
    }
    
    func isReadMore(index: Int) -> Bool? {
        guard 0 ..< books.count ~= index else { return nil }
        
        return readMoreStates[index]
    }
    
    func toggleReadMore(index: Int) {
        readMoreStates[index] = !(readMoreStates[index])
        UserDefaultsManager.shared.saveReadMoreStates(readMoreStates)
    }
    
    func loadReadMoreStates() {
        readMoreStates = Array(repeating: false, count: books.count)
        let states = UserDefaultsManager.shared.readMoreStates()
        if states.isEmpty {
            UserDefaultsManager.shared.saveReadMoreStates(readMoreStates)
        } else {
            self.readMoreStates = states
        }
    }
    
}
