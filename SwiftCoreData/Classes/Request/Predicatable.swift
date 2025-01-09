//
//  Predicatable.swift
//  SwiftCoreData
//
//  Created by Grigory Sapogov on 07.01.2025.
//

import Foundation
import CoreData

public protocol Predicatable: AnyObject {
    
    associatedtype Result: NSFetchRequestResult
    
    var request: NSFetchRequest<Result> { get }
    
    func predicate(_ predicate: NSPredicate?) -> Self
    
    func predicates(_ predicates: [NSPredicate]) -> Self
    
}

public extension Predicatable {
    
    func predicate(_ predicate: NSPredicate?) -> Self {
        
        guard let predicate else {
            self.request.predicate = nil
            return self
        }
        
        if let existedPredicate = self.request.predicate {
            self.request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: [existedPredicate, predicate])
        }
        else {
            self.request.predicate = predicate
        }
        
        return self
        
    }
    
    func predicates(_ predicates: [NSPredicate]) -> Self {

        if let existedPredicate = self.request.predicate {
            let predicates = predicates + [existedPredicate]
            self.request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        }
        else {
            self.request.predicate = NSCompoundPredicate(andPredicateWithSubpredicates: predicates)
        }
        
        return self
        
    }
    
}

extension FetchRequest: Predicatable  {}

extension FetchRequestID: Predicatable  {}

extension FetchRequestDictionary: Predicatable  {}

extension FetchRequestCount: Predicatable  {}

extension DeleteRequest: Predicatable  {}

extension BatchDeleteRequest: Predicatable  {}

