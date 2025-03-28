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
    
    private let books = BehaviorRelay<[Book]>(value: [])
    private let error = PublishRelay<String>()
    
    init(useCase: BookUseCaseProtocol) {
        self.useCase = useCase
    }
    
    struct Input {
        let viewDidLoad: Observable<Void>
        let isExpandContent: Observable<Bool>
    }
    
    struct Output {
        let books: Observable<[Book]>
        let error: Observable<String>
        let isExpandContent: Observable<Bool>
    }
    
    func transform(input: Input) -> Output {
        input.viewDidLoad.bind { [weak self] in
            self?.fetchBooks()
        }.disposed(by: disposeBag)
        
        return Output(books: books.asObservable(), error: error.asObservable(), isExpandContent: input.isExpandContent)
    }
    
    // 책 정보 불러오기
    private func fetchBooks() {
        Task {
            let books = await useCase.fetchBooks()
            switch books {
            case .success(let books):
                await MainActor.run { // books를 바인딩한 ViewController에서 UI를 변경하므로 메인 스레드에서 진행
                    self.books.accept(books)
                }
                
            case .failure(let error):
                await MainActor.run { // error를 바인딩한 ViewController에서 Alert으로 UI를 변경하므로 메인 스레드에서 진행
                    self.error.accept(error.description)
                }
            }
        }
    }
}
