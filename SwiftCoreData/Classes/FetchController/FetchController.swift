//
//  FetchController.swift
//  SwiftCoreData
//
//  Created by Grigory Sapogov on 10.01.2025.
//

import Foundation
import CoreData

public class FetchController<T: NSManagedObject> {
    
    public var fetchedObjects: [T]? {
        self.fetchResultController.fetchedObjects
    }
    
    public var sections: [NSFetchedResultsSectionInfo]? {
        self.fetchResultController.sections
    }
    
    public var managedObjectContext: NSManagedObjectContext {
        self.fetchResultController.managedObjectContext
    }
    
    public var sectionNameKeyPath: String? {
        self.fetchResultController.sectionNameKeyPath
    }
    
    public var cacheName: String? {
        self.fetchResultController.cacheName
    }
    
    public lazy var delegate: NSFetchedResultsControllerDelegate? = {
        self.fetchResultController.delegate
    }()
    
    public private(set) lazy var request: NSFetchRequest<T> = {
        self.fetchResultController.fetchRequest
    }()
    
    private var fetchResultController: NSFetchedResultsController<T>
    
    public convenience init(
        _ type: T.Type,
        context: NSManagedObjectContext,
        sortDescriptors: [NSSortDescriptor]
    ) {
        self.init(type, context: context, sortDescriptors: sortDescriptors, sectionNameKeyPath: nil, cacheName: nil)
    }
    
    public init(
        _ type: T.Type,
         context: NSManagedObjectContext,
         sortDescriptors: [NSSortDescriptor],
         sectionNameKeyPath: String?,
         cacheName: String?
    ) {
        let fetchRequest = NSFetchRequest<T>(entityName: T.entityName)
        fetchRequest.sortDescriptors = sortDescriptors
        self.fetchResultController = NSFetchedResultsController(
            fetchRequest: fetchRequest,
            managedObjectContext: context,
            sectionNameKeyPath: sectionNameKeyPath,
            cacheName: cacheName
        )
    }
    
    public func performFetch() {
        guard self.request.sortDescriptors != nil else { return }
        do {
            try self.fetchResultController.performFetch()
        }
        catch {
            //handle
        }
    }
    
    public func object(at indexPath: IndexPath) -> T {
        self.fetchResultController.object(at: indexPath)
    }
    
    public func indexPath(forObject object: T) -> IndexPath? {
        self.fetchResultController.indexPath(forObject: object)
    }
    
    public func deleteCache(withName name: String?) {
        NSFetchedResultsController<T>.deleteCache(withName: name)
    }
    
}
