//
//  TabBarController.swift
//  HumanAppsTestApp
//
//  Created by Эдгар Кусков on 27.03.24.
//

import UIKit

final class TabBarController: UITabBarController {
    
    override func viewDidLoad() {
        
        setConfigurations()
        configureAppearance()
    }
}

extension TabBarController {
    
    private func setConfigurations() {
        let mainViewController = UINavigationController(rootViewController: MainViewController())
        let settingsViewController = UINavigationController(rootViewController: SettingsViewController())
        
        mainViewController.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.mainItem,
                                                     image: Resources.Images.TabBar.mainItem,
                                                     tag: 0)
        settingsViewController.tabBarItem = UITabBarItem(title: Resources.Strings.TabBar.settingsItem,
                                                         image: Resources.Images.TabBar.settingsItem,
                                                         tag: 1)
        
        setViewControllers([mainViewController, settingsViewController], animated: true)
    }
    
    private func configureAppearance() {
        view.backgroundColor = .white
    }
}
