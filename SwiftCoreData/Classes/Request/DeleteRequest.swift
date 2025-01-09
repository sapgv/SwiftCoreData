//
//  DeleteRequest.swift
//  SwiftCoreData
//
//  Created by Grigory Sapogov on 09.01.2025.
//

import Foundation
import CoreData

public protocol Deletable {
    
    associatedtype T: NSManagedObject
    
    var request: NSFetchRequest<T> { get }
    
    func delete(inContext context: NSManagedObjectContext, completion: (Error?) -> Void)
    
}

public class DeleteRequest<T: NSManagedObject> {
    
    public private(set) var request: NSFetchRequest<T>
    
    public init(_ type: T.Type) {
        self.request = NSFetchRequest<T>(entityName: T.entityName)
        self.request.resultType = .managedObjectResultType
    }
    
    public func delete(inContext context: NSManagedObjectContext, completion: (Error?) -> Void) {

        let array = self.fetch(inContext: context)
        
        guard !array.isEmpty else {
            completion(nil)
            return
        }
        
        for object in array {
            context.delete(object)
        }
        
        do {
            try context.save()
            completion(nil)
        }
        catch {
            completion(error)
        }
        
    }
    
}

public extension CoreDataStack {
    
    func deleteRequest<T: NSManagedObject>(_ type: T.Type) -> DeleteRequest<T> {
        return DeleteRequest(type)
    }
    
}


