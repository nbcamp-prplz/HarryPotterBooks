//
//  InfoStackView.swift
//  HarryPotterBooks
//
//  Created by 이수현 on 3/26/25.
//

import UIKit

// 책 설명 수평 스택 뷰 
class InfoStackView: UIStackView {
    private let title: String
    private let titleFont: UIFont
    private let titleColor: UIColor
    private let valueFont: UIFont
    private let valueColor: UIColor
    
    // 저자 타이틀
    private lazy var titleLabel = UILabel().then {
        $0.text = title
        $0.font = titleFont
        $0.textColor = titleColor
    }
    
    // 저자
    private lazy var valueLabel = UILabel().then {
        $0.font = valueFont
        $0.textColor = valueColor
    }
    
    init(title: String, titleFont: UIFont, titleColor: UIColor,
         valueFont: UIFont, valueColor: UIColor) {
        self.title = title
        self.titleFont = titleFont
        self.titleColor = titleColor

        self.valueFont = valueFont
        self.valueColor = valueColor
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
            valueLabel
        ].forEach { self.addArrangedSubview($0) }
    }
    
    private func setUI() {
        self.axis = .horizontal
        self.spacing = 8
    }
    
    func configure(value: String) {
        valueLabel.text = value
    }
}
