//
//  HomeViewController.swift
//  HarryPotterBooks
//
//  Created by 이수현 on 3/25/25.
//

import UIKit

class HomeViewController: UIViewController {
    private let homeView = HomeView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view = homeView
    }
}
