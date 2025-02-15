//
//  NSManagedObjectModel.swift
//  SwiftCoreData
//
//  Created by Grigory Sapogov on 30.12.2024.
//

import CoreData

public
extension NSManagedObjectModel {
    
    static func managedObjectModel(modelName: String, bundle: Bundle = .main) throws -> NSManagedObjectModel {
        let managedObjectModelURL = try modelURL(modelName: modelName, bundle: bundle)
        guard let managedObjectModel = NSManagedObjectModel(contentsOf: managedObjectModelURL) else {
            throw PersistentContainer.Error.managedObjectModelNotFound
        }
        return managedObjectModel
    }
    
    static func modelURL(modelName: String, bundle: Bundle) throws -> URL {
        
        guard let managedObjectModelURL = bundle.url(forResource: modelName, withExtension: "momd") else {
            throw PersistentContainer.Error.invalidManagedObjectModelURL
        }

        return managedObjectModelURL
        
    }
    
}
