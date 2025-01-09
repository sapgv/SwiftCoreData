//
//  FetchRequestDictionary.swift
//  SwiftCoreData
//
//  Created by Grigory Sapogov on 09.01.2025.
//

import Foundation
import CoreData

public class FetchRequestDictionary {
    
    public private(set) var request: NSFetchRequest<NSDictionary>
    
    public init<T: NSManagedObject>(_ type: T.Type) {
        self.request = NSFetchRequest<NSDictionary>(entityName: T.entityName)
        self.request.resultType = .dictionaryResultType
    }
    
}

public extension CoreDataStack {
    
    func fetchRequestDictionary<T: NSManagedObject>(_ type: T.Type) -> FetchRequestDictionary {
        return FetchRequestDictionary(type)
    }
    
}
