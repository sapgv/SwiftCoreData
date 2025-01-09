//
//  FetchableOne.swift
//  SwiftCoreData
//
//  Created by Grigory Sapogov on 09.01.2025.
//

import Foundation
import CoreData

public protocol FetchableOne: AnyObject {
    
    associatedtype Result: NSFetchRequestResult
    
    var request: NSFetchRequest<Result> { get }
    
    func fetchOne(inContext context: NSManagedObjectContext) -> Result?

}

public extension FetchableOne {
    
    func fetchOne(inContext context: NSManagedObjectContext) -> Result? {
        
        self.request.fetchLimit = 1
        
        let result = try? context.fetch(request).first
        
        return result
        
    }
    
}

extension FetchRequest: FetchableOne {}

extension FetchRequestID: FetchableOne {}

extension FetchRequestDictionary: FetchableOne {}

