//
//  SettingsViewViewModel.swift
//  HumanAppsTestApp
//
//  Created by Эдгар Кусков on 30.03.24.
//

import UIKit

final class SettingsViewViewModel: SettingsViewViewModelType {
    
    var settings: [Settings.Setting] = [
        Settings.getSetting(.aboutUs)
    ]
    
    func getInfoForSetting(at indexPath: IndexPath) -> (String, String) {
        (settings[indexPath.row].title, settings[indexPath.row].description)
    }
}
