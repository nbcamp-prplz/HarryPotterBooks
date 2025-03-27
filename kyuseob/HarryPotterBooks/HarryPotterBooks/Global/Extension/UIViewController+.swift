//
//  UIViewController+.swift
//  HarryPotterBooks
//
//  Created by 송규섭 on 3/26/25.
//

import UIKit

extension UIViewController {
    func showMessage(title: String?, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        self.present(alert, animated: true)
    }
}
