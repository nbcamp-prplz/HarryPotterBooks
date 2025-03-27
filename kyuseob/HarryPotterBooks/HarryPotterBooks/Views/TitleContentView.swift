//
//  TitleContentView.swift
//  HarryPotterBooks
//
//  Created by 송규섭 on 3/27/25.
//

import UIKit

class TitleContentView: UIView {
    
    let stackView = UIStackView().then {
        $0.spacing = 8
        $0.axis = .vertical
        $0.alignment = .leading
    }
    
    let titleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        $0.textColor = .black
        $0.lineBreakMode = .byWordWrapping
        $0.numberOfLines = 0
    }
    
    let contentLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 14)
        $0.textColor = .darkGray
        $0.lineBreakMode = .byWordWrapping
        $0.numberOfLines = 0
    }
    
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
        addSubview(stackView)
        [titleLabel, contentLabel].forEach { stackView.addArrangedSubview($0) }
    }
    
    private func setupConstraints() {
        stackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.directionalHorizontalEdges.bottom.equalToSuperview()
        }
        
        self.snp.makeConstraints {
            $0.bottom.equalTo(stackView)
        }
    }
    
    func configure(title: String, content: String) {
        titleLabel.text = title
        contentLabel.text = content
    }
    
}
