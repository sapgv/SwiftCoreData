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
        
        sut.loadPersistentStoreCompletion = { result in
            XCTFail()
        }
        
    }
    
    func testCoreDataStackInitDefault() {
        
        let sut = CoreDataStack(modelName: "Model")
        
        XCTAssertEqual(sut.modelName, "Model")
        XCTAssertEqual(sut.isStoreLoaded, false)
        
        sut.loadPersistentStoreCompletion = { result in
            XCTFail()
        }
        
    }
    
    func testCoreDataStackInitContainer() {
        
        let sut = CoreDataStack(modelName: "Model")
        
        XCTAssertNotEqual(sut.container, nil)
        
        XCTAssertEqual(sut.modelName, "Model")
        XCTAssertEqual(sut.isStoreLoaded, true)
        
    }
    
    func testCoreDataStackInitViewContext() {
        
        let sut = CoreDataStack(modelName: "Model")
        
        XCTAssertNotEqual(sut.viewContext, nil)
        
        XCTAssertEqual(sut.modelName, "Model")
        XCTAssertEqual(sut.isStoreLoaded, true)
        XCTAssertEqual(sut.viewContext.automaticallyMergesChangesFromParent, true)
        XCTAssertEqual(sut.viewContext.mergePolicy as! NSMergePolicy, .mergeByPropertyObjectTrump)
        
    }
    
    func testCoreDataStackInitCoordinator() {
        
        let sut = CoreDataStack(modelName: "Model")
        
        XCTAssertNotEqual(sut.persistentStoreCoordinator, nil)
        
        XCTAssertEqual(sut.modelName, "Model")
        XCTAssertEqual(sut.isStoreLoaded, true)
        
    }
    
    func testCoreDataStackInitStoreDescription() {
        
        let sut = CoreDataStack(modelName: "Model")
        
        XCTAssertNotEqual(sut.storeDescription, nil)
        
        XCTAssertEqual(sut.modelName, "Model")
        XCTAssertEqual(sut.isStoreLoaded, true)
        
        XCTAssertEqual(sut.storeDescription?.type, PersistentStoreDescription.sqlStoreType)
        XCTAssertEqual(sut.storeDescription?.url, PersistentStoreDescription.applicationSupportStoreURL(modelName: "Model"))
        XCTAssertEqual(sut.storeDescription?.shouldAddStoreAsynchronously, false)
        XCTAssertEqual(sut.storeDescription?.shouldInferMappingModelAutomatically, true)
        XCTAssertEqual(sut.storeDescription?.shouldMigrateStoreAutomatically, true)
        
        sut.loadPersistentStoreCompletion = { result in
            
            switch result {
            case .failure:
                XCTFail()
            default:
                break
            }
        }
        
    }
    
    func testCoreDataStackInitStoreInMemoryDescription() {
        
        let sut = CoreDataStack(modelName: "Model", inMemory: true)
        
        XCTAssertNotEqual(sut.storeDescription, nil)
        
        XCTAssertEqual(sut.modelName, "Model")
        XCTAssertEqual(sut.isStoreLoaded, true)
        
        XCTAssertEqual(sut.storeDescription?.type, PersistentStoreDescription.inMemoryStoreType)
        XCTAssertEqual(sut.storeDescription?.url, PersistentStoreDescription.inMemoryStoreURL())
        XCTAssertEqual(sut.storeDescription?.shouldAddStoreAsynchronously, false)
        XCTAssertEqual(sut.storeDescription?.shouldInferMappingModelAutomatically, true)
        XCTAssertEqual(sut.storeDescription?.shouldMigrateStoreAutomatically, true)
        
        sut.loadPersistentStoreCompletion = { result in
            
            switch result {
            case .failure:
                XCTFail()
            default:
                break
            }
        }
        
    }
    
    func testCoreDataStackInitBundle() {
        
        let bundle = Bundle(for: CoreDataStackInitTests.classForCoder())
        
        let sut = CoreDataStack(modelName: "ModelTest", bundle: bundle)
        
        XCTAssertNotEqual(sut.storeDescription, nil)
        
        XCTAssertEqual(sut.modelName, "ModelTest")
        XCTAssertEqual(sut.isStoreLoaded, true)
        
        XCTAssertEqual(sut.storeDescription?.type, PersistentStoreDescription.sqlStoreType)
        XCTAssertEqual(sut.storeDescription?.url, PersistentStoreDescription.applicationSupportStoreURL(modelName: "ModelTest"))
        
        sut.loadPersistentStoreCompletion = { result in
            
            switch result {
            case .failure:
                XCTFail()
            default:
                break
            }
        }
        
    }
    
    func testCoreDataStackInitDifferentStoreURL() {
        
        let url = PersistentStoreDescription.applicationSupportStoreURL(modelName: "Custom")
        
        let storeDescription = PersistentStoreDescription(url: url)
        
        let sut = CoreDataStack(modelName: "Model", storeDescription: storeDescription)
        
        XCTAssertNotEqual(sut.storeDescription, nil)
        XCTAssertEqual(sut.modelName, "Model")
        XCTAssertEqual(sut.isStoreLoaded, true)
        
        XCTAssertEqual(sut.storeDescription?.type, PersistentStoreDescription.sqlStoreType)
        XCTAssertEqual(sut.storeDescription?.url, url)
        
        sut.loadPersistentStoreCompletion = { result in
            
            switch result {
            case .failure:
                XCTFail()
            default:
                break
            }
        }
        
    }
    
}

extension CoreDataStackInitTests {
    
    var coreDataStackInitExpectation: XCTestExpectation {
        expectation(description: "CoreDataStackInit")
    }
}
