//
//  HomeViewModel.swift
//  HarryPotterBooks
//
//  Created by 이수현 on 3/25/25.
//

import Foundation
import RxSwift
import RxCocoa

protocol HomeViewModelProtocol {
    func transform(input: HomeViewModel.Input) -> HomeViewModel.Output
}

class HomeViewModel: HomeViewModelProtocol {
    private let disposeBag = DisposeBag()
    private let useCase: BookUseCaseProtocol
    
    private let books = BehaviorRelay<[(Book, Bool)]>(value: [])
    private let error = PublishRelay<String>()
    
    init(useCase: BookUseCaseProtocol) {
        self.useCase = useCase
    }
    
    struct Input {
        let viewDidLoad: Observable<Void>
        let isExpandedSummary: Observable<(String, Bool)> // (책 제목, 확정 여부)
    }
    
    struct Output {
        let books: Observable<[(Book, Bool)]>
        let error: Observable<String>
    }
    
    func transform(input: Input) -> Output {
        input.viewDidLoad.bind { [weak self] in
            self?.fetchBooks()
        }.disposed(by: disposeBag)
        
        input.isExpandedSummary.bind { [weak self] (title, isExpandedSummary) in
            self?.saveSummaryExpandStatus(title: title, isExpandedSummary: isExpandedSummary)
        }.disposed(by: disposeBag)
        
        
        return Output(books: books.asObservable(), error: error.asObservable())
    }
    
    // 책 정보 불러오기
    private func fetchBooks() {
        Task {
            let books = await useCase.fetchBooks()
            switch books {
            case .success(let books):
                let isSavedBooks = useCase.isSavedBooks(books: books)
                if !isSavedBooks { useCase.saveSummaryExpandStatus(books: books) }
                self.setBooksStatus(books: books)
            case .failure(let error):
                await MainActor.run { // error를 바인딩한 ViewController에서 Alert으로 UI를 변경하므로 메인 스레드에서 진행
                    self.error.accept(error.description)
                }
            }
        }
    }
    
    // UserDefaults에 저장된 [(Book, Bool)] 반환
    private func setBooksStatus(books: [Book]) {
        guard let booksStatus = useCase.loadSummaryExpandStatus(books: books) else { return }
        
        DispatchQueue.main.async {
            self.books.accept(booksStatus)
        }
    }
    
    // 더보기/접기 정보저장 (일부만 저장)
    private func saveSummaryExpandStatus(title: String, isExpandedSummary: Bool) {
        useCase.saveSummaryExpandStatus(title: title, isExpandedSummary: isExpandedSummary)
        self.setBooksStatus(books: books.value.map{$0.0})
    }
}
