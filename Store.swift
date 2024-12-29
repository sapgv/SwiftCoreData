//
//  Store.swift
//  SapgvCoreData
//
//  Created by Grigory Sapogov on 29.12.2024.
//

import CoreData

public
protocol IStore: Identifiable {
    
    var storeURL: URL { get }
    
    var storeType: NSPersistentStore.StoreType { get }
    
    var options: StoreOptions? { get }
    
    var configurationName: String? { get }
    
}

