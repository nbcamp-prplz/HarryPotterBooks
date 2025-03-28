//
//  HomeTopView.swift
//  HarryPotterBooks
//
//  Created by 이수현 on 3/28/25.
//

import UIKit

class HomeTopView: UIView {
    private let widthHeightLength: CGFloat = 30 // 버튼의 너비, 높이 사이즈
    
    // 상단 책 제목
    private let mainTitleLabel = UILabel().then {
        $0.textAlignment = .center
        $0.font = .systemFont(ofSize: 24, weight: .bold)
        $0.numberOfLines = 0
    }

    // 시리즈 순서
    lazy var seriesButton = SeriesButton(title: "1", widthHeightLength: widthHeightLength)
    
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
        ].forEach { self.addSubview($0) } // HomeTopView
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
            make.bottom.equalToSuperview()
        }
    }
    
    // configuration
    public func configure(book: Book, index: Int) {
        mainTitleLabel.text = book.title    // 메인 타이틀
    }
}
