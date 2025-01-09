//
//  PersistentStoreDescription.swift
//  SwiftCoreData
//
//  Created by Grigory Sapogov on 30.12.2024.
//

import CoreData

public class PersistentStoreDescription: NSPersistentStoreDescription {
    
    public convenience init(modelName: String, inMemory: Bool) {
        let storeURL = inMemory ? Self.inMemoryStoreURL() : Self.applicationSupportStoreURL(modelName: modelName)
        self.init(url: storeURL)
        self.type = inMemory ? PersistentStoreDescription.inMemoryStoreType : PersistentStoreDescription.sqlStoreType
        self.shouldAddStoreAsynchronously = false
        self.shouldInferMappingModelAutomatically = true
        self.shouldMigrateStoreAutomatically = true
    }
    
    public override init(url: URL) {
        super.init(url: url)
        self.type = PersistentStoreDescription.sqlStoreType
        self.shouldAddStoreAsynchronously = false
        self.shouldInferMappingModelAutomatically = true
        self.shouldMigrateStoreAutomatically = true
    }
    
}

public extension PersistentStoreDescription {
    
    static let sqlStoreType = "SQLite"
    
    static let inMemoryStoreType = "InMemory"
    
    static func applicationSupportStoreURL(modelName: String) -> URL {
        
        FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
            .appendPath(modelName: modelName)
            .appendingPathExtension("sqlite")
        
    }
    
    static func inMemoryStoreURL() -> URL {
        URL(fileURLWithPath: "/dev/null")
    }
    
}

public extension URL {
    
    func appendPath(modelName: String) -> URL {
        
        #if os(iOS)
        if #available(iOS 16.0, *) {
            return self.appending(path: modelName, directoryHint: .notDirectory)
        }
        else {
            return self.appendingPathComponent(modelName, isDirectory: false)
        }
        #elseif os(macOS)
        if #available(macOS 13.0, *) {
            return self.appending(path: modelName, directoryHint: .notDirectory)
        }
        else {
            return self.appendingPathComponent(modelName, isDirectory: false)
        }
        #endif
        
    }
    
}
