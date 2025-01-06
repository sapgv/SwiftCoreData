//
//  CoreDataStack.Log.swift
//  SwiftCoreData
//
//  Created by Grigory Sapogov on 04.01.2025.
//

import CoreData

public
extension CoreDataStack {
    
    func log(state: State) {
        switch state {
        case let .failure(error):
            self.log(error: error)
        case let .success(storeDescription):
            self.log(storeDescription: storeDescription)
        }
    }
    
    func log(storeDescription: NSPersistentStoreDescription) {
        #if DEBUG
        print(storeDescription)
        #endif
    }
    
    func log(error: Error) {
        #if DEBUG
        print(error.localizedDescription)
        #endif
    }
    
}
