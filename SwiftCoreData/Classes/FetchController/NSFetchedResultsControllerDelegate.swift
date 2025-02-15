//
//  NSFetchedResultsControllerDelegate.swift
//  SwiftCoreData
//
//  Created by Grigory Sapogov on 11.01.2025.
//
#if os(iOS)
import UIKit
import CoreData

extension UITableView: NSFetchedResultsControllerDelegate {
    
    open func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        beginUpdates()
    }
    
    open func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        endUpdates()
    }
    
    open func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch (type) {
        case .insert:
            if let indexPath = newIndexPath {
                insertRows(at: [indexPath], with: .fade)
            }
            break;
        case .delete:
            if let indexPath = indexPath {
                deleteRows(at: [indexPath], with: .fade)
            }
            break;
        case .update:
            if let indexPath = indexPath {
                reloadRows(at: [indexPath], with: .automatic)
            }
            break;
        case .move:
            if let indexPath, let newIndexPath {
                moveRow(at: indexPath, to: newIndexPath)
            }
            break
        default:
            break
        }
    }
    
    open func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        default:
            break
        }
    }
    
}

extension UICollectionView: NSFetchedResultsControllerDelegate {
    
    open func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    }
    
    open func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
    }
    
    open func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        performBatchUpdates {
            switch (type) {
            case .insert:
                if let indexPath = newIndexPath {
                    insertItems(at: [indexPath])
                }
                break;
            case .delete:
                if let indexPath = indexPath {
                    deleteItems(at: [indexPath])
                }
                break;
            case .update:
                if let indexPath = indexPath {
                    reloadItems(at: [indexPath])
                }
                break;
            case .move:
                if let indexPath, let newIndexPath {
                    moveItem(at: indexPath, to: newIndexPath)
                }
                break
            default:
                break
            }
        }
    }
    
    open func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        performBatchUpdates {
            switch type {
            case .insert:
                insertSections(IndexSet(integer: sectionIndex))
            case .delete:
                deleteSections(IndexSet(integer: sectionIndex))
            default:
                break
            }
        }
    }
    
}
#endif
