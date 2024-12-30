//
//  CoreDataStack.swift
//  SapgvCoreData
//
//  Created by Grigory Sapogov on 29.12.2024.
//

import CoreData

public class CoreDataStack {
    
    public let modelName: String

    public private(set) var isStoreLoaded: Bool = false
    
    public private(set) lazy var container: PersistentContainer = {
        
        let container = PersistentContainer(modelName: self.modelName, managedObjectModel: self.managedObjectModel)
        
        container.persistentStoreDescriptions = self.persistentStoreDescriptions
        
        container.loadPersistentStores { [weak self] storeDescription, error in

            defer {
                self?.isStoreLoaded = error == nil
                self?.storeDescription = storeDescription
            }
            
            #if DEBUG
            print(storeDescription)
            #endif
            
            if let error = error as NSError? {
                #if DEBUG
                print(error.localizedDescription)
                #endif
                return
            }
            
        }
        
        return container
        
    }()
    
    public private(set) lazy var viewContext: NSManagedObjectContext = {
        let viewContext = self.container.viewContext
        viewContext.automaticallyMergesChangesFromParent = viewContextSettings.automaticallyMergesChangesFromParent
        viewContext.mergePolicy = viewContextSettings.mergePolicy
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
    
    private let viewContextSettings: ViewContextSettings
    
    private let managedObjectModel: NSManagedObjectModel?
    
    private let persistentStoreDescriptions: [PersistentStoreDescription]
    
    public convenience init(
        modelName: String,
        bundle: Bundle = .main,
        inMemory: Bool = false,
        viewContextSettings: ViewContextSettings = .main) {
        
        let storeDescription = PersistentStoreDescription(modelName: modelName, inMemory: inMemory)
        
        let managedObjectModel = try? NSManagedObjectModel.managedObjectModel(modelName: modelName, bundle: bundle)
        
        self.init(
            modelName: modelName,
            storeDescription: storeDescription,
            managedObjectModel: managedObjectModel,
            viewContextSettings: viewContextSettings)
            
    }
    
    public init(
        modelName: String,
        storeDescription: PersistentStoreDescription,
        managedObjectModel: NSManagedObjectModel? = nil,
        viewContextSettings: ViewContextSettings = .main) {
        
        self.modelName = modelName
        self.managedObjectModel = managedObjectModel
        self.viewContextSettings = viewContextSettings
        self.persistentStoreDescriptions = [storeDescription]
        
    }
    
}
