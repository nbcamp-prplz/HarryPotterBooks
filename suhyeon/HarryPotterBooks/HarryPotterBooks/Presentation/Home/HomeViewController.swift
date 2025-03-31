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
        bindCollectionViewInsets()
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
        
        homeView.topView.seriesNumberCollectionView.rx.itemSelected.bind {[weak self] indexPath in
            self?.selectedIndex.accept(indexPath.row)
            self?.homeView.topView.seriesNumberCollectionView.reloadData()
        }.disposed(by: disposeBag)
    }
    
    private func bindViewModel() {
        let input = HomeViewModel.Input(viewDidLoad: .just(()), isExpandedSummary: isExpandedSummary.asObservable())
        
        let output = viewModel.transform(input: input)
        
        output.books
            .do(onNext: {[weak self] books in
                self?.books.accept(books)
            })
            .bind(to: homeView.topView.seriesNumberCollectionView.rx.items(
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
    
    private func bindCollectionViewInsets() {
        Observable.combineLatest(
            books.map { $0.count }, // 현재 책 개수
            homeView.topView.seriesNumberCollectionView.rx.observe(CGRect.self, "bounds") // 뷰 크기 변화 감지 (옵셔널 타입)
        )
        .compactMap { itemCount, bounds -> UIEdgeInsets? in // bounds가 옵셔널 타입이므로 compactMap 사용
            guard let bounds = bounds else { return nil }
            
            let flowLayout = self.homeView.topView.seriesNumberCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
            let itemSize = flowLayout?.itemSize.width ?? 0
            let spacing = flowLayout?.minimumInteritemSpacing ?? 0

            let totalItemWidth = CGFloat(itemCount) * itemSize + CGFloat(itemCount - 1) * spacing
            let horizontalInset = max((bounds.width - totalItemWidth) / 2, 0) // 음수 방지
            return UIEdgeInsets(top: 0, left: horizontalInset, bottom: 0, right: horizontalInset)
        }
        .bind { [weak self] insets in
            guard let self = self else { return }
            if let flowLayout = self.homeView.topView.seriesNumberCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
                flowLayout.sectionInset = insets
                
                DispatchQueue.main.async {
                    self.homeView.topView.seriesNumberCollectionView.collectionViewLayout.invalidateLayout() // 레이아웃 갱신
                }
            }
        }
        .disposed(by: disposeBag)
    }

}
