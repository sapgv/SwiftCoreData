//
//  CoreDataStack.SaveResult.swift
//  SwiftCoreData
//
//  Created by Grigory Sapogov on 04.01.2025.
//

import CoreData

public
enum SaveResult {
    
    case success
    case failure(Error)
    
}

public
extension SaveResult {
    
    var error: Error? {
        switch self {
        case let .failure(error):
            return error
        default:
            return nil
        }
    }
    
}
