//
//  BatchUpdateRequest.swift
//  SwiftCoreData
//
//  Created by Grigory Sapogov on 10.01.2025.
//

import Foundation
import CoreData

public protocol BatchUpdatable {
    
    var request: NSFetchRequest<NSFetchRequestResult> { get }
    
    func update(inContext context: NSManagedObjectContext, completion: (Error?) -> Void)
    
    func merge(into contexts: [NSManagedObjectContext]) -> Self
    
    func propertiesToUpdate(_ properties: [AnyHashable: Any]?) -> Self
    
}

public class BatchUpdateRequest<T: NSManagedObject> {
    
    public private(set) var request: NSFetchRequest<NSFetchRequestResult>
    
    private var mergeContexts: Set<NSManagedObjectContext>
    
    public private(set) lazy var updateRequest: NSBatchUpdateRequest = {
        let updateRequest = NSBatchUpdateRequest(entityName: T.entityName)
        updateRequest.resultType = .updatedObjectIDsResultType
        return updateRequest
    }()
    
    public init(_ type: T.Type, mergeInto mergeContexts: [NSManagedObjectContext] = []) {
        self.request = NSFetchRequest<NSFetchRequestResult>(entityName: T.entityName)
        self.mergeContexts = Set<NSManagedObjectContext>(mergeContexts)
    }
    
    public func update(inContext context: NSManagedObjectContext, completion: (Error?) -> Void) {

        do {
            
            let results = try context.execute(updateRequest) as! NSBatchUpdateResult
            
            let changes: [AnyHashable: Any] = [
                NSUpdatedObjectsKey: results.result as! [NSManagedObjectID]
            ]
            
            self.merge(changes: changes)
            
            completion(nil)
            
        }
        catch {
            completion(error)
        }
        
    }
    
    public func merge(into contexts: [NSManagedObjectContext]) -> Self {
        self.mergeContexts = self.mergeContexts.union(Set(contexts))
        return self
    }
    
    public func propertiesToUpdate(_ properties: [AnyHashable: Any]?) -> Self {
        self.updateRequest.propertiesToUpdate = properties
        return self
    }
    
    public func merge(changes: [AnyHashable: Any]) {
        guard !self.mergeContexts.isEmpty else { return }
        let into = Array(self.mergeContexts)
        NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: into)
    }
    
}

extension BatchUpdateRequest: BatchUpdatable {}

public extension CoreDataStack {
    
    func batchUpdateRequest<T: NSManagedObject>(_ type: T.Type) -> BatchUpdateRequest<T> {
        let mergeInto: [NSManagedObjectContext] = self.viewContext.automaticallyMergesChangesFromParent ? [self.viewContext] : []
        return BatchUpdateRequest(type, mergeInto: mergeInto)
    }
    
}


