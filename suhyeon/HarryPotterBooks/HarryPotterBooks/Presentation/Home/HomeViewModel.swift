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
    }
    
    struct Output {
        let books: Observable<[Book]>
        let error: Observable<String>
    }
    
    func transform(input: Input) -> Output {
        input.viewDidLoad.bind { [weak self] in
            self?.fetchBooks()
        }.disposed(by: disposeBag)
        
        return Output(books: books.asObservable(), error: error.asObservable())
    }
    
    private func fetchBooks() {
        Task {
            let books = await useCase.fetchBooks()
            switch books {
            case .success(let books):
                await MainActor.run {
                    self.books.accept(books)
                }
                
            case .failure(let error):
                self.error.accept(error.description)
            }
        }
    }
}
