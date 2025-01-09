//
//  Batchable.swift
//  SwiftCoreData
//
//  Created by Grigory Sapogov on 09.01.2025.
//

import Foundation
import CoreData

public protocol Batchable: AnyObject {
    
    associatedtype Result: NSFetchRequestResult
    
    var request: NSFetchRequest<Result> { get }
    
    func setupBatchSize(_ fetchBatchSize: Int) -> Self
    
}

public extension Batchable {
    
    func setupBatchSize(_ fetchBatchSize: Int) -> Self {
        self.request.fetchBatchSize = fetchBatchSize
        return self
    }
    
}

extension FetchRequest: Batchable {}

extension FetchRequestID: Batchable {}

extension FetchRequestDictionary: Batchable {}

