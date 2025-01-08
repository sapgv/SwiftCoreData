//
//  Fetchable.swift
//  SwiftCoreData
//
//  Created by Grigory Sapogov on 07.01.2025.
//

import Foundation
import CoreData

public protocol FetchableRequest: AnyObject {
    
    associatedtype Result: NSFetchRequestResult
    
    var request: NSFetchRequest<Result> { get }
    
    var fetchLimit: Int { get set }
    
    var fetchBatchSize: Int { get set }
    
    func fetch(inContext context: NSManagedObjectContext) -> [Result]

    func fetchOne(inContext context: NSManagedObjectContext) -> Result?
    
}

public extension FetchableRequest {
    
    var fetchLimit: Int {
        get {
            self.request.fetchLimit
        }
        set {
            self.request.fetchLimit = newValue
        }
    }
    
    var fetchBatchSize: Int {
        get {
            self.request.fetchBatchSize
        }
        set {
            self.request.fetchBatchSize = newValue
        }
    }
    
    func fetch(inContext context: NSManagedObjectContext) -> [Result] {
        
        do {
            let result = try context.fetch(request)
            return result
        }
        catch {
            return []
        }
        
    }
    
    func fetchOne(inContext context: NSManagedObjectContext) -> Result? {
        
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

extension FetchRequest: FetchableRequest {}

extension FetchRequestID: FetchableRequest {}

extension FetchRequestDictionary: FetchableRequest {}

