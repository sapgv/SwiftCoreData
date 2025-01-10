//
//  BatchDeleteRequest.swift
//  SwiftCoreData
//
//  Created by Grigory Sapogov on 09.01.2025.
//

import Foundation
import CoreData

public protocol BatchDeletable {
    
    var request: NSFetchRequest<NSFetchRequestResult> { get }
    
    func clean(inContext context: NSManagedObjectContext, completion: (Error?) -> Void)
    
    func merge(into contexts: [NSManagedObjectContext]) -> Self
    
}

public class BatchDeleteRequest<T: NSManagedObject> {
    
    public private(set) var request: NSFetchRequest<NSFetchRequestResult>
    
    private var mergeContexts: Set<NSManagedObjectContext>
    
    private var deleteRequest: NSBatchDeleteRequest {
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: self.request)
        deleteRequest.resultType = .resultTypeObjectIDs
        return deleteRequest
    }
    
    public init(_ type: T.Type, mergeInto mergeContexts: [NSManagedObjectContext] = []) {
        self.request = NSFetchRequest<NSFetchRequestResult>(entityName: T.entityName)
        self.mergeContexts = Set<NSManagedObjectContext>(mergeContexts)
    }
    
    public func clean(inContext context: NSManagedObjectContext, completion: (Error?) -> Void) {

        do {
            
            let results = try context.execute(deleteRequest) as! NSBatchDeleteResult
            
            let changes: [AnyHashable: Any] = [
                NSDeletedObjectsKey: results.result as! [NSManagedObjectID]
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
    
    public func merge(changes: [AnyHashable: Any]) {
        guard !self.mergeContexts.isEmpty else { return }
        let into = Array(self.mergeContexts)
        NSManagedObjectContext.mergeChanges(fromRemoteContextSave: changes, into: into)
    }
    
}

extension BatchDeleteRequest: BatchDeletable {}

public extension CoreDataStack {
    
    func batchDeleteRequest<T: NSManagedObject>(_ type: T.Type) -> BatchDeleteRequest<T> {
        let mergeInto: [NSManagedObjectContext] = self.viewContext.automaticallyMergesChangesFromParent ? [self.viewContext] : []
        return BatchDeleteRequest(type, mergeInto: mergeInto)
    }
    
}


