//
//  ExpandableContentView.swift
//  HarryPotterBooks
//
//  Created by 이수현 on 3/28/25.
//

import UIKit

class ExpandableContentView: UIView {
    private let type: InfoVerticalStackViewType
    
    // 컨텐츠
    private let contentLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 14)
        $0.textColor = .darkGray
        $0.numberOfLines = 0
    }
    
    // 더보기/접기 버튼
    lazy var expandFoldButton = UIButton().then {
        $0.setTitle("더보기", for: .normal)
        $0.setTitle("접기" , for: .selected)
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
        if type == .summary { self.addSubview(expandFoldButton) }
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
            
            expandFoldButton.snp.makeConstraints { make in
                make.top.equalTo(contentLabel.snp.bottom).offset(10)
                make.bottom.trailing.equalToSuperview()
            }
        }
    }
    
    func configure(content: String, isExpandedSummary: Bool = false) {
        let maxCharacters = 450
        contentLabel.text = content
        if type != .summary { return } // summary가 아니면 종료
        
        // 더보기 버튼 로직
        expandFoldButton.isSelected = isExpandedSummary
        if !isExpandedSummary { contentLabel.setTruncatedText(maxCharacters: maxCharacters) } // 전체 내용을 보지 않으면 450자 이상이면 ... 표시
        
        let isShortSummary = type == .summary && content.count < maxCharacters // 타입이 summary면서 글자가 450자 미만인지 확인
        expandFoldButton.isHidden = isShortSummary // 450자 미만이면 더보기 버튼 숨김
        
        // 짧은 컨텐츠라면
        if isShortSummary {
            // contentLabel부터 constraints를 수정하면 오토레이아웃 경고 발생
            expandFoldButton.snp.remakeConstraints { make in
                make.height.equalTo(0)
            }
            contentLabel.snp.remakeConstraints { make in
                make.directionalEdges.equalToSuperview()
            }
        } else {
            contentLabel.snp.remakeConstraints { make in
                make.top.directionalHorizontalEdges.equalToSuperview()
            }
            expandFoldButton.snp.remakeConstraints { make in
                make.top.equalTo(contentLabel.snp.bottom).offset(10)
                make.bottom.trailing.equalToSuperview()
            }
        }
    }
}
