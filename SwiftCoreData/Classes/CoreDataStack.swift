//
//  CoreDataStack.swift
//  SwiftCoreData
//
//  Created by Grigory Sapogov on 29.12.2024.
//

import CoreData

public class CoreDataStack {
    
    public let modelName: String
    
    public var loadPersistentStoreCompletion: ((Swift.Result<NSPersistentStoreDescription, Error>) -> Void)?
    
    public private(set) var isStoreLoaded: Bool = false
    
    public private(set) lazy var container: PersistentContainer = {
        
        let container = PersistentContainer(modelName: self.modelName, managedObjectModel: self.managedObjectModel)
        
        container.persistentStoreDescriptions = self.persistentStoreDescriptions
        
        container.loadPersistentStores { [weak self] storeDescription, error in

            defer {
                self?.isStoreLoaded = error == nil
                self?.storeDescription = storeDescription
            }
            
            self?.log(storeDescription: storeDescription)
            
            if let error = error as NSError? {
                self?.log(error: error)
                self?.loadPersistentStoreCompletion?(.failure(error))
                return
            }
            
            self?.loadPersistentStoreCompletion?(.success(storeDescription))
            
        }
        
        return container
        
    }()
    
    public private(set) lazy var viewContext: NSManagedObjectContext = {
        let viewContext = self.container.viewContext
        viewContext.automaticallyMergesChangesFromParent = contextSettings.automaticallyMergesChangesFromParent
        viewContext.mergePolicy = contextSettings.mergePolicy
        return viewContext
    }()
    
    public private(set) lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        self.container.persistentStoreCoordinator
    }()
    
    public var inMemory: Bool {
        self.storeDescription?.type == "InMemory"
    }
    
    public private(set) lazy var storeDescription: NSPersistentStoreDescription? = {
        self.container.persistentStoreDescriptions.first
    }()
    
    private let contextSettings: NSManagedObjectContext.Settings
    
    private let managedObjectModel: NSManagedObjectModel?
    
    private let persistentStoreDescriptions: [PersistentStoreDescription]
    
    public convenience init(
        modelName: String,
        bundle: Bundle = .main,
        inMemory: Bool = false,
        contextSettings: NSManagedObjectContext.Settings = .default) {
        
        let storeDescription = PersistentStoreDescription(modelName: modelName, inMemory: inMemory)
        
        let managedObjectModel = try? NSManagedObjectModel.managedObjectModel(modelName: modelName, bundle: bundle)
        
        self.init(
            modelName: modelName,
            storeDescription: storeDescription,
            managedObjectModel: managedObjectModel,
            contextSettings: contextSettings)
            
    }
    
    public init(
        modelName: String,
        storeDescription: PersistentStoreDescription,
        managedObjectModel: NSManagedObjectModel? = nil,
        contextSettings: NSManagedObjectContext.Settings = .default) {
        
        self.modelName = modelName
        self.managedObjectModel = managedObjectModel
        self.contextSettings = contextSettings
        self.persistentStoreDescriptions = [storeDescription]
        
    }
    
    public func createBackgroundContext(
        contextSettings: NSManagedObjectContext.Settings = .default
    ) -> NSManagedObjectContext{
        let privateContext = self.container.newBackgroundContext()
        privateContext.automaticallyMergesChangesFromParent = contextSettings.automaticallyMergesChangesFromParent
        privateContext.mergePolicy = contextSettings.mergePolicy
        return privateContext
    }
    
    public func performBackgroundTask(
        contextSettings: NSManagedObjectContext.Settings = .default,
        _ perform: @escaping (NSManagedObjectContext) -> Void
    ) {
        
        self.container.performBackgroundTask { privateContext in
            privateContext.automaticallyMergesChangesFromParent = contextSettings.automaticallyMergesChangesFromParent
            privateContext.mergePolicy = contextSettings.mergePolicy
            perform(privateContext)
        }
        
    }
    
    public func createContext(
        concurrencyType: NSManagedObjectContextConcurrencyType,
        contextSettings: NSManagedObjectContext.Settings = .default
    ) -> NSManagedObjectContext {
            
            let context = NSManagedObjectContext(concurrencyType: concurrencyType)
            context.automaticallyMergesChangesFromParent = contextSettings.automaticallyMergesChangesFromParent
            context.mergePolicy = contextSettings.mergePolicy
            context.persistentStoreCoordinator = self.persistentStoreCoordinator
            return context
        }
    
    public func createChildContext(
        concurrencyType: NSManagedObjectContextConcurrencyType,
        fromContext parentContext: NSManagedObjectContext,
        contextSettings: NSManagedObjectContext.Settings = .default
    ) -> NSManagedObjectContext {
        
        let context = NSManagedObjectContext(concurrencyType: concurrencyType)
        context.automaticallyMergesChangesFromParent = contextSettings.automaticallyMergesChangesFromParent
        context.mergePolicy = contextSettings.mergePolicy
        context.parent = parentContext
        return context
        
    }
    
}
