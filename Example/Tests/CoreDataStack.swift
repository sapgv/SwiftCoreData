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
    
    static func createSUT(inMemory: Bool = true) -> CoreDataStack {
        CoreDataStack(modelName: "ModelTest", bundle: createBundle())
    }
    
    static func createBundle() -> Bundle {
        Bundle.init(for: Common.classForCoder())
    }
    
}
