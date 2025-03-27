//
//  Alert+Extension.swift
//  HarryPotterNovelInfo
//
//  Created by GO on 3/27/25.
//

import UIKit

extension UIViewController {
    
    func showAlert(text : String, message : String) {
        let alert = UIAlertController(title: text, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alert, animated: true)
    }
    
}
