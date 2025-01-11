//
//  FetchController.swift
//  SwiftCoreData
//
//  Created by Grigory Sapogov on 10.01.2025.
//

import Foundation
import CoreData

public class FetchController<T: NSManagedObject>: NSObject, NSFetchedResultsControllerDelegate {
    
    public private(set) var reloadActions: [FetchControllerReloadAction] = []
    
    public weak var reloadActionDelegate: FetchControllerReloadActionDelegate?
    
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
    
    public var delegate: NSFetchedResultsControllerDelegate? {
        get {
            self.fetchResultController.delegate
        }
        set {
            self.fetchResultController.delegate = newValue
        }
    }
    
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
        super.init()
        self.fetchResultController.delegate = self
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
    
    //MARK: - NSFetchedResultsControllerDelegate
    
    public func reloadActionDelegate(_ delegate: FetchControllerReloadActionDelegate?) -> Self {
        self.reloadActionDelegate = delegate
        return self
    }
    
    public func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        reloadActions.removeAll()
    }
    
    public func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        self.reloadActionDelegate?.handle(actions: reloadActions)
        reloadActions.removeAll()
    }
    
    public func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch (type) {
        case .insert:
            if let newIndexPath = newIndexPath {
                reloadActions.append(.insertRows([newIndexPath]))
            }
            break
        case .delete:
            if let indexPath = indexPath {
                reloadActions.append(.deleteRows([indexPath]))
            }
            break
        case .update:
            if let indexPath = indexPath {
                reloadActions.append(.reloadRows([indexPath]))
            }
            break
        case .move:
            if let indexPath = indexPath {
                reloadActions.append(.deleteRows([indexPath]))
            }
            if let newIndexPath = newIndexPath {
                reloadActions.append(.insertRows([newIndexPath]))
            }
            break
        default:
            break
        }
    }
    
    public func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            reloadActions.append(.insertSections(IndexSet(integer: sectionIndex)))
            break
        case .delete:
            reloadActions.append(.deleteSections(IndexSet(integer: sectionIndex)))
            break
        default:
            break
        }
    }
    
}
