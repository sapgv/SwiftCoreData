//
//  NSManagedObjectContext.Settings.swift
//  SwiftCoreData
//
//  Created by Grigory Sapogov on 30.12.2024.
//

import CoreData

public
extension NSManagedObjectContext {

    struct Settings {
        
        let automaticallyMergesChangesFromParent: Bool
        
        let mergePolicy: NSMergePolicy
        
    }
    
}

public
extension NSManagedObjectContext.Settings {
    
    static var `default`: NSManagedObjectContext.Settings {
        NSManagedObjectContext.Settings(
            automaticallyMergesChangesFromParent: true,
            mergePolicy: .mergeByPropertyObjectTrump
        )
    }
    
}

