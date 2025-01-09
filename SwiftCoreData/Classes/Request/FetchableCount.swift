//
//  FetchableCount.swift
//  SwiftCoreData
//
//  Created by Grigory Sapogov on 07.01.2025.
//

import Foundation
import CoreData

public protocol FetchableCount: AnyObject {
    
    associatedtype Result: NSFetchRequestResult
    
    var request: NSFetchRequest<Result> { get }
    
    func fetchCount(inContext context: NSManagedObjectContext) -> Int
    
}

public extension FetchableCount {
    
     func fetchCount(inContext context: NSManagedObjectContext) -> Int {
        
         let result = try? context.count(for: self.request)
         
         return result ?? 0
        
    }
    
}

extension FetchRequestCount: FetchableCount {}
    
