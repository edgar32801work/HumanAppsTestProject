//
//  Resources.swift
//  HumanAppsTestApp
//
//  Created by Эдгар Кусков on 27.03.24.
//

import Foundation
import UIKit

enum Resources {
    
    enum Strings {
        
        enum TabBar {
            
            static let mainItem = "Main"
            static let settingsItem = "Settings"
        }
        
        enum MainViewController {
            
            static let showImagePickerButton = "Pick image from gallery"
        }
        
        enum SettingsViewController {
            
            static let aboutUs = "About Us"
            static let aboutUsDescription = "Developer: EDKuskov"
        }
    }
    
    enum Images {
        
        enum TabBar {
            
            static let mainItem = UIImage(systemName: "photo")
            static let settingsItem = UIImage(systemName: "gearshape")
        }
        
        enum MainViewController {
            
            static let showImagePickerButton = UIImage(systemName: "photo.on.rectangle")
        }
    }
}
