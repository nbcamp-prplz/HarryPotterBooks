//
//  MainViewModel.swift
//  HarryPotterBooks
//
//  Created by 송규섭 on 3/25/25.
//

import Foundation

class MainViewModel {
    private let dataService = DataService()
    private var books: [Book] = []
    
    func loadBooks() {
        dataService.loadBooks { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let books):
                self.books = books
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func getBook(index: Int) -> Book? {
        guard 0 ..< books.count ~= index else { print("getBook range is unvalid."); return nil } // 로드된 책 개수 안에서 하나를 반환하도록 예외 처리
        
        return books[index]
    }
}
