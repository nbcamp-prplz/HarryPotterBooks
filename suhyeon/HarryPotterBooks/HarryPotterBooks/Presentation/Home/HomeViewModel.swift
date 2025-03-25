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
    private let usecase: BookUsecaseProtocol
    
    private let bookList = BehaviorRelay<[Book]>(value: [])
    private let error = PublishRelay<String>()
    
    init(usecase: BookUsecaseProtocol) {
        self.usecase = usecase
    }
    
    struct Input {
        let viewDidLoad: Observable<Void>
    }
    
    struct Output {
        let bookList: Observable<[Book]>
        let error: Observable<String>
    }
    
    func transform(input: Input) -> Output {
        input.viewDidLoad.bind { [weak self] in
            self?.fetchBookList()
        }.disposed(by: disposeBag)
        
        return Output(bookList: bookList.asObservable(), error: error.asObservable())
    }
    
    private func fetchBookList() {
        Task {
            let bookList = await usecase.fetchBookList()
            switch bookList {
            case .success(let bookList):
                await MainActor.run {
                    self.bookList.accept(bookList)
                }
                
            case .failure(let error):
                self.error.accept(error.description)
            }
        }
    }
}
