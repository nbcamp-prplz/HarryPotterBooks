//
//  SeriesNumberCell.swift
//  HarryPotterBooks
//
//  Created by 이수현 on 3/31/25.
//

import UIKit

class SeriesNumberCell: UICollectionViewCell {
    static let id = "SeriesNumberCell"
    
    private let titleLabel = UILabel().then {
        $0.font = .systemFont(ofSize: 16)
        $0.textAlignment = .center
        $0.layer.cornerRadius = Constant.seriesNumberWidthHeight / 2
        $0.clipsToBounds = true
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubview()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setSubview() {
        self.addSubview(titleLabel)
    }
    
    private func setConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.directionalEdges.equalToSuperview()
        }
    }
    
    public func configure(title: String, isSelected: Bool) {
        titleLabel.text = title
        titleLabel.textColor = isSelected ? .white : .systemBlue
        titleLabel.backgroundColor = isSelected ? .systemBlue : .systemGray5
    }
}
