//
//  FetchRequestCount.swift
//  SwiftCoreData
//
//  Created by Grigory Sapogov on 09.01.2025.
//

import Foundation
import CoreData

public class FetchRequestCount {
    
    public private(set) var request: NSFetchRequest<NSNumber>
    
    public init<T: NSManagedObject>(_ type: T.Type) {
        self.request = NSFetchRequest<NSNumber>(entityName: T.entityName)
        self.request.resultType = .countResultType
    }
    
}

public extension CoreDataStack {
    
    func fetchRequestCount<T: NSManagedObject>(_ type: T.Type) -> FetchRequestCount {
        return FetchRequestCount(type)
    }
    
}
