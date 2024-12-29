//
//  SQLStore.swift
//  SapgvCoreData
//
//  Created by Grigory Sapogov on 29.12.2024.
//

import CoreData

public class SQLStore: IStore {
    
    public let uuid: UUID
    
    public let storeURL: URL
    
    public let storeType: NSPersistentStore.StoreType = .sqlite
    
    public let options: StoreOptions?
    
    public let configurationName: String?
    
    public init(storeURL: URL,
                uuid: UUID = UUID(),
                options: [AnyHashable : Any]? = StoreOptions.defaultOptions(),
                configurationName: String? = nil) {
        self.storeURL = storeURL
        self.uuid = uuid
        self.options = options
        self.configurationName = configurationName
    }
    
    public init(filename: String,
                uuid: UUID = UUID(),
                options: [AnyHashable : Any]? = StoreOptions.defaultOptions(),
                configurationName: String? = nil) {
        self.storeURL = Self.defaultFileURL(filename: filename)
        self.uuid = uuid
        self.options = options
        self.configurationName = configurationName
    }
    
}

public
extension SQLStore {
    
    static func defaultDirectory() -> URL {
        
        return FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first!
        
    }
    
    static func defaultFileURL(filename: String) -> URL {
        
        return defaultDirectory()
            .appending(path: filename, directoryHint: .notDirectory)
            .appendingPathExtension("sqlite")
        
    }
    
}

