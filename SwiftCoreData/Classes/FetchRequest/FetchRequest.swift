//
//  FetchRequest.swift
//  Pods-SwiftCoreData_Example
//
//  Created by Grigory Sapogov on 06.01.2025.
//

import Foundation
import CoreData

public struct FetchRequest<T: NSManagedObject> {

    public private(set) var predicate: NSPredicate?
    
    public private(set) var sortDescriptors: [NSSortDescriptor]?
    
    func predicate(_ predicate: NSPredicate?) -> Self {
        
        var clone = self
        
        guard let predicate else {
            clone.predicate = nil
            return clone
        }
        
        if let existedPredicate = self.predicate {
            clone.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [existedPredicate, predicate])
        }
        else {
            clone.predicate = predicate
        }
        
        return clone
        
    }
    
    func predicates(_ predicates: [NSPredicate]) -> Self {

        var clone = self
        
        if let existedPredicate = self.predicate {
            let predicates = predicates + [existedPredicate]
            clone.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        }
        else {
            clone.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        }
        
        return clone
        
    }
    
    func sortDescriptor(_ sortDescriptor: NSSortDescriptor?) -> Self {
        
        var clone = self
        
        guard let sortDescriptor else {
            clone.sortDescriptors = nil
            return self
        }
        
        if let existedSortDescriptors = self.sortDescriptors {
            let sortDescriptors = existedSortDescriptors + [sortDescriptor]
            clone.sortDescriptors = sortDescriptors
        }
        
        return clone
        
    }
    
}

//public
//extension NSFetchRequest {
    
//    @objc 
//    func fetch<T>(_ type: T.Type, inContext context: NSManagedObjectContext) -> [T] where T: NSFetchRequestResult {
//        do {
//            let result = try context.fetch(self) as? [T] ?? []
//            return result
//        }
//        catch {
//            return []
//        }
//    }
    
//}

public extension FetchRequest {
    
    func toRaw() -> NSFetchRequest<T> {
        let request = NSFetchRequest<T>(entityName: T.entityName)
        request.predicate = self.predicate
        request.sortDescriptors = self.sortDescriptors
        return request
    }
    
}

public
extension FetchRequest {
    
    func fetch(inContext context: NSManagedObjectContext) -> [T] {
        do {
            let request = self.toRaw()
            let result = try context.fetch(request)
            return result
        }
        catch {
            return []
        }
    }
    
}


