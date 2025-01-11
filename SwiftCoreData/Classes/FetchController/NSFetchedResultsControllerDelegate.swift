//
//  NSFetchedResultsControllerDelegate.swift
//  SwiftCoreData
//
//  Created by Grigory Sapogov on 11.01.2025.
//

import Foundation
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
            if let indexPath = indexPath {
                deleteRows(at: [indexPath], with: .fade)
            }
            if let indexPath = newIndexPath {
                insertRows(at: [indexPath], with: .fade)
            }
            break;
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
                if let indexPath = indexPath {
                    deleteItems(at: [indexPath])
                }
                if let indexPath = newIndexPath {
                    insertItems(at: [indexPath])
                }
                break;
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
