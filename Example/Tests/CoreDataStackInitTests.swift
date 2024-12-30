//
//  CoreDataStackInitTests.swift
//  SapgvCoreData_Tests
//
//  Created by Grigory Sapogov on 29.12.2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import XCTest
import SapgvCoreData
import CoreData

final class CoreDataStackInitTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCoreDataStackInitStoreNotLoaded() {
        
        let sut = CoreDataStack(modelName: "Model2")

        XCTAssertEqual(sut.modelName, "Model2")
        XCTAssertEqual(sut.isStoreLoaded, false)
        
    }
    
    func testCoreDataStackInitFailure() {
        
        let sut = CoreDataStack(modelName: "Model2")

        XCTAssertEqual(sut.modelName, "Model2")
        XCTAssertEqual(sut.isStoreLoaded, false)
        XCTAssertEqual(sut.container, nil)
        XCTAssertEqual(sut.persistentStoreCoordinator, nil)
        XCTAssertEqual(sut.viewContext, nil)
        XCTAssertEqual(sut.storeDescription, nil)
        
    }
    
    func testCoreDataStackInitDefault() {
        
        let sut = CoreDataStack(modelName: "Model")
        
        XCTAssertNotEqual(sut.container, nil)
        XCTAssertNotEqual(sut.persistentStoreCoordinator, nil)
        XCTAssertNotEqual(sut.viewContext, nil)
        XCTAssertNotEqual(sut.storeDescription, nil)
        
        XCTAssertEqual(sut.modelName, "Model")
        XCTAssertEqual(sut.isStoreLoaded, true)
        
        XCTAssertEqual(sut.viewContext.automaticallyMergesChangesFromParent, true)
        XCTAssertEqual(sut.viewContext.mergePolicy as! NSMergePolicy, .mergeByPropertyObjectTrump)
        
        XCTAssertEqual(sut.storeDescription?.type, PersistentStoreDescription.sqlStoreType)
        XCTAssertEqual(sut.storeDescription?.url, PersistentStoreDescription.applicationSupportStoreURL(modelName: "Model"))
        XCTAssertEqual(sut.storeDescription?.shouldAddStoreAsynchronously, false)
        XCTAssertEqual(sut.storeDescription?.shouldInferMappingModelAutomatically, true)
        XCTAssertEqual(sut.storeDescription?.shouldMigrateStoreAutomatically, true)
        
    }
    
    func testCoreDataStackInitInMemory() {
        
        let sut = CoreDataStack(modelName: "Model", inMemory: true)
        
        XCTAssertEqual(sut.storeDescription?.type, PersistentStoreDescription.inMemoryStoreType)
        XCTAssertEqual(sut.storeDescription?.url, PersistentStoreDescription.inMemoryStoreURL())
        
        XCTAssertEqual(sut.modelName, "Model")
        XCTAssertEqual(sut.isStoreLoaded, true)
        
    }
    
    func testCoreDataStackInitBundle() {
        
        let bundle = Bundle(for: CoreDataStackInitTests.classForCoder())
        
        let sut = CoreDataStack(modelName: "ModelTest", bundle: bundle)
        
        XCTAssertEqual(sut.storeDescription?.type, PersistentStoreDescription.sqlStoreType)
        XCTAssertEqual(sut.storeDescription?.url, PersistentStoreDescription.applicationSupportStoreURL(modelName: "ModelTest"))
        
        XCTAssertEqual(sut.modelName, "ModelTest")
        XCTAssertEqual(sut.isStoreLoaded, true)
        
    }
    
    func testCoreDataStackInitDifferentStoreURL() {
        
        let url = PersistentStoreDescription.applicationSupportStoreURL(modelName: "Custom")
        
        let storeDescription = PersistentStoreDescription(url: url)
        
        let sut = CoreDataStack(modelName: "Model", storeDescription: storeDescription)
        
        XCTAssertEqual(sut.storeDescription?.type, PersistentStoreDescription.sqlStoreType)
        XCTAssertEqual(sut.storeDescription?.url, url)
        
        XCTAssertEqual(sut.modelName, "Model")
        XCTAssertEqual(sut.isStoreLoaded, true)
        
    }
    
}

extension CoreDataStackInitTests {
    
    var coreDataStackInitExpectation: XCTestExpectation {
        expectation(description: "CoreDataStackInit")
    }
}
