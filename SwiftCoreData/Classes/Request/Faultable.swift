//
//  Faultable.swift
//  SwiftCoreData
//
//  Created by Grigory Sapogov on 09.01.2025.
//

import Foundation
import CoreData

public protocol Faultable: AnyObject {
    
    associatedtype Result: NSManagedObject
    
    var request: NSFetchRequest<Result> { get }
    
    func returnsObjectsAsFaults(_ value: Bool) -> Self
    
}

public extension Faultable {
    
    func returnsObjectsAsFaults(_ value: Bool) -> Self {
        self.request.returnsObjectsAsFaults = value
        return self
    }
    
}

extension FetchRequest: Faultable {}

extension DeleteRequest: Faultable {}
