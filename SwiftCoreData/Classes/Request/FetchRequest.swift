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

public extension CoreDataStack {
    
    func fetchRequest<T: NSManagedObject>(_ type: T.Type) -> FetchRequest<T> {
        return FetchRequest<T>(type)
    }
    
}
