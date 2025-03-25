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
        
        loadBook(index: 1)
        
        guard let book = self.myBook else { print("[MainVC] book is nil"); return }
        mainView.configureBook(book: book, index: 1)
    }

    override func loadView() {
        view = mainView
    }
 
    private func loadBook(index: Int) {
        mainViewModel.loadBooks()
        guard let book = mainViewModel.getBook(index: index) else { print("getBook returned nil"); return }
        print(book)
        self.myBook = book
        print(myBook)
    }
    
}

