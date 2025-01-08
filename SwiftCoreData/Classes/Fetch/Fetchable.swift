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
    
    func fetch(inContext context: NSManagedObjectContext) -> [Result]

    func fetchOne(inContext context: NSManagedObjectContext) -> Result?

    func setupLimit(_ fetchLimit: Int) -> Self
    
    func setupBatchSize(_ fetchBatchSize: Int) -> Self
    
}

public extension FetchableRequest {
    
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
    
    func setupLimit(_ fetchLimit: Int) -> Self {
        self.request.fetchLimit = fetchLimit
        return self
    }
    
    func setupBatchSize(_ fetchBatchSize: Int) -> Self {
        self.request.fetchBatchSize = fetchBatchSize
        return self
    }
    
}

extension FetchRequest: FetchableRequest {}

extension FetchRequestID: FetchableRequest {}

extension FetchRequestDictionary: FetchableRequest {}

