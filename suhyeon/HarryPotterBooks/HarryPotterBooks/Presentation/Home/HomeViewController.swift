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
    
    private let books = BehaviorRelay<[(Book, Bool)]>(value: [])
    private let selectedIndex = BehaviorRelay<Int>(value: 0)
    private let isExpandedSummary = PublishRelay<(String, Bool)>() // (책 제목, 확정 여부)
    
    
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
        setDataSource()
    }
    
    private func bindView() {
        homeView.summaryStackView.contentView.expandFoldButton.rx.tap
            .bind { [weak self] in
                guard let self else { return }
                let expandFoldButton = self.homeView.summaryStackView.contentView.expandFoldButton
                let title = self.books.value[selectedIndex.value].0.title
                expandFoldButton.isSelected = !expandFoldButton.isSelected
                self.isExpandedSummary.accept((title, expandFoldButton.isSelected))
            }.disposed(by: disposeBag)
        
        homeView.topView.seriesButtonCollectionView.rx.itemSelected.bind {[weak self] indexPath in
            self?.selectedIndex.accept(indexPath.row)
            self?.homeView.topView.seriesButtonCollectionView.reloadData()
        }.disposed(by: disposeBag)
    }
    
    private func bindViewModel() {
        let input = HomeViewModel.Input(viewDidLoad: .just(()), isExpandedSummary: isExpandedSummary.asObservable())
        
        let output = viewModel.transform(input: input)
        
        output.books
            .do(onNext: {[weak self] books in
                self?.books.accept(books)
            })
            .bind(to: homeView.topView.seriesButtonCollectionView.rx.items(
                cellIdentifier: SeriesNumberCell.id, cellType: SeriesNumberCell.self)) { index, book, cell in
                    cell.configure(title: "\(index + 1)", isSelected: index == self.selectedIndex.value)
                }
                .disposed(by: disposeBag)
        
        output.error.bind {[weak self] error in
            guard let self else { return }
            let alert = self.alertService.createErrorAlert(title: "데이터 불러오기 실패", message: error.description)
            self.present(alert, animated: true)
        }.disposed(by: disposeBag)
    }
    
    private func setDataSource() {
        Observable.combineLatest(books, selectedIndex)
            .filter {books, _ in books.count > 0 } // 비어있을 때는 제외
            .bind {[weak self] books, selectedIndex in
                self?.homeView.configure(books: books, index: selectedIndex)
            }
            .disposed(by: disposeBag)
    }
}
