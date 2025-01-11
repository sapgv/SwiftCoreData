//
//  FetchControllerReloadDelegate.swift
//  SwiftCoreData
//
//  Created by Grigory Sapogov on 11.01.2025.
//

#if os(iOS)
import UIKit
#endif
import CoreData

public protocol FetchControllerReloadActionDelegate: AnyObject {
    
    func handle(actions: [FetchControllerReloadAction])
    
}

#if os(iOS)
extension UITableView: FetchControllerReloadActionDelegate {
    
    public func handle(actions: [FetchControllerReloadAction]) {
    
        self.performBatchUpdates {
            
            for action in actions {
                
                self.handle(action: action)
                
            }
            
        }
        
    }
    
}

extension UICollectionView: FetchControllerReloadActionDelegate {
    
    public func handle(actions: [FetchControllerReloadAction]) {
    
        self.performBatchUpdates {
            
            for action in actions {
                
                self.handle(action: action)
                
            }
            
        }
        
    }
    
}

public extension FetchControllerReloadActionDelegate where Self: UITableView {
    
    func handle(action: FetchControllerReloadAction) {
        
        switch action {
        case let .insertRows(array):
            self.insertRows(at: array, with: .fade)
        case let .deleteRows(array):
            self.deleteRows(at: array, with: .fade)
        case let .reloadRows(array):
            self.reloadRows(at: array, with: .automatic)
        case .reloadData:
            self.reloadData()
        case let .insertSections(set):
            self.insertSections(set, with: .fade)
        case let .deleteSections(set):
            self.deleteSections(set, with: .fade)
        }
        
    }
    
}

public extension FetchControllerReloadActionDelegate where Self: UICollectionView {
    
    func handle(action: FetchControllerReloadAction) {
        
        switch action {
        case let .insertRows(array):
            self.insertItems(at: array)
        case let .deleteRows(array):
            self.deleteItems(at: array)
        case let .reloadRows(array):
            self.reloadItems(at: array)
        case .reloadData:
            self.reloadData()
        case let .insertSections(set):
            self.insertSections(set)
        case let .deleteSections(set):
            self.deleteSections(set)
        }
        
    }
    
}
#endif

