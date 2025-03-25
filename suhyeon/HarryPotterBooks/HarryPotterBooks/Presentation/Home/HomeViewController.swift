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
    
    init() {
        let bookNetwork = BookNetwork()
        let bookRepository = BookRepository(network: bookNetwork)
        let usecase = BookUsecase(bookRepository: bookRepository)
        viewModel = HomeViewModel(usecase: usecase)
        super.init(nibName: nil, bundle: nil)
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = homeView
        bindViewModel()
    }
    
    private func bindViewModel() {
        let input = HomeViewModel.Input(viewDidLoad: .just(()))
        let output = viewModel.transform(input: input)
        
        output.bookList.bind { [weak self] bookList in
            self?.homeView.config(title: bookList.first?.title)
        }.disposed(by: disposeBag)
        
        output.error.bind { error in
            print(error)
        }.disposed(by: disposeBag)
    }
}
