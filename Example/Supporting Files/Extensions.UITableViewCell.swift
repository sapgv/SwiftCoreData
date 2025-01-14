//
//  Extensions.UITableViewCell.swift
//  SwiftCoreData_Example
//
//  Created by Grigory Sapogov on 11.01.2025.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import UIKit

extension UITableViewCell {
    
    func animateBackgroundColor(_ color: UIColor) {
        
        let colorBefore = self.contentView.backgroundColor
        
        UIView.animate(withDuration: 0.5, animations: {
            self.contentView.backgroundColor = color
        }) { _ in
            UIView.animate(withDuration: 0.5) {
                self.contentView.backgroundColor = colorBefore
            }
        }
        
    }
    
}
