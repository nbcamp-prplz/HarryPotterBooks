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
    
    private lazy var bookInfoStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
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
    
    private let chapterTitle = {
        let chap = UILabel()
        chap.font = .boldSystemFont(ofSize: 18)
        chap.text = "Chapters"
        return chap
    }()
    
    private let chapterDetail = {
        let detail = UILabel()
        detail.text = "Test Text"
        detail.font = .systemFont(ofSize: 14)
        detail.textColor = .darkGray
        detail.numberOfLines = 0
        return detail
    }()
    
    private lazy var bookDetailInfoStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let dataService = DataService()
    private var books = [BookAttributes]()
    
    private let scrollView = {
        let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = false
        return scroll
    }()
    
    private let contentView = UIView()
    
    private lazy var summaryToggleButton = {
        let button = UIButton(type: .system)
        button.setTitle("더보기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14)
        button.addTarget(self, action: #selector(toggleSummary), for: .touchUpInside)
        button.setTitleColor(.systemBlue, for: .normal)
        button.contentHorizontalAlignment = .trailing
        button.isHidden = true
        return button
    }()

    
    private var currentBookIndex = 0
    
    private let summaryExpandedKey = "SummaryExpanded"
    
    private var summaryExpanded = Array(repeating: false, count: 7)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadBooks()
        configureHierarchy()
        configureLayout()
        configureView()
        saveCurrentState()
    }
}

extension ViewController {
    func configureHierarchy() {
        view.backgroundColor = .white
        [titleLabel, buttonStackView, scrollView].forEach { view.addSubview($0) }
        [contentView].forEach { scrollView.addSubview($0) }
        [bookImageView, bookInfoStackView, bookDetailInfoStackView].forEach { contentView.addSubview($0) }
        [bookTitle, author, releaseDate, bookPage].forEach { bookInfoStackView.addArrangedSubview($0) }
        [dedicationTitle, dedicationDetail, summaryTitle, summaryDetail, summaryToggleButton, chapterTitle, chapterDetail].forEach { bookDetailInfoStackView.addArrangedSubview($0) }
    }
    
    func configureLayout() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(10)
            make.directionalHorizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(88)
        }
        buttonStackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(16)
            make.directionalHorizontalEdges.equalToSuperview().inset(20)
            make.height.equalTo(44)
        }
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(buttonStackView.snp.bottom).offset(10)
            make.directionalHorizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        contentView.snp.makeConstraints { make in
            make.edges.equalTo(scrollView.contentLayoutGuide)
            make.width.equalTo(scrollView.frameLayoutGuide)
        }
        bookImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.equalToSuperview().offset(20)
            make.width.equalTo(100)
            make.height.equalTo(bookImageView.snp.width).multipliedBy(1.5)
        }
        bookInfoStackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.equalTo(bookImageView.snp.trailing).offset(10)
            make.trailing.equalToSuperview().inset(20)
        }
        bookDetailInfoStackView.snp.makeConstraints { make in
            make.top.equalTo(bookImageView.snp.bottom).offset(24)
            make.directionalHorizontalEdges.equalToSuperview().inset(20)
            make.bottom.equalToSuperview().inset(5)
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
            currentBookIndex = sender.tag - 1
            let currentBook = books[currentBookIndex]

            DispatchQueue.main.async {
                self.bookImageView.image = UIImage(named: "harrypotter\(sender.tag)")
                self.titleLabel.text = currentBook.title
                self.bookTitle.text = currentBook.title
                self.bookPage.text = "Pages : \(currentBook.pages)"
                let releaseDateFormatter = DateFormatter()
                releaseDateFormatter.dateFormat = "yyyy-MM-dd"
                guard let date = releaseDateFormatter.date(from: currentBook.releaseDate) else { return print("Release Date Error")}
                self.releaseDate.text = date.dateFormatter()
                self.dedicationDetail.text = currentBook.dedication
                self.chapterDetail.text = currentBook.chapters.indices.map { index in
                    return "\(index + 1). \(currentBook.chapters[index].title)"
                }.joined(separator: "\n")

            }
            
            updateSummaryDisplay()
        }
    }
    @objc private func toggleSummary() {
        summaryExpanded[currentBookIndex] = !summaryExpanded[currentBookIndex]
        UserDefaults.standard.set(summaryExpanded, forKey: summaryExpandedKey)
        updateSummaryDisplay()
    }
    
    private func updateSummaryDisplay() {
        guard currentBookIndex < books.count else { return }
        
        let book = books[currentBookIndex]
        let fullText = book.summary
        
        if fullText.count > 450 {
            summaryToggleButton.isHidden = false
            
            if summaryExpanded[currentBookIndex] {
                summaryDetail.text = fullText
                summaryToggleButton.setTitle("접기", for: .normal)
            } else {
                let truncatedText = String(fullText.prefix(450)) + "..."
                summaryDetail.text = truncatedText
                summaryToggleButton.setTitle("더보기", for: .normal)
            }
        } else {
            summaryDetail.text = fullText
            summaryToggleButton.isHidden = true
        }
    }

    
    func saveCurrentState() {
        if let savedExpanded = UserDefaults.standard.array(forKey: summaryExpandedKey) as? [Bool] {
            summaryExpanded = savedExpanded
        }
        // naming으로 파악하기 힘듦
        if !books.isEmpty {
            let button = UIButton(type: .system)
            button.tag = 1
            seriesButtonClicked(button)
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
