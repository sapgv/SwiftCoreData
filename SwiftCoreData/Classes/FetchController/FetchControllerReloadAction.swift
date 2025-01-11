//
//  FetchControllerReloadAction.swift
//  SwiftCoreData
//
//  Created by Grigory Sapogov on 11.01.2025.
//

import Foundation

public enum FetchControllerReloadAction: Equatable {
    
    case insertRows([IndexPath])
    case deleteRows([IndexPath])
    case reloadRows([IndexPath])
    case insertSections(IndexSet)
    case deleteSections(IndexSet)
    case reloadData
    
    public var indexPaths: [IndexPath] {
        switch self {
        case let .insertRows(array):
            return array
        case let .deleteRows(array):
            return array
        case let .reloadRows(array):
            return array
        default:
            return []
        }
    }
    
    public var indexSet: IndexSet? {
        switch self {
        case let .insertSections(set):
            return set
        case let .deleteSections(set):
            return set
        default:
            return nil
        }
    }
    
}

public extension Array where Element == FetchControllerReloadAction {
    
    var indexPaths: [IndexPath] {
        flatMap { $0.indexPaths }
    }
    
    var indexSet: [IndexSet] {
        compactMap { $0.indexSet }
    }
    
}
