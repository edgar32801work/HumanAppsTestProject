//
//  SettingViewController.swift
//  HumanAppsTestApp
//
//  Created by Эдгар Кусков on 30.03.24.
//

import UIKit

final class SettingViewController: BaseViewController {
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
    private let descriptionLabel: UILabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.textAlignment = .center
        descriptionLabel.numberOfLines = 0
        return descriptionLabel
    }()
    
    init(title: String, description: String) {
        super.init(nibName: nil, bundle: nil)
        
        titleLabel.text = title
        descriptionLabel.text = description
    }
    
    required init?(coder: NSCoder) { nil }
    
}

extension SettingViewController {
    
    override func setConfigurations() {
        
    }
    
    override func configureAppearance() {
        view.backgroundColor = .white.withAlphaComponent(0.9)
    }
    
    override func setupSubviews() {
        view.addSubviews(titleLabel, descriptionLabel)
    }
    
    override func constraintSubviews() {
        titleLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalToSuperview().inset(13)
        }
        descriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.width.equalToSuperview().inset(13)
            make.top.equalTo(titleLabel.snp.bottom).offset(40)
        }
    }
}
