//
//  NSManagedObject.swift
//  SwiftCoreData
//
//  Created by Grigory Sapogov on 04.01.2025.
//

import CoreData

public
extension NSManagedObject {
    
    static var entityName: String {
        String(describing: self)
    }
    
}
