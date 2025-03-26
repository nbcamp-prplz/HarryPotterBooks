//
//  BookInfoView.swift
//  HarryPotterBooks
//
//  Created by 송규섭 on 3/26/25.
//

import UIKit

final class BookInfoMiddleView: UIView {
    
    private let bookCoverImageView = UIImageView().then {
        $0.contentMode = .scaleAspectFit
    }
    
    private let bookInfoStackView = UIStackView().then {
        $0.axis = .vertical
        $0.alignment = .leading
        $0.spacing = 10
    }
    
    private let bookTitleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        $0.textColor = UIColor.black
        $0.numberOfLines = 0
        $0.lineBreakMode = .byWordWrapping
    }
    
    private var authorStackView = UIStackView()
    private var releasedStackView = UIStackView()
    private var pagesStackView = UIStackView() // 효율적으로 짜려고 별도의 setup 메서드를 만들었는데 좀 위험한 것 같음

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        // 데이터 바인딩 후 UI 설정해야 해서 이 부분에 한해서 setupUI를 configure로 이동
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
    
    private func setupUI() {
        setupHierarchy()
        setupConstraints()
    }
    
    private func setupHierarchy() {
        [bookCoverImageView, bookTitleLabel, bookInfoStackView].forEach { addSubview($0) }
        
        [authorStackView, releasedStackView, pagesStackView].forEach { stackView in
            bookInfoStackView.addArrangedSubview(stackView)
        }
    }
    
    private func setupConstraints() {
        bookCoverImageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(10) // 외부에서 5만큼 offset을 주었던 부분에 대해 내부에서 추가 조정
            $0.width.equalTo(100)
            $0.height.equalTo(bookCoverImageView.snp.width).multipliedBy(1.5)
            $0.top.equalToSuperview().offset(12)
        }
        
        bookTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(bookCoverImageView.snp.trailing).offset(12)
            $0.trailing.equalToSuperview().offset(-10)
            $0.top.equalToSuperview().offset(8)
        }
        
        bookInfoStackView.snp.makeConstraints {
            $0.leading.equalTo(bookCoverImageView.snp.trailing).offset(12)
            $0.top.equalTo(bookTitleLabel.snp.bottom).offset(12)
            $0.trailing.equalToSuperview().offset(10)
        }
        
        self.snp.makeConstraints {
            $0.bottom.equalTo(bookCoverImageView.snp.bottom).offset(12)
        }
    }
    
    private func createLabelStackView(isAuthor: Bool, title: String, value: String) -> UIStackView {
        let stackView = UIStackView().then {
            $0.axis = .horizontal
            $0.spacing = 8
        }
        
        let titleLabel = UILabel().then {
            $0.font = UIFont.systemFont(ofSize: isAuthor ? 16 : 14, weight: .bold)
            $0.textColor = .black
            $0.text = title
        }
        
        let valueLabel = UILabel().then {
            $0.font = UIFont.systemFont(ofSize: isAuthor ? 18 : 14)
            $0.textColor = isAuthor ? .darkGray : .gray
            $0.text = value
        }
        
        [titleLabel, valueLabel].forEach { stackView.addArrangedSubview($0) }
        
        return stackView
    }
    
    func configure(book: Book, index: Int) {
        bookCoverImageView.image = UIImage(named: "harrypotter\(index+1)")
        
        bookTitleLabel.text = book.title
        
        authorStackView = createLabelStackView(isAuthor: true, title: "Author", value: book.author)
        releasedStackView = createLabelStackView(isAuthor: false, title: "Released", value: book.releaseDate)
        pagesStackView = createLabelStackView(isAuthor: false, title: "pages", value: String(book.pages))
        
        setupUI()
    }
    
}
