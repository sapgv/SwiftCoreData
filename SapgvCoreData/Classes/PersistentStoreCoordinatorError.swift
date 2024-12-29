//
//  PersistentStoreCoordinatorError.swift
//  SapgvCoreData
//
//  Created by Grigory Sapogov on 29.12.2024.
//

import Foundation

public
enum PersistentStoreCoordinatorError: Error {
    case modelNotFound
    case modelInitFailure
    case storeUrlNotFound
}
