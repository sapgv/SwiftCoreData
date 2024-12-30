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
    
    func testCoreDataStackInitFailure() {
        
        let exp = self.coreDataStackInitExpectation
        
        let sut = CoreDataStack(modelName: "Model2") { error in
            
            defer {
                exp.fulfill()
            }
            
            XCTAssertEqual(error as? PersistentContainerError, PersistentContainerError.loadModelFailure)
            
        }
        
        wait(for: [exp])
        
        XCTAssertEqual(sut.modelName, "Model2")
        XCTAssertEqual(sut.container, nil)
        XCTAssertEqual(sut.persistentStoreCoordinator, nil)
        XCTAssertEqual(sut.viewContext, nil)
        XCTAssertEqual(sut.storeDescription, nil)
        
    }
    
    func testCoreDataStackInitDefault() {
        
        let exp = self.coreDataStackInitExpectation
        
        let sut = CoreDataStack(modelName: "Model") { error in
            
            defer {
                exp.fulfill()
            }
            
            XCTAssertNil(error)
            
        }
        
        wait(for: [exp])
        
        XCTAssertNotEqual(sut.container, nil)
        XCTAssertNotEqual(sut.persistentStoreCoordinator, nil)
        XCTAssertNotEqual(sut.viewContext, nil)
        XCTAssertNotEqual(sut.storeDescription, nil)
        
        XCTAssertEqual(sut.modelName, "Model")
        
        XCTAssertEqual(sut.viewContext.automaticallyMergesChangesFromParent, true)
        XCTAssertEqual(sut.viewContext.mergePolicy as! NSMergePolicy, .mergeByPropertyObjectTrump)
        
        XCTAssertEqual(sut.storeDescription?.type, PersistentStoreDescription.sqlStoreType)
        XCTAssertEqual(sut.storeDescription?.url, PersistentStoreDescription.applicationSupportStoreURL(modelName: "Model"))
        XCTAssertEqual(sut.storeDescription?.shouldAddStoreAsynchronously, false)
        XCTAssertEqual(sut.storeDescription?.shouldInferMappingModelAutomatically, true)
        XCTAssertEqual(sut.storeDescription?.shouldMigrateStoreAutomatically, true)
        
    }
    
    func testCoreDataStackInitInMemory() {
        
        let exp = self.coreDataStackInitExpectation
        
        let sut = CoreDataStack(modelName: "Model", inMemory: true) { error in
            
            defer {
                exp.fulfill()
            }
            
            XCTAssertNil(error)
            
        }
        
        wait(for: [exp])
        
        XCTAssertEqual(sut.modelName, "Model")
        
        XCTAssertEqual(sut.storeDescription?.type, PersistentStoreDescription.inMemoryStoreType)
        XCTAssertEqual(sut.storeDescription?.url, PersistentStoreDescription.inMemoryStoreURL())
        
    }
    
    func testCoreDataStackInitBundle() {
        
        let exp = self.coreDataStackInitExpectation
        
        let bundle = Bundle(for: CoreDataStackInitTests.classForCoder())
        
        let sut = CoreDataStack(modelName: "ModelTest", bundle: bundle) { error in
            
            defer {
                exp.fulfill()
            }
            
            XCTAssertNil(error)
            
        }
        
        wait(for: [exp])
        
        XCTAssertEqual(sut.modelName, "ModelTest")
        
        XCTAssertEqual(sut.storeDescription?.type, PersistentStoreDescription.sqlStoreType)
        XCTAssertEqual(sut.storeDescription?.url, PersistentStoreDescription.applicationSupportStoreURL(modelName: "ModelTest"))
        
    }
    
    func testCoreDataStackInitDifferentStoreURL() {
        
        let exp = self.coreDataStackInitExpectation
        
        let url = PersistentStoreDescription.applicationSupportStoreURL(modelName: "Custom")
        
        let storeDescription = PersistentStoreDescription(url: url)
        
        let sut = CoreDataStack(modelName: "Model", storeDescription: storeDescription) { error in
            
            defer {
                exp.fulfill()
            }
            
            XCTAssertNil(error)
            
        }
        
        wait(for: [exp])
        
        XCTAssertEqual(sut.modelName, "Model")
        
        XCTAssertEqual(sut.storeDescription?.type, PersistentStoreDescription.sqlStoreType)
        XCTAssertEqual(sut.storeDescription?.url, url)
        
    }
    
}

extension CoreDataStackInitTests {
    
    var coreDataStackInitExpectation: XCTestExpectation {
        expectation(description: "CoreDataStackInit")
    }
}
