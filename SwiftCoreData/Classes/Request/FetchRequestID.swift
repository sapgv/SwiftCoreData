//
//  FetchRequestID.swift
//  SwiftCoreData
//
//  Created by Grigory Sapogov on 09.01.2025.
//

import Foundation
import CoreData

public class FetchRequestID {
    
    public private(set) var request: NSFetchRequest<NSManagedObjectID>
    
    public init<T: NSManagedObject>(_ type: T.Type) {
        self.request = NSFetchRequest<NSManagedObjectID>(entityName: T.entityName)
        self.request.resultType = .managedObjectIDResultType
    }
    
}

public extension CoreDataStack {
    
    func fetchRequestID<T: NSManagedObject>(_ type: T.Type) -> FetchRequestID {
        return FetchRequestID(type)
    }
    
}
