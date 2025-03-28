//
//  InfoHorizontalStackView.swift
//  HarryPotterBooks
//
//  Created by 이수현 on 3/26/25.
//

import UIKit

// 책 설명 수평 스택 뷰 
class InfoHorizontalStackView: UIStackView {
    private let title: String
    private let titleFont: UIFont
    private let titleColor: UIColor
    private let contentFont: UIFont
    private let contentColor: UIColor
    
    // 타이틀
    private lazy var titleLabel = UILabel().then {
        $0.text = title
        $0.font = titleFont
        $0.textColor = titleColor
    }
    
    // 컨텐츠
    private lazy var contentLabel = UILabel().then {
        $0.font = contentFont
        $0.textColor = contentColor
    }
    
    init(title: String, titleFont: UIFont, titleColor: UIColor,
         contentFont: UIFont, contentColor: UIColor) {
        self.title = title
        self.titleFont = titleFont
        self.titleColor = titleColor

        self.contentFont = contentFont
        self.contentColor = contentColor
        super.init(frame: .zero)
    
        setSubview()
        setUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubview(){
        [
            titleLabel,
            contentLabel
        ].forEach { self.addArrangedSubview($0) }
    }
    
    private func setUI() {
        self.axis = .horizontal
        self.spacing = 8
    }
    
    func configure(content: String) {
        contentLabel.text = content
    }
}
