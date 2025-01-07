//
//  FetchRequestResult.swift
//  SwiftCoreData
//
//  Created by Grigory Sapogov on 07.01.2025.
//

import Foundation
import CoreData

public
extension NSFetchRequestResult {
    
    static var resultType: NSFetchRequestResultType {
        switch Self.self {
        case is NSManagedObject.Type:
            return .managedObjectResultType
        case is NSDictionary.Type:
            return .dictionaryResultType
        case is NSNumber.Type:
            return .countResultType
        case is NSManagedObjectID.Type:
            return .managedObjectIDResultType
        default:
            return .managedObjectResultType
        }
        
    }
    
}
