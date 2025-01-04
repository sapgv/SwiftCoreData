//
//  CoreDataStack.Fetch.swift
//  SwiftCoreData
//
//  Created by Grigory Sapogov on 04.01.2025.
//

import CoreData

public
extension CoreDataStack {
    
    func fetch<T: NSManagedObject>(
        _ type: T.Type,
        predicate: NSPredicate? = nil,
        inContext context: NSManagedObjectContext
    ) -> [T] {
        
        let request = NSFetchRequest<T>(entityName: T.entityName)
        request.predicate = predicate
        
        do {
            let result = try context.fetch(request)
            return result
        }
        catch {
            return []
        }
        
    }
    
}
