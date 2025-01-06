//
//  PersistentContainer.Error.swift
//  SwiftCoreData
//
//  Created by Grigory Sapogov on 30.12.2024.
//

import Foundation

public extension PersistentContainer {

    enum Error: Swift.Error {
        case initContainerFailure
        case invalidManagedObjectModelURL
        case managedObjectModelNotFound
    }

}
