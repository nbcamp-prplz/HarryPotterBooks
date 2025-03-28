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
    
    private let selectdIndex = BehaviorRelay<Int>(value: 0)
    private let isExpandedSummary = PublishRelay<Bool>()
    
    
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
                guard let self else { return }
                let expandFoldButton = self.homeView.summaryStackView.contentView.expandFoldButton
                expandFoldButton.isSelected = !expandFoldButton.isSelected
                self.isExpandedSummary.accept(expandFoldButton.isSelected)
            }.disposed(by: disposeBag)
    }
    
    private func bindViewModel() {
        let input = HomeViewModel.Input(viewDidLoad: .just(()), selectedIndex: .just(0), isExpandedSummary: self.isExpandedSummary.asObservable())
        let output = viewModel.transform(input: input)
        
        output.selectedBook.bind {[weak self] book in
            guard let self else { return }
            
            // 탭을 할 때는 바뀌지만, 기기에 저장된 데이터를 꺼낼 때 초기화 용도
            self.homeView.summaryStackView.contentView.expandFoldButton.isSelected = book.1
            self.homeView.configure(book: book.0, index: self.selectdIndex.value, isExpandContent: book.1)
        }.disposed(by: disposeBag)
        
        output.error.bind {[weak self] error in
            guard let self else { return }
            let alert = self.alertService.createErrorAlert(title: "데이터 불러오기 실패", message: error.description)
            self.present(alert, animated: true)
        }.disposed(by: disposeBag)
    }
}
