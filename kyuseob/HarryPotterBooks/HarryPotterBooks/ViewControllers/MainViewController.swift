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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadBooks()
        mainViewModel.loadReadMoreStates()
        
        mainView.delegate = self
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        mainView.configure(books: mainViewModel.books, index: 0, readMoreState: mainViewModel.isReadMore(index: 0))
    }

    override func loadView() {
        view = mainView
    }
 
    private func loadBooks() {
        do {
            try mainViewModel.loadBooks()
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
    func didChangeSelectedIndex(to index: Int) {
        mainView.configure(books: mainViewModel.books, index: index, readMoreState: mainViewModel.isReadMore(index: index))
    }
    
    func mainViewDidTapReadMore(index: Int) {
        mainViewModel.toggleReadMore(index: index)
    }
}
