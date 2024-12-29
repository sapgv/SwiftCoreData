//
//  StoreOptions.swift
//  SapgvCoreData
//
//  Created by Grigory Sapogov on 29.12.2024.
//

import CoreData

public typealias StoreOptions = [AnyHashable: Any]

public
extension StoreOptions {
    
    static func defaultOptions() -> [AnyHashable: Any]? {
        [
            NSMigratePersistentStoresAutomaticallyOption : true,
            NSInferMappingModelAutomaticallyOption : true
        ]
    }
    
}
