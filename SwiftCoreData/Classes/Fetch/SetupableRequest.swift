//
//  SetupableRequest.swift
//  SwiftCoreData
//
//  Created by Grigory Sapogov on 08.01.2025.
//

import Foundation
import CoreData

public protocol SetupableRequest: AnyObject {
    
    associatedtype Result: NSFetchRequestResult

    func setup(_ completion: (NSFetchRequest<Result>) -> Void) -> Self
    
}

extension FetchRequest: SetupableRequest {
    
    public func setup(_ completion: (NSFetchRequest<T>) -> Void) -> Self {
        completion(self.request)
        return self
    }
    
}

extension FetchRequestID: SetupableRequest {
    
    public func setup(_ completion: (NSFetchRequest<NSManagedObjectID>) -> Void) -> Self {
        completion(self.request)
        return self
    }
    
}

extension FetchRequestDictionary: SetupableRequest {
    
    public func setup(_ completion: (NSFetchRequest<NSDictionary>) -> Void) -> Self {
        completion(self.request)
        return self
    }
    
}

extension FetchRequestCount: SetupableRequest {
    
    public func setup(_ completion: (NSFetchRequest<NSNumber>) -> Void) -> Self {
        completion(self.request)
        return self
    }
    
}

