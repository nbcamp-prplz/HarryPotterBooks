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
        
        guard let book = self.myBook else { return }
        mainView.configure(book: book, index: 1)
    }

    override func loadView() {
        view = mainView
    }
 
    private func loadBook(index: Int) {
        mainViewModel.loadBooks()
        guard let book = mainViewModel.book(index: index) else { return }
        self.myBook = book
    }
    
}

