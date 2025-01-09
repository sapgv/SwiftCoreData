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

}

public extension Fetchable {
    
    func fetch(inContext context: NSManagedObjectContext) -> [Result] {
        
        let result = try? context.fetch(request)
        
        return result ?? []
        
    }
    
}

extension FetchRequest: Fetchable {}

extension FetchRequestID: Fetchable {}

extension FetchRequestDictionary: Fetchable {}

extension DeleteRequest: Fetchable {}

