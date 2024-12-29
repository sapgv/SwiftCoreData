//
//  InMemoryStore.swift
//  SapgvCoreData
//
//  Created by Grigory Sapogov on 29.12.2024.
//

import CoreData

public class InMemoryStore: IStore {
    
    public let uuid: UUID
    
    public let storeURL: URL = URL(fileURLWithPath: "/dev/null")
    
    public let storeType: NSPersistentStore.StoreType = .inMemory
    
    public let options: StoreOptions?
    
    public let configurationName: String?
    
    public init(
        uuid: UUID = UUID(),
        options: [AnyHashable : Any]? = StoreOptions.defaultOptions(),
        configurationName: String?
    ) {
        self.uuid = uuid
        self.options = options
        self.configurationName = configurationName
    }
    
}


