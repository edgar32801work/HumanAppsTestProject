//
//  Settings.swift
//  HumanAppsTestApp
//
//  Created by Эдгар Кусков on 30.03.24.
//

import Foundation

enum Settings {
    case aboutUs
    
    static func getSetting(_ setting: Settings) -> Setting {
        switch setting {
        case .aboutUs:
            return Setting(title: Resources.Strings.SettingsViewController.aboutUs,
                           description: Resources.Strings.SettingsViewController.aboutUsDescription)
        }
    }
}

extension Settings {
    struct Setting {
        
        let title: String
        let description: String
    }
}
