//
//  CoreDataStackTests.swift
//  SapgvCoreData_Tests
//
//  Created by Grigory Sapogov on 29.12.2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import XCTest
import SapgvCoreData
import CoreData

final class CoreDataStackTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCoreDataStackInitModelNotFound() {
        
        do {
            let sut = try CoreDataStack(modelName: "Model2")
            XCTFail()
        }
        catch {
            XCTAssertEqual(error.localizedDescription, PersistentStoreCoordinatorError.modelNotFound.localizedDescription)
        }
        
    }
    
    func testCoreDataStackInitDefault() {
        
        do {
            let sut = try CoreDataStack(modelName: "Model")
            
            XCTAssertEqual(sut.modelName, "Model")
            XCTAssertEqual(sut.automaticallyMergesChangesFromParent, true)
            
            XCTAssertEqual(sut.viewContext.persistentStoreCoordinator, sut.persistentStoreCoordinator)
            XCTAssertEqual(sut.viewContext.concurrencyType, NSManagedObjectContextConcurrencyType.mainQueueConcurrencyType)
            XCTAssertEqual(sut.viewContext.automaticallyMergesChangesFromParent, true)
            
            XCTAssertTrue(sut.stores.isEmpty)
        }
        catch {
            XCTFail()
        }
        
    }
    
    func testCoreDataStackLoadSQLStore() {
        
        do {
            let sut = try CoreDataStack(modelName: "Model")
                .loadStore(filename: "Model")
                .loadStore(filename: "Model")
            
            XCTAssertEqual(sut.stores.count, 1)
            XCTAssertEqual(sut.stores.first?.value.storeType, .sqlite)
            XCTAssertEqual(sut.stores.first?.value.storeURL, SQLStore.defaultFileURL(filename: "Model"))
            
        }
        catch {
            XCTFail()
        }
        
    }
    
}
