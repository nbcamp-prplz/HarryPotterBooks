//
//  ViewController.swift
//  HarryPotterBooks
//
//  Created by 송규섭 on 3/24/25.
//

import UIKit

class MainViewController: UIViewController {

    private let mainView = MainView()
    private let mainViewModel = MainViewModel()
    
    private var myBook: Book? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mainView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        loadBook(index: 1)
        
        guard let book = self.myBook else { return }
        
        mainViewModel.loadReadMoreStates()
        
        mainView.configure(book: book, index: 1, readMoreState: mainViewModel.isReadMore(index: 1))
    }

    override func loadView() {
        view = mainView
    }
 
    private func loadBook(index: Int) {
        do {
            try mainViewModel.loadBooks()
            guard let book = mainViewModel.book(index: index) else { return }
            self.myBook = book
        } catch let error as DataError {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { // ViewController가 display 준비되기 전 메시지를 띄우지 않도록
                self.showMessage(title: nil, message: error.errorMessage)
            }
        } catch {
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.showMessage(title: nil, message: "예기치 못한 오류가 발생했습니다.")
            }
        }
    }
    
}

extension MainViewController: MainViewDelegate {
    func mainViewDidTapReadMore() {
        mainViewModel.toggleReadMore(index: 1)
    }
}
