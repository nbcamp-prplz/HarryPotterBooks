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
    
    // 사용자의 이벤트
    struct Input {
        let viewDidLoad: Observable<Void>
        let isExpandedSummary: Observable<(String, Bool)> // (책 제목, 확정 여부)
    }
    
    // 뷰에 필요한 데이터
    struct Output {
        let books: Observable<[(Book, Bool)]>
        let error: Observable<String>
    }
    
    // 단방향 데이터 흐름을 위한 메서드
    func transform(input: Input) -> Output {
        // viewDidLoad가 되면 fetchBooks() 호출
        input.viewDidLoad.bind { [weak self] in
            self?.fetchBooks()
        }.disposed(by: disposeBag)
        
        // 더보기/접기 여부가 바뀌면 갱신
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
                let isSavedBooks = useCase.isSavedBooks() // UserDefaults에 값이 저장되어 있는지 확인
                if !isSavedBooks { useCase.saveSummaryExpandStatus(books: books) } // 저장되어 있지 않다면, 저장
                self.setBooksStatus(books: books) // 저장된 books를 불러옴
            case .failure(let error):
                self.error.accept(error.description)
            }
        }
    }
    
    // UserDefaults에 저장된 [(Book, Bool)] 반환
    private func setBooksStatus(books: [Book]) {
        guard let booksStatus = useCase.loadSummaryExpandStatus(books: books) else { return }
        self.books.accept(booksStatus)
    }
    
    // 더보기/접기 정보저장 (일부만 저장)
    private func saveSummaryExpandStatus(title: String, isExpandedSummary: Bool) {
        useCase.saveSummaryExpandStatus(title: title, isExpandedSummary: isExpandedSummary)
        self.setBooksStatus(books: books.value.map{$0.0})
    }
}
