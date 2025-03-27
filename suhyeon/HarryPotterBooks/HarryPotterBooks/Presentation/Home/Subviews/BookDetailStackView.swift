//
//  BookDetailStackView.swift
//  HarryPotterBooks
//
//  Created by 이수현 on 3/27/25.
//

import UIKit

// 책 정보 영역 스택뷰 (이미지 + 제목 + 저자 + 출간일 + 페이지)
class BookDetailStackView: UIStackView {
    
    // 책 표지 이미지
    private let bookImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    // 책 정보 스택뷰 (이미지 x)
    private let bookDescriptionStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.spacing = 8
    }
    
    // 책 제목
    private let bookTitleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 20, weight: .bold)
        $0.textColor = .black
        $0.numberOfLines = 0
    }
    
    // 저자 스택뷰
    private let authorStackView = InfoHorizontalStackView(title: "Author",
                                                titleFont:  .systemFont(ofSize: 16, weight: .bold),
                                                titleColor: .black,
                                                contentFont: .systemFont(ofSize: 18),
                                                contentColor: .darkGray)
    
    // 출간일 스택뷰
    private let releaseStackView = InfoHorizontalStackView(title: "Released",
                                                titleFont:  .systemFont(ofSize: 14, weight: .bold),
                                                titleColor: .black,
                                                contentFont: .systemFont(ofSize: 14),
                                                contentColor: .gray)
    // 페이지 스택뷰
    private let pageStackView = InfoHorizontalStackView(title: "Pages",
                                                titleFont:  .systemFont(ofSize: 14, weight: .bold),
                                                titleColor: .black,
                                                contentFont: .systemFont(ofSize: 14),
                                                contentColor: .gray)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setSubview()
        setConstraints()
        setUI()
    }

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubview() {
        [
            bookImageView,
            bookDescriptionStackView
        ].forEach { self.addArrangedSubview($0) } // BookInfoStackView (이미지 + 책 설명)
        
        [
            bookTitleLabel,
            authorStackView,
            releaseStackView,
            pageStackView
        ].forEach { bookDescriptionStackView.addArrangedSubview($0) } // 책 설명 스택뷰
    }
    
    private func setConstraints() {
        // 책 이미지
        bookImageView.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(bookImageView.snp.width).multipliedBy(1.5)
        }
    }
    
    private func setUI() {
        self.axis = .horizontal
        self.alignment = .top
        self.spacing = 10
    }
    
    func configure(book: Book, index: Int) {
        bookTitleLabel.text = book.title
        bookImageView.image = UIImage(named: "harrypotter\(index)")
        authorStackView.configure(content: book.author)
        releaseStackView.configure(content: book.releaseDate)
        pageStackView.configure(content: "\(book.pages)")
    }
}
