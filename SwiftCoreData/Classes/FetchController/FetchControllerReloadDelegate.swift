//
//  FetchControllerReloadDelegate.swift
//  SwiftCoreData
//
//  Created by Grigory Sapogov on 11.01.2025.
//

import Foundation
import CoreData

public enum FetchControllerReloadAction {
    
    case insertRows([IndexPath])
    case deleteRows([IndexPath])
    case reloadRows([IndexPath])
    case insertSections(IndexSet)
    case deleteSections(IndexSet)
    case reloadData
    
}

public protocol FetchControllerReloadDelegate: AnyObject {
    
    func handle(actions: [FetchControllerReloadAction])
    
}

extension UITableView: FetchControllerReloadDelegate {
    
    public func handle(actions: [FetchControllerReloadAction]) {
    
        self.performBatchUpdates {
            
            for action in actions {
                
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
        
    }
    
}

extension UICollectionView: FetchControllerReloadDelegate {
    
    public func handle(actions: [FetchControllerReloadAction]) {
    
        self.performBatchUpdates {
            
            for action in actions {
                
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
        
    }
    
}
