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
    private let viewModel: HomeViewModel
    private let disposeBag = DisposeBag()
    
    private let books = BehaviorRelay<[(Book, Bool)]>(value: []) // (책, summary 확장 여부) 튜플 형태 배열
    private let selectedIndex = BehaviorRelay<Int>(value: 0)    // 선택한 시리즈의 인덱스
    private let isExpandedSummary = PublishRelay<(String, Bool)>() // (책 제목, 확정 여부)
    
    init() {
        // 의존성 주입
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
    
    // 뷰 바인딩
    private func bindView() {
        // 더보기/접기 버튼 바인딩
        homeView.summaryStackView.contentView.expandFoldButton.rx.tap
            .observe(on: MainScheduler.instance) // UI를 변경하므로 메인 큐 사용
            .bind { [weak self] in
                guard let self else { return }
                let expandFoldButton = self.homeView.summaryStackView.contentView.expandFoldButton
                let title = self.books.value[selectedIndex.value].0.title // 기존 타이틀
                expandFoldButton.isSelected = !expandFoldButton.isSelected // 버튼 selected 설정
                self.isExpandedSummary.accept((title, expandFoldButton.isSelected)) // 기존 타이틀의 확장 여부 반영
            }.disposed(by: disposeBag)
        
        // 시리즈 버튼 바인딩
        homeView.topView.seriesNumberCollectionView.rx.itemSelected
            .bind {[weak self] indexPath in
                self?.selectedIndex.accept(indexPath.row) // 선택한 시리즈 인덱스 반영
                self?.homeView.topView.seriesNumberCollectionView.reloadData() // 컬렉션뷰 리로드 -> 시리즈 넘버의 배경색, textColor 반영
        }.disposed(by: disposeBag)
    }
    
    // 뷰모델 바인딩
    private func bindViewModel() {
        let input = HomeViewModel.Input(viewDidLoad: .just(()), isExpandedSummary: isExpandedSummary.asObservable())
        viewModel.transform(input: input)
        
        // books 바인딩
        viewModel.output.books
            .observe(on: MainScheduler.instance) // 시리즈 컬렉션뷰의 UI를 변경하므로 Main 큐 사용
            .do(onNext: {[weak self] books in
                self?.books.accept(books) // 변경된 books 반영
            })
            .bind(to: homeView.topView.seriesNumberCollectionView.rx.items( // 컬렉션뷰의 아이템으로 바인딩
                cellIdentifier: SeriesNumberCell.id, cellType: SeriesNumberCell.self)) {[weak self] index, book, cell in
                    cell.configure(title: "\(index + 1)", isSelected: index == self?.selectedIndex.value)
                }
                .disposed(by: disposeBag)
        
        // 에러 바인딩
        viewModel.output.error
            .filter { $0 != "" }
            .observe(on: MainScheduler.instance) // 얼럿을 띄우므로 메인 큐 사용
            .bind {[weak self] error in
                guard let self else { return }
                let alert = AlertService.createErrorAlert(title: "데이터 불러오기 실패", message: error.description)
                self.present(alert, animated: true)
        }.disposed(by: disposeBag)
    }
    
    // homeView에 데이터 바인딩
    private func setDataSource() {
        Observable.combineLatest(books, selectedIndex) // books 데이터나 선택한 인덱스가 바뀔 때마다 호출
            .filter {books, _ in books.count > 0 } // 비어있을 때는 제외
            .observe(on: MainScheduler.instance) // UI를 바꾸므로 main 큐
            .bind {[weak self] books, selectedIndex in
                self?.homeView.configure(books: books, index: selectedIndex)
            }
            .disposed(by: disposeBag)
    }
    
    // 컬렉션뷰의 bounds와 책 개수에 따라 컬렉션뷰의 셀 인셋 설정
    private func bindCollectionViewInsets() {
        Observable.combineLatest( // 책 개수나, 뷰 크기가 바뀔 때 호출
            books.map { $0.count }, // 현재 책 개수
            homeView.topView.seriesNumberCollectionView.rx.observe(CGRect.self, "bounds") // 뷰 크기 변화 감지 (옵셔널 타입)
        )
        .compactMap {[weak self] itemCount, bounds -> UIEdgeInsets? in // bounds가 옵셔널 타입이므로 compactMap 사용
            guard let bounds, let self else { return nil }
            
            let flowLayout = self.homeView.topView.seriesNumberCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
            let itemSize = flowLayout?.itemSize.width ?? 0
            let spacing = flowLayout?.minimumInteritemSpacing ?? 0
            let totalItemWidth = CGFloat(itemCount) * itemSize + CGFloat(itemCount - 1) * spacing // spacing을 포함한 전체 셀의 너비
            let horizontalInset = max((bounds.width - totalItemWidth) / 2, 0) // left, right 양쪽이므로 / 2, 음수 값 방지를 위해 Max 사용
            return UIEdgeInsets(top: 0, left: horizontalInset, bottom: 0, right: horizontalInset)
        }
        .observe(on: MainScheduler.instance) // UIEdgeInsets을 변경하므로 메인 큐
        .bind { [weak self] insets in
            guard let self,
                  let flowLayout = self.homeView.topView.seriesNumberCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }
            // 뷰의 레이아웃 시스템은 필요할 때만 갱신하므로 자동으로 갱신되지 않는다
            // DispatchQueue.main.async를 사용하면 다음 RunLoop에서 실행을 예약할
            DispatchQueue.main.async {
                flowLayout.sectionInset = insets
                self.homeView.topView.seriesNumberCollectionView.collectionViewLayout.invalidateLayout() // 현재의 레이아웃을 ‘무효화’하고 이후의 레이아웃을 재계산을 요청
            }
        }
        .disposed(by: disposeBag)
    }
}
