//
//  PersonCell.swift
//  SwiftCoreData_Example
//
//  Created by Grigory Sapogov on 10.01.2025.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import UIKit

class PersonCell: UITableViewCell {

    static let id = "PersonCell"
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var ageLabel: UILabel!
    
    func setup(name: String?, age: Int) {
        self.nameLabel.text = name
        self.ageLabel.text = "\(age)"
    }
    
}
