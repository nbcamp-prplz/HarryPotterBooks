//
//  SeriesButton.swift
//  HarryPotterBooks
//
//  Created by 이수현 on 3/25/25.
//

import UIKit

class SeriesButton: UIButton {
    private let widthHeightSize: CGFloat
    private let title: String
    
    init(title: String, widthHeightSize: CGFloat) {
        self.title = title
        self.widthHeightSize = widthHeightSize
        super.init(frame: .zero)
        
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        setTitle(title, for: .normal)
        backgroundColor = .systemBlue
        layer.cornerRadius = widthHeightSize / 2
    }
}
