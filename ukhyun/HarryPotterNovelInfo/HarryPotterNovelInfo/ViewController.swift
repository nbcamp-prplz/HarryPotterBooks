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
        title.text = "Harry Potter and the Philosopher's Stone"
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
    
    private let bookImageView = {
        let img = UIImageView()
        img.image = UIImage(named: "harrypotter1")
        img.contentMode = .scaleAspectFill
        img.backgroundColor = .cyan
        return img
    }()
    
    private let bookTitle = {
        let title = UILabel()
        title.text = "Harry Potter and the Philosopher's Stone"
        title.font = .boldSystemFont(ofSize: 20)
        title.numberOfLines = 0
        return title
    }()
    
    private let author = {
        let author = UILabel()
        
        let titleAttribute: [NSAttributedString.Key: Any] = [.font: UIFont.boldSystemFont(ofSize: 16), .foregroundColor: UIColor.black]
        let titleAttributeString = NSAttributedString(string: "Author : ", attributes: titleAttribute)
        
        let authorAttribute: [NSAttributedString.Key: Any] = [.font: UIFont.systemFont(ofSize: 18), .foregroundColor: UIColor.darkGray]
        let authorAttributeString = NSAttributedString(string: "J. K. Rowling", attributes: authorAttribute)
        
        let combineAttribute = NSMutableAttributedString()
        combineAttribute.append(titleAttributeString)
        combineAttribute.append(authorAttributeString)
        
        author.attributedText = combineAttribute
        
        return author
    }()
    
    private let releaseDate = {
        let date = UILabel()
        date.text = "Released Date"
        date.font = .boldSystemFont(ofSize: 14)
        return date
    }()
    
    private let bookPage = {
        let pg = UILabel()
        pg.text = "Page : Test"
        pg.font = .boldSystemFont(ofSize: 14)
        return pg
    }()
    
    private let dedicationTitle = {
        let dd = UILabel()
        dd.text = "Dedication"
        dd.font = .boldSystemFont(ofSize: 18)
        return dd
    }()
    
    private let dedicationDetail = {
        let detail = UILabel()
        detail.text = "Test Text"
        detail.font = .systemFont(ofSize: 14)
        detail.textColor = .darkGray
        detail.numberOfLines = 0
        return detail
    }()
    
    private let summaryTitle = {
        let title = UILabel()
        title.text = "Summary"
        title.font = .boldSystemFont(ofSize: 18)
        return title
    }()
    
    private let summaryDetail = {
        let detail = UILabel()
        detail.text = "Test Text"
        detail.font = .systemFont(ofSize: 14)
        detail.textColor = .darkGray
        detail.numberOfLines = 0
        return detail
    }()
    
    private let scrollView = {
        let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = true
        scroll.showsHorizontalScrollIndicator = false
        scroll.backgroundColor = .cyan
        return scroll
    }()
    
    private let containerView = UIView()
    
    private let dataService = DataService()
    private var books = [BookAttributes]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadBooks()
        configureHierarchy()
        configureLayout()
        configureView()
    }
}

extension ViewController {
    func configureHierarchy() {
        view.backgroundColor = .white
        
        [titleLabel, buttonStackView, scrollView].forEach { view.addSubview($0)}
        
        scrollView.addSubview(containerView)
        
        [bookImageView, bookTitle, author, releaseDate, bookPage,
         dedicationTitle, dedicationDetail, summaryTitle, summaryDetail]
            .forEach { containerView.addSubview($0) }
        
    }
    
    func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.directionalHorizontalEdges.equalToSuperview().inset(20)
        }
        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.directionalHorizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(40)
        }
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(buttonStackView.snp.bottom).offset(10)
            make.directionalHorizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        containerView.snp.makeConstraints { make in
            make.top.leading.trailing.bottom.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        bookImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(100)
            make.height.equalTo(bookImageView.snp.width).multipliedBy(1.5)
        }
        bookTitle.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(28)
            make.leading.equalTo(bookImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().inset(20)
        }
        author.snp.makeConstraints { make in
            make.top.equalTo(bookTitle.snp.bottom).offset(12)
            make.leading.equalTo(bookImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().inset(20)
        }
        releaseDate.snp.makeConstraints { make in
            make.top.equalTo(author.snp.bottom).offset(12)
            make.leading.equalTo(bookImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().inset(20)
        }
        bookPage.snp.makeConstraints { make in
            make.top.equalTo(releaseDate.snp.bottom).offset(12)
            make.leading.equalTo(bookImageView.snp.trailing).offset(16)
            make.trailing.equalToSuperview().inset(20)
        }
        dedicationTitle.snp.makeConstraints { make in
            make.top.equalTo(bookImageView.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(20)
        }
        dedicationDetail.snp.makeConstraints { make in
            make.top.equalTo(dedicationTitle.snp.bottom).offset(8)
            make.directionalHorizontalEdges.equalToSuperview().inset(20)
        }
        summaryTitle.snp.makeConstraints { make in
            make.top.equalTo(dedicationDetail.snp.bottom).offset(24)
            make.leading.equalToSuperview().offset(20)
        }
        summaryDetail.snp.makeConstraints { make in
            make.top.equalTo(summaryTitle.snp.bottom).offset(8)
            make.directionalHorizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(20)
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
            
            btn.layer.cornerRadius = 20
            btn.clipsToBounds = true
            
            buttonStackView.addArrangedSubview(btn)
        }
    }
    
    @objc func seriesButtonClicked(_ sender: UIButton) {
        if sender.tag <= books.count {
            let tag = books[sender.tag - 1]
            bookImageView.image = UIImage(named: "harrypotter\(sender.tag)")
            titleLabel.text = tag.title
            bookTitle.text = tag.title
            bookPage.text = "Pages : \(tag.pages)"
            
            let releaseDateFormatter = DateFormatter()
            releaseDateFormatter.dateFormat = "yyyy-MM-dd"
            guard let date = releaseDateFormatter.date(from: tag.releaseDate) else { return print("Release Date Error")}
            releaseDate.text = date.dateFormatter()
            dedicationDetail.text = tag.dedication
            summaryDetail.text = tag.summary
            
        }
    }

    func loadBooks() {
        dataService.loadBooks { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let books):
                self.books = books
            case .failure(_):
                showAlert(text: "오류", message: "확인")
            }
        }
    }
}
