//
//  CoreDataStack.swift
//  SapgvCoreData
//
//  Created by Grigory Sapogov on 29.12.2024.
//

import CoreData

public class CoreDataStack {
    
    public private(set) var stores: [UUID: any IStore] = [:]
    
    public let modelName: String
    
    public let persistentStoreCoordinator: NSPersistentStoreCoordinator
    
    public let viewContext: NSManagedObjectContext
    
    public let automaticallyMergesChangesFromParent: Bool
    
    public convenience init(
        modelName: String,
        bundle: Bundle = Bundle.main,
        automaticallyMergesChangesFromParent: Bool = true
    ) throws {
        let persistentStoreCoordinator = try NSPersistentStoreCoordinator.create(modelName: modelName, bundle: bundle)
        self.init(
            modelName: modelName,
            automaticallyMergesChangesFromParent: automaticallyMergesChangesFromParent,
            persistentStoreCoordinator: persistentStoreCoordinator
        )
    }
    
    public init(
        modelName: String,
        automaticallyMergesChangesFromParent: Bool = true,
        persistentStoreCoordinator: NSPersistentStoreCoordinator
    ) {
        self.modelName = modelName
        self.automaticallyMergesChangesFromParent = automaticallyMergesChangesFromParent
        self.persistentStoreCoordinator = persistentStoreCoordinator
        
        let viewContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        viewContext.persistentStoreCoordinator = persistentStoreCoordinator
        viewContext.automaticallyMergesChangesFromParent = automaticallyMergesChangesFromParent
        self.viewContext = viewContext
    }
    
    @discardableResult
    public func loadStore(filename: String) throws -> Self {
        let store = SQLStore(filename: filename)
        return try self.loadStore(store)
    }
    
    @discardableResult
    public func loadStore(storeURL: URL) throws -> Self {
        let store = SQLStore(storeURL: storeURL)
        return try self.loadStore(store)
    }
    
    @discardableResult
    public func loadStore(_ store: any IStore) throws -> Self {
        guard self.stores[store.uuid] == nil else { return self }
        let _ = try self.persistentStoreCoordinator.addPersistentStore(
            type: store.storeType,
            configuration: store.configurationName,
            at: store.storeURL,
            options: store.options
        )
        self.stores[store.uuid] = store
        return self
    }
    
}
