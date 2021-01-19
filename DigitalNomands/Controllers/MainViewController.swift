//
//  MainViewController.swift
//  DigitalNomands
//
//  Created by Viktor on 18.01.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    private var viewModel = MainViewViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupColorSchema()
        viewModel.fetchNextPageIfPossible()
        
    }
}

extension MainViewController {
    private func setupColorSchema() {
        view.backgroundColor = .mainWhite
        navigationController?.navigationBar.barTintColor = .mainWhite
        navigationController?.navigationBar.shadowImage = UIImage()
    }
}
