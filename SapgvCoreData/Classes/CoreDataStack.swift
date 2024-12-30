//
//  CoreDataStack.swift
//  SapgvCoreData
//
//  Created by Grigory Sapogov on 29.12.2024.
//

import CoreData

public class CoreDataStack {
    
    public let modelName: String

    public let container: NSPersistentContainer
    
    public let viewContext: NSManagedObjectContext
    
    public let persistentStoreCoordinator: NSPersistentStoreCoordinator
    
    public var inMemory: Bool {
        self.storeDescription?.type == "InMemory"
    }
    
    public private(set) var storeDescription: NSPersistentStoreDescription?
    
    public convenience init(
        modelName: String,
        bundle: Bundle = .main,
        inMemory: Bool = false,
        viewContextSettings: ViewContextSettings = .main,
        completion: ((Error?) -> Void)? = nil
    ) {
        
        let storeDescription = PersistentStoreDescription(modelName: modelName, inMemory: inMemory)
        
        let managedObjectModel = try? NSManagedObjectModel.managedObjectModel(modelName: modelName, bundle: bundle)
        
        self.init(
            modelName: modelName,
            storeDescription: storeDescription,
            managedObjectModel: managedObjectModel,
            viewContextSettings: viewContextSettings,
            completion: completion
        )
        
    }
    
    public init(
        modelName: String,
        storeDescription: PersistentStoreDescription,
        managedObjectModel: NSManagedObjectModel? = nil,
        viewContextSettings: ViewContextSettings = .main,
        completion: ((Error?) -> Void)? = nil
    ) {
        
        let container = PersistentContainer(modelName: modelName, managedObjectModel: managedObjectModel)
        
        self.modelName = modelName
        self.container = container
        self.viewContext = container.viewContext
        self.persistentStoreCoordinator = container.persistentStoreCoordinator

        container.persistentStoreDescriptions = [storeDescription]
        
        var loaded = false
        
        container.loadPersistentStores { [weak self] storeDescription, error in

            defer {
                self?.storeDescription = storeDescription
                loaded = error == nil
            }
            
            #if DEBUG
            print(storeDescription)
            #endif
            
            if let error = error as NSError? {
                completion?(error)
                return
            }
            
            completion?(nil)
            
        }
        
        if !loaded {
            completion?(PersistentContainerError.loadModelFailure)
            return
        }

        self.viewContext.automaticallyMergesChangesFromParent = viewContextSettings.automaticallyMergesChangesFromParent
        self.viewContext.mergePolicy = viewContextSettings.mergePolicy
        
    }
    
}
