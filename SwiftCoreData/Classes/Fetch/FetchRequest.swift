//
//  FetchRequest.swift
//  Pods-SwiftCoreData_Example
//
//  Created by Grigory Sapogov on 06.01.2025.
//

import Foundation
import CoreData

public class FetchRequest<T: NSManagedObject> {
    
    public private(set) var request: NSFetchRequest<T>
    
    public init(_ type: T.Type) {
        self.request = NSFetchRequest<T>(entityName: T.entityName)
        self.request.resultType = .managedObjectResultType
    }
    
}

public class FetchRequestID {
    
    public private(set) var request: NSFetchRequest<NSManagedObjectID>
    
    public init<T: NSManagedObject>(_ type: T.Type) {
        self.request = NSFetchRequest<NSManagedObjectID>(entityName: T.entityName)
        self.request.resultType = .managedObjectIDResultType
    }
    
}

public class FetchRequestDictionary {
    
    public private(set) var request: NSFetchRequest<NSDictionary>
    
    public init<T: NSManagedObject>(_ type: T.Type) {
        self.request = NSFetchRequest<NSDictionary>(entityName: T.entityName)
        self.request.resultType = .dictionaryResultType
    }
    
}

public class FetchRequestCount {
    
    public private(set) var request: NSFetchRequest<NSNumber>
    
    public init<T: NSManagedObject>(_ type: T.Type) {
        self.request = NSFetchRequest<NSNumber>(entityName: T.entityName)
        self.request.resultType = .countResultType
    }
    
}

public extension CoreDataStack {
    
    func fetchRequest<T: NSManagedObject>(_ type: T.Type) -> FetchRequest<T> {
        return FetchRequest<T>(type)
    }
    
    func fetchRequestID<T: NSManagedObject>(_ type: T.Type) -> FetchRequestID {
        return FetchRequestID(type)
    }
    
    func fetchRequestDictionary<T: NSManagedObject>(_ type: T.Type) -> FetchRequestDictionary {
        return FetchRequestDictionary(type)
    }
    
    func fetchRequestCount<T: NSManagedObject>(_ type: T.Type) -> FetchRequestCount {
        return FetchRequestCount(type)
    }
    
}
