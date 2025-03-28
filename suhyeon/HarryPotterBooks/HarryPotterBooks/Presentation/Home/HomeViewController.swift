//
//  HomeViewController.swift
//  HarryPotterBooks
//
//  Created by 이수현 on 3/25/25.
//

import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    private let homeView = HomeView()
    private let viewModel: HomeViewModelProtocol
    private let disposeBag = DisposeBag()
    private let alertService = AlertService()
    private let isExpandContent = BehaviorRelay<Bool>(value: true)
    
    init() {
        let bookNetwork = BookNetwork()
        let bookRepository = BookRepository(network: bookNetwork)
        let useCase = BookUseCase(bookRepository: bookRepository)
        viewModel = HomeViewModel(useCase: useCase)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = homeView
        bindView()
        bindViewModel()
    }
    
    private func bindView() {
        homeView.summaryStackView.contentView.expandFoldButton.rx.tap
            .bind { [weak self] in
                guard let currentState = self?.isExpandContent.value else { return }
                self?.isExpandContent.accept(!currentState)
            }.disposed(by: disposeBag)
    }
    
    private func bindViewModel() {
        let input = HomeViewModel.Input(viewDidLoad: .just(()), isExpandContent: self.isExpandContent.asObservable())
        let output = viewModel.transform(input: input)
        
        Observable.combineLatest(output.books, output.isExpandContent)
            .bind {[weak self] books, expandContent in
                guard let self, let book = books.first else { return }
                self.homeView.configure(book: book, index: 1, isExpandContent: expandContent)
            }.disposed(by: disposeBag)
        
        output.error.bind {[weak self] error in
            guard let self else { return }
            let alert = self.alertService.createErrorAlert(title: "데이터 불러오기 실패", message: error.description)
            self.present(alert, animated: true)
        }.disposed(by: disposeBag)
    }
}
