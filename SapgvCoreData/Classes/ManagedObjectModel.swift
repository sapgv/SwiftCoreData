//
//  ManagedObjectModel.swift
//  SapgvCoreData
//
//  Created by Grigory Sapogov on 30.12.2024.
//

import CoreData

//public class ManagedObjectModel: NSManagedObjectModel {
//    
//    
//    
//}

public
extension NSManagedObjectModel {
    
    static func managedObjectModel(modelName: String, bundle: Bundle = .main) throws -> NSManagedObjectModel {
        let managedObjectModelURL = try modelURL(modelName: modelName, bundle: bundle)
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: managedObjectModelURL) else {
            throw PersistentContainerError.managedObjectModelNotFound
        }
        return managedObjectModel
    }
    
    static func modelURL(modelName: String, bundle: Bundle) throws -> URL {
        
        guard let managedObjectModelURL = bundle.url(forResource: modelName, withExtension: "momd") else {
            throw PersistentContainerError.invalidManagedObjectModelURL
        }

        return managedObjectModelURL
        
    }
    
}
