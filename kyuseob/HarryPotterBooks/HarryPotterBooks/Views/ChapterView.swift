//
//  ChapterView.swift
//  HarryPotterBooks
//
//  Created by 송규섭 on 3/27/25.
//

import UIKit

class ChapterView: UIView {
    
    private let titleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        $0.textColor = .black
        $0.text = "Chapters"
    }
    
    private let contentStackView = UIStackView().then {
        $0.spacing = 8
        $0.axis = .vertical
        $0.alignment = .leading
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
        [titleLabel, contentStackView].forEach { addSubview($0) }
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.directionalHorizontalEdges.equalToSuperview().inset(20)
            $0.top.equalToSuperview().offset(24)
        }
        
        contentStackView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.directionalHorizontalEdges.equalTo(titleLabel)
        }
        
        self.snp.makeConstraints {
            $0.bottom.equalTo(contentStackView.snp.bottom)
        }
    }
    
    private func setupContentStackView(with titles: [Title]) {
        for title in titles {
            let label = UILabel().then {
                $0.font = UIFont.systemFont(ofSize: 14)
                $0.textColor = .darkGray
                $0.text = title.title
            }
            
            contentStackView.addArrangedSubview(label)
        }
    }
    
    func configure(with titles: [Title]) {
        setupContentStackView(with: titles)
    }
    
}
