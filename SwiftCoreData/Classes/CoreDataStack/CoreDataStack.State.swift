//
//  CoreDataStack.State.swift
//  SwiftCoreData
//
//  Created by Grigory Sapogov on 06.01.2025.
//

import CoreData

public
extension CoreDataStack {
    
    enum State {
        case success(NSPersistentStoreDescription)
        case failure(Error)
        
        public var isLoaded: Bool {
            switch self {
            case .success:
                return true
            default:
                return false
            }
            
        }
        
    }
    
}
