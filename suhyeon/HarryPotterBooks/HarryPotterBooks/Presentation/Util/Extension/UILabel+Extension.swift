//
//  UILabel+Extension.swift
//  HarryPotterBooks
//
//  Created by 이수현 on 3/28/25.
//

import UIKit

extension UILabel {
    // 450자 넘어가면 text를 앞에서부터 450자로 줄이고 '...'을 더해줌
    func setTruncatedText(maxCharacters: Int = 450) {
        guard let text else { return }
        if text.count >= maxCharacters {
            let truncatedText = String(text.prefix(maxCharacters)) + "..."
            self.text = truncatedText
        }
    }
}
