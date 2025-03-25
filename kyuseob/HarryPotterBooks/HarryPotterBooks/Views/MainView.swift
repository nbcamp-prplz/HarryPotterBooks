//
//  MainView.swift
//  HarryPotterBooks
//
//  Created by 송규섭 on 3/25/25.
//

import UIKit
import SnapKit
import Then

class MainView: UIView {

    private let titleLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        $0.text = "Title"
        $0.textAlignment = .center
        $0.textColor = .black
        $0.numberOfLines = 0
    }
    
    private let seriesButton = UIButton().then {
        $0.setTitleColor( .white, for: .normal)
        $0.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        $0.backgroundColor = UIColor.systemBlue
        $0.setTitle("?", for: .normal)
        $0.isUserInteractionEnabled = false // 임시 레벨 1 기준 세팅
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
        
        seriesButton.layer.cornerRadius = 16
    }
    
    private func setupHierarchy() {
        addSubview(titleLabel)
        addSubview(seriesButton)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.horizontalEdges.greaterThanOrEqualToSuperview().inset(20)
            $0.top.equalTo(safeAreaLayoutGuide.snp.top).offset(10)
        }
        
        seriesButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(titleLabel.snp.bottom).offset(16)
            $0.leading.greaterThanOrEqualToSuperview().offset(20)
            $0.trailing.lessThanOrEqualToSuperview().offset(-20)
            $0.width.height.equalTo(32)
        }
    }
    
    func configureBook(book: Book, index: Int) {
        titleLabel.text = book.title
        seriesButton.setTitle(String(index), for: .normal)
    }
    
}
