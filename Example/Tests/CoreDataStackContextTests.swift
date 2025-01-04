//
//  CoreDataStackContextTests.swift
//  SwiftCoreData_Tests
//
//  Created by Grigory Sapogov on 31.12.2024.
//  Copyright © 2024 CocoaPods. All rights reserved.
//

import XCTest
import SwiftCoreData
import CoreData

final class CoreDataStackContextTests: XCTestCase {

    var sut: CoreDataStack!
    
    override func setUp() {
        super.setUp()
        self.sut = CoreDataStack(modelName: "Model")
    }
    
    override func tearDown() {
        super.tearDown()
        self.sut = nil
    }
    
    func testNewBackgroundContext() {
        
        let privateContext = self.sut.createBackgroundContext(contextSettings: .default)
        XCTAssertEqual(privateContext.concurrencyType, .privateQueueConcurrencyType)
        XCTAssertEqual(privateContext.automaticallyMergesChangesFromParent, true)
        XCTAssertEqual(privateContext.mergePolicy as! NSMergePolicy, NSMergePolicy.mergeByPropertyObjectTrump)
        
    }
    
    func testNewBackgroundTask() {
        
        let exp = expectation(description: "NewBackgroundTask")
        
        self.sut.performBackgroundTask { privateContext in
            
            defer {
                exp.fulfill()
            }
            
            XCTAssertEqual(privateContext.concurrencyType, .privateQueueConcurrencyType)
            XCTAssertEqual(privateContext.automaticallyMergesChangesFromParent, true)
            XCTAssertEqual(privateContext.mergePolicy as! NSMergePolicy, NSMergePolicy.mergeByPropertyObjectTrump)
            
        }
        
        wait(for: [exp])
        
    }
    
    func testNewContextFormCoordinator() {
        
        let privateContext = self.sut.createContext(concurrencyType: .privateQueueConcurrencyType)
        
        XCTAssertEqual(privateContext.concurrencyType, .privateQueueConcurrencyType)
        XCTAssertEqual(privateContext.automaticallyMergesChangesFromParent, true)
        XCTAssertEqual(privateContext.mergePolicy as! NSMergePolicy, NSMergePolicy.mergeByPropertyObjectTrump)
        XCTAssertEqual(privateContext.persistentStoreCoordinator, sut.persistentStoreCoordinator)
        XCTAssertEqual(privateContext.parent, nil)
        
    }
    
    func testChildContext() {
        
        let viewContext = self.sut.createChildContext(concurrencyType: .mainQueueConcurrencyType, fromContext: self.sut.viewContext)
        
        XCTAssertEqual(viewContext.concurrencyType, .mainQueueConcurrencyType)
        XCTAssertEqual(viewContext.automaticallyMergesChangesFromParent, true)
        XCTAssertEqual(viewContext.mergePolicy as! NSMergePolicy, NSMergePolicy.mergeByPropertyObjectTrump)
        XCTAssertEqual(viewContext.persistentStoreCoordinator, self.sut.persistentStoreCoordinator)
        XCTAssertEqual(viewContext.parent, self.sut.viewContext)
        
    }

}
