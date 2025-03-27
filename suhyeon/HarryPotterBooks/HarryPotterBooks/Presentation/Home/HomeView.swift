//
//  HomeView.swift
//  HarryPotterBooks
//
//  Created by 이수현 on 3/25/25.
//

import UIKit
import Then
import SnapKit

class HomeView: UIView {
    private let widthHeightLength: CGFloat = 30 // 버튼의 너비, 높이 사이즈
    
    // 상단 책 제목
    private let mainTitleLabel = UILabel().then {
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 24, weight: .bold)
        $0.numberOfLines = 0
    }

    // 시리즈 순서
    lazy var seriesButton = SeriesButton(title: "1", widthHeightLength: widthHeightLength)
    
    // 책 정보 영역 스택뷰 (이미지 + 텍스트)
    private let bookInfoStackView = UIStackView().then {
        $0.axis = .horizontal
        $0.alignment = .center
        $0.spacing = 10
        
    }
    
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
    private let authorStackView = InfoStackView(title: "Author",
                                                titleFont:  .systemFont(ofSize: 16, weight: .bold),
                                                titleColor: .black,
                                                valueFont: .systemFont(ofSize: 18),
                                                valueColor: .darkGray)
    
    // 출간일 스택뷰
    private let releaseStackView = InfoStackView(title: "Released",
                                                titleFont:  .systemFont(ofSize: 14, weight: .bold),
                                                titleColor: .black,
                                                valueFont: .systemFont(ofSize: 14),
                                                 valueColor: .gray)
    // 페이지 스택뷰
    private let pageStackView = InfoStackView(title: "Pages",
                                                titleFont:  .systemFont(ofSize: 14, weight: .bold),
                                                titleColor: .black,
                                                valueFont: .systemFont(ofSize: 14),
                                                 valueColor: .gray)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .white
        
        setSubview()     // setSubview 설정
        setConstraints() // 제약조건 설정
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // subView 설정
    private func setSubview() {
        [
            mainTitleLabel,
            seriesButton,
            bookInfoStackView
        ].forEach { self.addSubview($0) } // HomeView
        
        [
            bookImageView,
            bookDescriptionStackView
        ].forEach { bookInfoStackView.addArrangedSubview($0) } // BookInfoStackView (이미지 + 책 설명)
        
        [
            bookTitleLabel,
            authorStackView,
            releaseStackView,
            pageStackView
        ].forEach { bookDescriptionStackView.addArrangedSubview($0) } // 책 설명 스택뷰
    }
    
    // 제약조건 설정
    private func setConstraints() {
        
        // 책 제목
        mainTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(safeAreaLayoutGuide).inset(16)
            make.directionalHorizontalEdges.equalToSuperview().inset(20)
        }
        
        // 시리즈 버튼
        seriesButton.snp.makeConstraints { make in
            make.size.equalTo(widthHeightLength)
            make.top.equalTo(mainTitleLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.directionalHorizontalEdges.greaterThanOrEqualToSuperview().inset(20).priority(.low)
        }
        
        // 책 정보 스택 뷰
        bookInfoStackView.snp.makeConstraints { make in
            make.top.equalTo(seriesButton.snp.bottom).offset(20)
            make.directionalHorizontalEdges.equalTo(safeAreaLayoutGuide).inset(5)
        }
        
        // 책 이미지
        bookImageView.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(bookImageView.snp.width).multipliedBy(1.5)
        }
    }
    
    // configuration
    public func configure(book: Book, index: Int) {
        mainTitleLabel.text = book.title
        bookTitleLabel.text = book.title
        bookImageView.image = UIImage(named: "harrypotter\(index)")
        authorStackView.configure(value: book.author)
        releaseStackView.configure(value: book.releaseDate)
        pageStackView.configure(value: "\(book.pages)")
    }
}
