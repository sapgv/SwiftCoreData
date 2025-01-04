//
//  PersistentContainer.swift
//  SwiftCoreData
//
//  Created by Grigory Sapogov on 30.12.2024.
//

import CoreData

public class PersistentContainer: NSPersistentContainer {
    
    convenience init(modelName: String, managedObjectModel: NSManagedObjectModel?) {
        
        if let managedObjectModel {
            self.init(name: modelName, managedObjectModel: managedObjectModel)
        }
        else {
            self.init(name: modelName)
        }
        
    }
    
}
