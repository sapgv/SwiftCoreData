//
//  CoreDataStack.swift
//  SwiftCoreData_Tests
//
//  Created by Grigory Sapogov on 04.01.2025.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import Foundation
import SwiftCoreData

extension CoreDataStack {
    
//    static let coreDataStackInMemory = CoreDataStack(modelName: "ModelTest", bundle: createBundle(), inMemory: true)
    
    static func createCoreDataStack() -> CoreDataStack {
        CoreDataStack(modelName: "ModelTest", bundle: createBundle())
    }
    
    static func createCoreDataStackInMemory() -> CoreDataStack {
        CoreDataStack(modelName: "ModelTest", bundle: createBundle(), inMemory: true)
    }
    
    static func createBundle() -> Bundle {
        Bundle.init(for: Common.classForCoder())
    }
    
}
