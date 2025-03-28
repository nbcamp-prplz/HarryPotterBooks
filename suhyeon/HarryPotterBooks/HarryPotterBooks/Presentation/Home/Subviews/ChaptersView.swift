//
//  ChaptersView.swift
//  HarryPotterBooks
//
//  Created by 이수현 on 3/27/25.
//

import UIKit

// 챕터 뷰
class ChaptersStackView: UIStackView {
    // 타이틀
    private let titleLabel = UILabel().then {
        $0.text = "Chapters"
        $0.font = .systemFont(ofSize: 19, weight: .bold)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubview()
        setUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubview() {
        self.addArrangedSubview(titleLabel)
    }
    
    private func setUI() {
        self.axis = .vertical
        self.spacing = 8
    }
    
    func configure(contents: [String]) {
        if arrangedSubviews.count > 1 { return } // 이미 추가되어있으면 종료 (titleLabel은 이미 포함됨)
        contents.forEach { content in
            let contentLabel = ContentLabel()
            contentLabel.configure(content: content)
            
            self.addArrangedSubview(contentLabel)
        }
    }
}

// ChaptersStackView 내부에서만 사용하므로 fileprivate 키워드 사용
fileprivate class ContentLabel: UILabel {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.font = .systemFont(ofSize: 14)
        self.textColor = .darkGray
    }
    
    func configure(content: String) {
        self.text = content
    }
}
