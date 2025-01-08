//
//  Sortable.swift
//  SwiftCoreData
//
//  Created by Grigory Sapogov on 07.01.2025.
//

import Foundation
import CoreData

public protocol Sortable: AnyObject {
    
    associatedtype Result: NSFetchRequestResult
    
    var request: NSFetchRequest<Result> { get }
    
    func sortDescriptor(_ sortDescriptor: NSSortDescriptor?) -> Self
    
}

public extension Sortable {
    
    func sortDescriptor(_ sortDescriptor: NSSortDescriptor?) -> Self {
        
        guard let sortDescriptor else {
            self.request.sortDescriptors = nil
            return self
        }
        
        if let existedSortDescriptors = self.request.sortDescriptors {
            let sortDescriptors = existedSortDescriptors + [sortDescriptor]
            self.request.sortDescriptors = sortDescriptors
        }
        
        return self
        
    }
    
}

extension FetchRequest: Sortable {}

extension FetchRequestID: Sortable {}

extension FetchRequestDictionary: Sortable {}

