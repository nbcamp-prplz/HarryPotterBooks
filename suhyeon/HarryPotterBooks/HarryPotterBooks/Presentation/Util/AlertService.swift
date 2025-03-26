//
//  AlertService.swift
//  HarryPotterBooks
//
//  Created by 이수현 on 3/26/25.
//

import UIKit

final class AlertService {
    // 에러 얼럿 생성 함수
    func createErrorAlert(title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "확인", style: .default)
        alert.addAction(confirmAction)
        return alert
    }
}
