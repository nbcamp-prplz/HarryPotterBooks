//
//  ViewController.swift
//  HarryPotterNovelInfo
//
//  Created by GO on 3/24/25.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
    
    private let titleLabel = {
        let title = UILabel()
        title.textAlignment = .center
        title.font = .boldSystemFont(ofSize: 24)
        title.numberOfLines = 0
        return title
    }()
    
    private lazy var buttonStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.spacing = 16
        stack.distribution = .fillEqually
        return stack
    }()
    
    private let dataService = DataService()
    private var books = [BookAttributes]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadBooks()
        configureHierarchy()
        configureLayout()
        configureView()
    }
    
    func configureHierarchy() {
        view.backgroundColor = .white
        [titleLabel, buttonStackView].forEach { view.addSubview($0) }
    }
    
    func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.horizontalEdges.equalToSuperview().inset(20)
        }
        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.horizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
    }
    
    func configureView() {
        for i in 1...7 {
            let btn = UIButton()
            btn.setTitle("\(i)", for: .normal)
            btn.titleLabel?.font = .systemFont(ofSize: 16)
            btn.backgroundColor = .systemBlue
            btn.tag = i
            btn.addTarget(self, action: #selector(seriesButtonClicked), for: .touchUpInside)
            buttonStackView.addArrangedSubview(btn)
            
            DispatchQueue.main.async {
                btn.layer.cornerRadius = btn.bounds.width / 2
                btn.clipsToBounds = true
            }
        }
    }
    
    @objc func seriesButtonClicked(_ sender: UIButton) {
        if sender.tag <= books.count {
            let bookTitle = books[sender.tag - 1].title
            titleLabel.text = bookTitle
        }
    }
    
    func loadBooks() {
        dataService.loadBooks { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let books): self.books = books
            case .failure(let error): print("Error: \(error.localizedDescription)")
            }
        }
    }
}

