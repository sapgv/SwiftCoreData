//
//  Fetchable.swift
//  SwiftCoreData
//
//  Created by Grigory Sapogov on 07.01.2025.
//

import Foundation
import CoreData

//public protocol Fetchable: AnyObject {
//    
//    associatedtype ResultType: NSFetchRequestResult
//    
//    func fetch(inContext context: NSManagedObjectContext) -> [ResultType]
//
//    func fetchOne(inContext context: NSManagedObjectContext) -> ResultType?
//    
//}

extension FetchRequest where Result: NSManagedObject {
    
    public func fetch(inContext context: NSManagedObjectContext) -> [Result] {
        
        do {
            let result = try context.fetch(request)
            return result
        }
        catch {
            return []
        }
        
    }
    
    public func fetchOne(inContext context: NSManagedObjectContext) -> Result? {
        
        do {
            self.request.fetchLimit = 1
            let result = try context.fetch(request).first
            return result
        }
        catch {
            return nil
        }
        
    }
    
}

extension FetchRequest where Result == NSManagedObjectID {
    
    public func fetch(inContext context: NSManagedObjectContext) -> [Result] {
        
        do {
            let result = try context.fetch(request)
            return result
        }
        catch {
            return []
        }
        
    }
    
    public func fetchOne(inContext context: NSManagedObjectContext) -> Result? {
        
        do {
            self.request.fetchLimit = 1
            let result = try context.fetch(request).first
            return result
        }
        catch {
            return nil
        }
        
    }
    
}

