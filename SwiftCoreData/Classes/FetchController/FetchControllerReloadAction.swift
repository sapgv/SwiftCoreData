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
    
}
