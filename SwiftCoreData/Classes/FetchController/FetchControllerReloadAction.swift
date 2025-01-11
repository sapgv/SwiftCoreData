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
    case updateRows([IndexPath])
    case moveRows(IndexPath, IndexPath)
    case insertSections(IndexSet)
    case deleteSections(IndexSet)
    
    public var insertedIndexPaths: [IndexPath] {
        switch self {
        case let .insertRows(array):
            return array
        default:
            return []
        }
    }
    
    public var deletedIndexPaths: [IndexPath] {
        switch self {
        case let .deleteRows(array):
            return array
        default:
            return []
        }
    }
    
    public var updatedIndexPaths: [IndexPath] {
        switch self {
        case let .updateRows(array):
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
    
    var insertedIndexPaths: [IndexPath] {
        flatMap { $0.insertedIndexPaths }
    }
    
    var deletedIndexPaths: [IndexPath] {
        flatMap { $0.deletedIndexPaths }
    }
    
    var updatedIndexPaths: [IndexPath] {
        flatMap { $0.updatedIndexPaths }
    }
    
    var indexSet: [IndexSet] {
        compactMap { $0.indexSet }
    }
    
}
