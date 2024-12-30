//
//  PersistentContainerError.swift
//  SapgvCoreData
//
//  Created by Grigory Sapogov on 30.12.2024.
//

import Foundation

public enum PersistentContainerError: Error {
    
    case loadModelFailure
    case invalidManagedObjectModelURL
    case managedObjectModelNotFound
}
