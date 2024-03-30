//
//  SettingsViewViewModelType.swift
//  HumanAppsTestApp
//
//  Created by Эдгар Кусков on 30.03.24.
//

import Foundation

protocol SettingsViewViewModelType {
    
    var settings: [Settings.Setting] { get }
    
    func getInfoForSetting(at indexPath: IndexPath) -> (String, String)
}
