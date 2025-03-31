//
//  InfoVerticalStackView.swift
//  HarryPotterBooks
//
//  Created by 이수현 on 3/27/25.
//

import UIKit

enum InfoVerticalStackViewType: String {
    case dedication = "Dedication"
    case summary = "Summary"
}

class InfoVerticalStackView: UIStackView {
    private let type: InfoVerticalStackViewType
    
    // 타이틀
    private lazy var titleLabel = UILabel().then {
        $0.text = type.rawValue
        $0.font = .systemFont(ofSize: 18, weight: .bold)
    }
    
    // 컨텐츠뷰 (컨텐츠 라벨 + 더보기 버튼)
    lazy var contentView = ExpandableContentView(type: type)

    init(type: InfoVerticalStackViewType) {
        self.type = type
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
            contentView
        ].forEach{ self.addArrangedSubview($0) }
    }
    
    private func setUI() {
        self.axis = .vertical
        self.spacing = 8
    }
    
    func configure(content: String, isExpandedSummary: Bool = false) {
        contentView.configure(content: content, isExpandedSummary: isExpandedSummary)
    }
}
