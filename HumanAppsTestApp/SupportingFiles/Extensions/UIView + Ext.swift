//
//  UIView + Ext.swift
//  HumanAppsTestApp
//
//  Created by Эдгар Кусков on 27.03.24.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView...) {
        for view in views {
            self.addSubview(view)
        }
    }
}
