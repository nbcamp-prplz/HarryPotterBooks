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
    
    // 스크롤뷰
    private let scrollView = UIScrollView().then {
        $0.showsVerticalScrollIndicator = false
        $0.showsHorizontalScrollIndicator = false
    }
    
    // 전체 스택 뷰 (책 정보 영역 + 헌정사 + 요약)
    private let bookInfoStackView = UIStackView().then {
        $0.axis = .vertical
        $0.spacing = 24
    }
    
    // 책 정보 영역 스택뷰 (이미지 + 제목 + 저자 + 출간일 + 페이지)
    private let bookDetailStackView = BookDetailStackView()
    
    // 헌정사
    private let dedicationStackView = InfoVerticalStackView(title: "Dedication")
    
    // 요약
    private let summaryStackView = InfoVerticalStackView(title: "Summary")
    
    // 챕터
    private let chaptersStackView = ChaptersStackView()
    
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
            scrollView,
        ].forEach { self.addSubview($0) } // HomeView
        
        scrollView.addSubview(bookInfoStackView) // 스크롤뷰
        
        [
            bookDetailStackView,
            dedicationStackView,
            summaryStackView,
            chaptersStackView,
        ].forEach { bookInfoStackView.addArrangedSubview($0) } // bookInfoStackView
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
        
        // 스크롤뷰
        scrollView.snp.makeConstraints { make in
            make.top.equalTo(seriesButton.snp.bottom).offset(20)
            make.directionalHorizontalEdges.equalTo(safeAreaLayoutGuide).inset(20)
            make.bottom.equalToSuperview()
        }

        // 전체 스택 뷰
        bookInfoStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    // configuration
    public func configure(book: Book, index: Int) {
        mainTitleLabel.text = book.title    // 메인 타이틀
        dedicationStackView.configure(content: book.dedication) // 헌정사
        summaryStackView.configure(content: book.summary) // 요역
        bookDetailStackView.configure(book: book, index: index) // 이미지 + 기본 정보
        chaptersStackView.configure(contents: book.chapters.map{$0.title})
    }
}
