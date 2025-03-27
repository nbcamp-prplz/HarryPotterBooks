//
//  InfoVerticalStackView.swift
//  HarryPotterBooks
//
//  Created by 이수현 on 3/27/25.
//

import UIKit

class InfoVerticalStackView: UIStackView {
    private let title: String
    
    // 타이틀
    private lazy var titleLabel = UILabel().then {
        $0.text = title
        $0.font = .systemFont(ofSize: 18, weight: .bold)
    }
    
    // 컨텐츠
    private let contentLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .darkGray
    }
    
    init(title: String) {
        self.title = title
        super.init(frame: .zero)
        
        setSubview()
        setUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubview() {
        [
            titleLabel,
            contentLabel
        ].forEach{ self.addArrangedSubview($0) }
    }
    
    private func setUI() {
        self.axis = .vertical
        self.spacing = 8
    }
    
    func configure(content: String) {
        contentLabel.text = content
    }
}
