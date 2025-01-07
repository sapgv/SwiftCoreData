//
//  FetchRequest.swift
//  Pods-SwiftCoreData_Example
//
//  Created by Grigory Sapogov on 06.01.2025.
//

import Foundation
import CoreData

public class FetchRequest<Result: NSFetchRequestResult> {
    
    public private(set) var request: NSFetchRequest<Result>
    
    public convenience init<T: NSManagedObject>(
        _ type: T.Type
    ) {
        self.init(type, resultType: Result.resultType)
    }
    
    public init<T: NSManagedObject>(_ type: T.Type, resultType: NSFetchRequestResultType) {
        self.request = NSFetchRequest<Result>(entityName: T.entityName)
        self.request.resultType = resultType
    }
    
}

public extension CoreDataStack {
    
    func fetchRequestManagedObject<T: NSManagedObject>(_ type: T.Type) -> FetchRequest<T> {
        return FetchRequest<T>(type)
    }
    
    func fetchRequestManagedObjectID<T: NSManagedObject>(_ type: T.Type) -> FetchRequest<NSManagedObjectID> {
        return FetchRequest<NSManagedObjectID>(type)
    }
    
    func fetchRequestDictionary<T: NSManagedObject>(_ type: T.Type) -> FetchRequest<NSDictionary> {
        return FetchRequest<NSDictionary>(type)
    }
    
    func fetchRequestCount<T: NSManagedObject>(_ type: T.Type) -> FetchRequest<NSNumber> {
        return FetchRequest<NSNumber>(type)
    }
    
}


