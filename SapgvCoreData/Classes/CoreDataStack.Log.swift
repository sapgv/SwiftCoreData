//
//  CoreDataStack.Log.swift
//  SapgvCoreData
//
//  Created by Grigory Sapogov on 04.01.2025.
//

import CoreData

extension CoreDataStack {
    
    func log(storeDescription: NSPersistentStoreDescription) {
        #if DEBUG
        print(storeDescription)
        #endif
    }
    
    func log(error: NSError) {
        #if DEBUG
        print(error.localizedDescription)
        #endif
    }
    
}
