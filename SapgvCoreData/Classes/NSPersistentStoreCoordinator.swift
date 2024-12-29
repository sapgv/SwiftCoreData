//
//  PersistentStoreCoordinatorFactory.swift
//  SapgvCoreData
//
//  Created by Grigory Sapogov on 29.12.2024.
//

import CoreData

extension NSPersistentStoreCoordinator {
    
    static func create(
        modelName: String,
        bundle: Bundle
    ) throws -> NSPersistentStoreCoordinator {
        
        guard let modelUrl = bundle.url(forResource: modelName, withExtension: "momd") else {
            throw PersistentStoreCoordinatorError.modelNotFound
        }
        
        guard let model = NSManagedObjectModel(contentsOf: modelUrl) else {
            throw PersistentStoreCoordinatorError.modelInitFailure
        }
        
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        
        return coordinator
        
    }
    
}
