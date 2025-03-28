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
    private let selectedBook = PublishRelay<(Book, Bool)>()
    private let error = PublishRelay<String>()
    
    init(useCase: BookUseCaseProtocol) {
        self.useCase = useCase
    }
    
    struct Input {
        let viewDidLoad: Observable<Void>
        let selectedIndex: Observable<Int>
        let isExpandedSummary: Observable<Bool>
    }
    
    struct Output {
        let selectedBook: Observable<(Book, Bool)>
        let error: Observable<String>
    }
    
    func transform(input: Input) -> Output {
        // viewDidLoad하면 책 정보 불러오기
        input.viewDidLoad
            .withLatestFrom(input.selectedIndex) // 값만 사용
            .bind { [weak self] selectedIndex in
            self?.fetchBooks(index: selectedIndex)
        }.disposed(by: disposeBag)
        
//         선택한 인덱스, 요약 버튼 상태에 따라 책 정보 반환
        Observable.combineLatest(input.selectedIndex, input.isExpandedSummary)
            .bind { [weak self] index, isExpandedSummary in
                guard let self  else { return }
                let books = self.books.value
                
                DispatchQueue.main.async {
                    self.saveSummaryExpandStatus(book: books[index].0, isExpandedSummary: isExpandedSummary)
                    self.selectedBook.accept(self.books.value[index])
                }
                
            }.disposed(by: disposeBag)

        return Output(selectedBook: selectedBook.asObservable(),
                      error: error.asObservable())
    }
    
    // 책 정보 불러오기
    private func fetchBooks(index: Int) {
        Task {
            let books = await useCase.fetchBooks()
            switch books {
            case .success(let books):
                let isSavedBooks = isSavedBooks(books: books)
                if !isSavedBooks { saveSummaryExpandStatus(books: books) }
                else { loadSummaryExpandStatus(books: books) }
                
                await MainActor.run {
                    self.selectedBook.accept(self.books.value[index])
                }
                
            case .failure(let error):
                await MainActor.run { // error를 바인딩한 ViewController에서 Alert으로 UI를 변경하므로 메인 스레드에서 진행
                    self.error.accept(error.description)
                }
            }
        }
    }
    
    // UserDefaults에 저장되어 있는지 확인
    private func isSavedBooks(books: [Book]) -> Bool {
        let key = UserDefaultsKey.summaryExpandStatus.rawValue
        let userDefaults = UserDefaults.standard
        let summaryExpandStatus = userDefaults.dictionary(forKey: key) as? [String: Bool]
        return summaryExpandStatus != nil
    }
    
    // UserDefaults에 저장되어 있는 값 세팅
    private func loadSummaryExpandStatus(books: [Book]) {
        let key = UserDefaultsKey.summaryExpandStatus.rawValue
        let userDefaults = UserDefaults.standard
        guard let summaryExpandStatusDictionary = userDefaults.dictionary(forKey: key) as? [String: Bool] else { return }

        let bookStaus = books.map{ book in
            let isSummaryExpandStatus = summaryExpandStatusDictionary.filter{$0.key == book.title}
                .first?.value
            return (book, isSummaryExpandStatus ?? false)
        }
    
        self.books.accept(bookStaus)
    }
    
    // UserDefaults에 저장되어 있지 않다면(첫 로드 시) UserDefaults에 더보기 유무 저장
    private func saveSummaryExpandStatus(books: [Book]) {
        let key = UserDefaultsKey.summaryExpandStatus.rawValue
        let userDefaults = UserDefaults.standard
        let summaryExpandStatusDictionary = Dictionary(uniqueKeysWithValues: books.map { ($0.title, false) })
        userDefaults.set(summaryExpandStatusDictionary, forKey: key)
        loadSummaryExpandStatus(books: books)
        
    }
    
    // 더보기/접기 정보저장 (일부만 저장)
    private func saveSummaryExpandStatus(book: Book, isExpandedSummary: Bool) {
        let key = UserDefaultsKey.summaryExpandStatus.rawValue
        let userDefaults = UserDefaults.standard
        
        // 딕셔너리 형태 [String: Bool] = [BookTitle: isExpandContent]
        var summaryExpandStatusDictionary = userDefaults.dictionary(forKey: key) as? [String: Bool]
        summaryExpandStatusDictionary?[book.title] = isExpandedSummary
        userDefaults.set(summaryExpandStatusDictionary, forKey: key)
        
        guard let summaryExpandStatusDictionary = userDefaults.dictionary(forKey: key) as? [String: Bool] else { return }
        
        let newBooks = self.books.value.map{$0.0.title == book.title ? ($0.0, isExpandedSummary) : $0}
        self.books.accept(newBooks)
    }
}
