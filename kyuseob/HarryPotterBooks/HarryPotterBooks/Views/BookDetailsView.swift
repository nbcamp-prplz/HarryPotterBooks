//
//  BookInfoBottomView.swift
//  HarryPotterBooks
//
//  Created by 송규섭 on 3/27/25.
//

import UIKit

class BookDetailsView: UIView {
    
    private let dedicationStackView = TitleContentView()
    
    private let summaryStackView = TitleContentView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented.")
    }
    
    private func setupUI() {
        setupHierarchy()
        setupConstraints()
    }
    
    private func setupHierarchy() {
        addSubview(dedicationStackView)
        addSubview(summaryStackView)
    }
    
    private func setupConstraints() {
        dedicationStackView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.directionalHorizontalEdges.equalToSuperview().inset(20)
        }
        
        summaryStackView.snp.makeConstraints {
            $0.top.equalTo(dedicationStackView.snp.bottom)
            $0.directionalHorizontalEdges.equalToSuperview().inset(20)
        }
        
        self.snp.makeConstraints {
            $0.bottom.equalTo(summaryStackView.snp.bottom)
        }
    }

    func configure(dedication: String, summary: String) {
        dedicationStackView.configure(title: "Dedication", content: dedication)
        summaryStackView.configure(title: "Summary", content: summary)
    }
    
}
