//
//  SeriesButton.swift
//  HarryPotterBooks
//
//  Created by 이수현 on 3/25/25.
//

import UIKit

class SeriesButton: UIButton {
    private let widthHeightLength: CGFloat
    private let title: String
    
    init(title: String, widthHeightLength: CGFloat) {
        self.title = title
        self.widthHeightLength = widthHeightLength
        super.init(frame: .zero)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        setTitle(title, for: .normal)
        titleLabel?.font = .systemFont(ofSize: 16)
        backgroundColor = .systemBlue
        layer.cornerRadius = widthHeightLength / 2
    }
}
