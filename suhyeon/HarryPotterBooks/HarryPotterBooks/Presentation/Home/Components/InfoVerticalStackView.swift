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
    private lazy var contentView = ContentView(type: type)

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
    
    func configure(content: String) {
        contentView.configure(content: content)
    }
}


fileprivate class ContentView: UIView {
    private let type: InfoVerticalStackViewType
    
    // 컨텐츠
    private let contentLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .darkGray
        $0.numberOfLines = 0
    }
    
    // 더보기/접기 버튼
    lazy var toggleMoreButton = UIButton().then {
        $0.setTitle("더보기", for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
        $0.titleLabel?.font = .systemFont(ofSize: 14)
        $0.isHidden = type != .summary
    }

    init(type: InfoVerticalStackViewType) {
        self.type = type
        super.init(frame: .zero)
        
        setSubview()
        setConstraints()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubview() {
        self.addSubview(contentLabel)
        if type == .summary { self.addSubview(toggleMoreButton) }
    }
    
    private func setConstraints() {
        
        switch type {
        case .dedication:
            contentLabel.snp.makeConstraints { make in
                make.directionalEdges.equalToSuperview()
            }
        case .summary:
            contentLabel.snp.makeConstraints { make in
                make.top.directionalHorizontalEdges.equalToSuperview()
            }
            
            toggleMoreButton.snp.makeConstraints { make in
                make.top.equalTo(contentLabel.snp.bottom).offset(10)
                make.bottom.trailing.equalToSuperview()
            }
        }
    }
    
    func configure(content: String) {
        contentLabel.text = content
        
        // 타입이 summary면서 글자가 450자 미만이면 버튼 숨기고 contentLabel을 전체 범위로 잡아줌
        if type == .summary && content.count < 450 {
            toggleMoreButton.isHidden = true
            toggleMoreButton.snp.remakeConstraints { make in
                make.height.equalTo(0)
            }
            
            contentLabel.snp.remakeConstraints { make in
                make.directionalEdges.equalToSuperview()
            }
        }
    }
}
