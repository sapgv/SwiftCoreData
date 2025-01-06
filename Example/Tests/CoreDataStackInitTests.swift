//
//  CoreDataStackInitTests.swift
//  SwiftCoreData_Tests
//
//  Created by Grigory Sapogov on 29.12.2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import XCTest
import SwiftCoreData
import CoreData

final class CoreDataStackInitTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCoreDataStackInitNotCalledLoadStore() {
        
        let sut = CoreDataStack(modelName: "Model")
        
        sut.loadPersistentStoreCompletion = { result in
            XCTFail()
        }
        
        XCTAssertEqual(sut.modelName, "Model")
        XCTAssertNil(sut.state)
        
    }
    
    func testCoreDataStackInitStoreNotLoaded() {
        
        let sut = CoreDataStack(modelName: "Model2")

        sut.loadPersistentStoreCompletion = { result in
            switch result {
            case let .failure(error as PersistentContainerError):
                XCTAssertEqual(error, .initContainerFailure)
            default:
                XCTFail()
            }
        }
        
        XCTAssertEqual(sut.modelName, "Model2")
        XCTAssertEqual(sut.container, nil)
        XCTAssertEqual(sut.state?.isLoaded, false)
        
    }
    
    func testCoreDataStackInitContainer() {
        
        let sut = CoreDataStack(modelName: "Model")
        
        sut.loadPersistentStoreCompletion = { result in
            XCTAssertEqual(result.isLoaded, true)
        }
        
        XCTAssertNotEqual(sut.container, nil)
        
    }
    
    func testCoreDataStackInitViewContext() {
        
        let sut = CoreDataStack(modelName: "Model")
        
        sut.loadPersistentStoreCompletion = { result in
            XCTAssertEqual(result.isLoaded, true)
        }
        
        XCTAssertNotEqual(sut.viewContext, nil)
        
        XCTAssertEqual(sut.viewContext.automaticallyMergesChangesFromParent, true)
        XCTAssertEqual(sut.viewContext.mergePolicy as! NSMergePolicy, .mergeByPropertyObjectTrump)
        
    }
    
    func testCoreDataStackInitCoordinator() {
        
        let sut = CoreDataStack(modelName: "Model")
        
        sut.loadPersistentStoreCompletion = { result in
            XCTAssertEqual(result.isLoaded, true)
        }
        
        XCTAssertNotEqual(sut.persistentStoreCoordinator, nil)
        
    }
    
    func testCoreDataStackInitStoreDescription() {
        
        let sut = CoreDataStack(modelName: "Model")
        
        sut.loadPersistentStoreCompletion = { result in
            XCTAssertEqual(result.isLoaded, true)
        }
        
        XCTAssertNotEqual(sut.storeDescription, nil)
        
        XCTAssertEqual(sut.storeDescription?.type, PersistentStoreDescription.sqlStoreType)
        XCTAssertEqual(sut.storeDescription?.url, PersistentStoreDescription.applicationSupportStoreURL(modelName: "Model"))
        XCTAssertEqual(sut.storeDescription?.shouldAddStoreAsynchronously, false)
        XCTAssertEqual(sut.storeDescription?.shouldInferMappingModelAutomatically, true)
        XCTAssertEqual(sut.storeDescription?.shouldMigrateStoreAutomatically, true)
        
    }
    
    func testCoreDataStackInitStoreInMemoryDescription() {
        
        let sut = CoreDataStack(modelName: "Model", inMemory: true)
        
        sut.loadPersistentStoreCompletion = { result in
            XCTAssertEqual(result.isLoaded, true)
        }
        
        XCTAssertNotEqual(sut.storeDescription, nil)
        
        XCTAssertEqual(sut.inMemory, true)
        XCTAssertEqual(sut.storeDescription?.type, PersistentStoreDescription.inMemoryStoreType)
        XCTAssertEqual(sut.storeDescription?.url, PersistentStoreDescription.inMemoryStoreURL())
        XCTAssertEqual(sut.storeDescription?.shouldAddStoreAsynchronously, false)
        XCTAssertEqual(sut.storeDescription?.shouldInferMappingModelAutomatically, true)
        XCTAssertEqual(sut.storeDescription?.shouldMigrateStoreAutomatically, true)
        
    }
    
    func testCoreDataStackInitBundle() {
        
        let bundle = Bundle(for: CoreDataStackInitTests.classForCoder())
        
        let sut = CoreDataStack(modelName: "ModelTest", bundle: bundle)
        
        sut.loadPersistentStoreCompletion = { result in
            XCTAssertEqual(result.isLoaded, true)
        }
        
        XCTAssertNotEqual(sut.storeDescription, nil)
        XCTAssertEqual(sut.storeDescription?.type, PersistentStoreDescription.sqlStoreType)
        XCTAssertEqual(sut.storeDescription?.url, PersistentStoreDescription.applicationSupportStoreURL(modelName: "ModelTest"))
        
    }
    
    func testCoreDataStackInitDifferentStoreURL() {
        
        let url = PersistentStoreDescription.applicationSupportStoreURL(modelName: "Custom")
        
        let storeDescription = PersistentStoreDescription(url: url)
        
        let sut = CoreDataStack(modelName: "Model", storeDescription: storeDescription)
        
        sut.loadPersistentStoreCompletion = { result in
            XCTAssertEqual(result.isLoaded, true)
        }
        
        XCTAssertNotEqual(sut.storeDescription, nil)
        XCTAssertEqual(sut.storeDescription?.type, PersistentStoreDescription.sqlStoreType)
        XCTAssertEqual(sut.storeDescription?.url, url)
        
    }
    
}

