//
//  BaseViewController.swift
//  HumanAppsTestApp
//
//  Created by Эдгар Кусков on 27.03.24.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setConfigurations()
        configureAppearance()
        setupSubviews()
        constraintSubviews()
    }
}

@objc extension BaseViewController {
    
    func setConfigurations() {}
    func configureAppearance() {}
    func setupSubviews() {}
    func constraintSubviews() {}
}
