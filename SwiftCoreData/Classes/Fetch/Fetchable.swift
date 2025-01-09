//
//  Fetchable.swift
//  SwiftCoreData
//
//  Created by Grigory Sapogov on 07.01.2025.
//

import Foundation
import CoreData

public protocol Fetchable: AnyObject {
    
    associatedtype Result: NSFetchRequestResult
    
    var request: NSFetchRequest<Result> { get }
    
    func fetch(inContext context: NSManagedObjectContext) -> [Result]

    func fetchOne(inContext context: NSManagedObjectContext) -> Result?

    func setupLimit(_ fetchLimit: Int) -> Self
    
    func setupBatchSize(_ fetchBatchSize: Int) -> Self
    
}

public extension Fetchable {
    
    func fetch(inContext context: NSManagedObjectContext) -> [Result] {
        
        let result = try? context.fetch(request)
        
        return result ?? []
        
    }
    
    func fetchOne(inContext context: NSManagedObjectContext) -> Result? {
        
        self.request.fetchLimit = 1
        
        let result = try? context.fetch(request).first
        
        return result
        
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

extension FetchRequest: Fetchable {}

extension FetchRequestID: Fetchable {}

extension FetchRequestDictionary: Fetchable {}

extension DeleteRequest: Fetchable {}

