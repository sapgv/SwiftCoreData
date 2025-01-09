//
//  Limitable.swift
//  SwiftCoreData
//
//  Created by Grigory Sapogov on 09.01.2025.
//

import Foundation
import CoreData

public protocol Limitable: AnyObject {
    
    associatedtype Result: NSFetchRequestResult
    
    var request: NSFetchRequest<Result> { get }
    
    func setupLimit(_ fetchLimit: Int) -> Self
    
}

public extension Limitable {
    
    func setupLimit(_ fetchLimit: Int) -> Self {
        self.request.fetchLimit = fetchLimit
        return self
    }
    
}

extension FetchRequest: Limitable {}

extension FetchRequestID: Limitable {}

extension FetchRequestDictionary: Limitable {}

