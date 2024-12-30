//
//  ViewContextSettings.swift
//  SapgvCoreData
//
//  Created by Grigory Sapogov on 30.12.2024.
//

import CoreData

public
struct ViewContextSettings {
    
    let automaticallyMergesChangesFromParent: Bool
    
    let mergePolicy: NSMergePolicy
    
}

public
extension ViewContextSettings {
    
    static var main: ViewContextSettings {
        ViewContextSettings(automaticallyMergesChangesFromParent: true, mergePolicy: .mergeByPropertyObjectTrump)
    }
    
}
