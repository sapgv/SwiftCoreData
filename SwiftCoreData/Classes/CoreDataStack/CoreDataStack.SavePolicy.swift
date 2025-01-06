//
//  CoreDataStack.SavePolicy.swift
//  SwiftCoreData
//
//  Created by Grigory Sapogov on 04.01.2025.
//

import CoreData

public
protocol ISavePolicy {
    
    func handle(context: NSManagedObjectContext)
    
}

public
struct RollBackSavePolicy: ISavePolicy {
    
    public init() {}
    
    public func handle(context: NSManagedObjectContext) {
        context.rollback()
    }
    
}

public
struct ResetSavePolicy: ISavePolicy {
    
    public init() {}
    
    public func handle(context: NSManagedObjectContext) {
        context.reset()
    }
    
}

public
struct DefaultSavePolicy: ISavePolicy {
    
    public init() {}
    
    public func handle(context: NSManagedObjectContext) {}
    
}
