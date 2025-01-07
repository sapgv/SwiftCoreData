//
//  FetchableCount.swift
//  SwiftCoreData
//
//  Created by Grigory Sapogov on 07.01.2025.
//

import Foundation
import CoreData

//public protocol FetchableCount: AnyObject {
//    
//    func fetchCount(inContext context: NSManagedObjectContext) -> Int
//    
//}

extension FetchRequest where Result == NSNumber {
    
    public func fetchCount(inContext context: NSManagedObjectContext) -> Int {
        
        do {
            let result = try context.count(for: self.request)
            return result
        }
        catch {
            return 0
        }
        
    }
    
}
