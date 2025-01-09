//
//  BatchDeletableTests.swift
//  SwiftCoreData_Tests
//
//  Created by Grigory Sapogov on 09.01.2025.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import XCTest
import SwiftCoreData
import CoreData

final class BatchDeletableTests: XCTestCase {

    var sut: CoreDataStack!
    
    override func setUp() {
        super.setUp()
        self.sut = CoreDataStack.createCoreDataStack()
        self.sut.deleteRequest(CDPerson.self).delete(inContext: self.sut.viewContext, completion: { _ in })
    }
    
    override func tearDown() {
        super.tearDown()
        self.sut = nil
    }
    
    func testBatchDeleteWhenNoMerge() {
        
        let privateContext = self.sut.createBackgroundContext()
        
        let viewContext = self.sut.createContext(concurrencyType: .mainQueueConcurrencyType)
        
        let count = 10
        
        self.createPersons(count: count, inContext: privateContext) { error in
            XCTAssertNil(error)
        }

        let arrayBefore = self.sut
            .fetchRequest(CDPerson.self)
            .returnsObjectsAsFaults(false)
            .fetch(inContext: viewContext)
        
        XCTAssertEqual(arrayBefore.count, count)
        
        let exp = expectation(description: "Clean persons")
        
        self.sut.batchDeleteRequest(CDPerson.self)
            .predicate(NSPredicate(format: "age == %i", Int16(0)))
            .clean(inContext: privateContext) { error in
                defer { exp.fulfill() }
                XCTAssertNil(error)
            }

        wait(for: [exp])
        
        let arrayDeleted = arrayBefore.filter({ $0.isDeleted })
        
        XCTAssertEqual(arrayDeleted.count, 0)
        
    }
    
    func testBatchDeleteWhenMerge() {
        
        let privateContext = self.sut.createBackgroundContext()
        
        let viewContext = self.sut.createContext(concurrencyType: .mainQueueConcurrencyType)
        
        let count = 10
        
        self.createPersons(count: count, inContext: privateContext) { error in
            XCTAssertNil(error)
        }

        let arrayBefore = self.sut
            .fetchRequest(CDPerson.self)
            .returnsObjectsAsFaults(false)
            .fetch(inContext: viewContext)
        
        XCTAssertEqual(arrayBefore.count, count)
        
        let exp = expectation(description: "Clean persons")
        
        self.sut.batchDeleteRequest(CDPerson.self)
            .predicate(NSPredicate(format: "age == %i", Int16(0)))
            .merge(into: [viewContext])
            .clean(inContext: privateContext) { error in
                defer { exp.fulfill() }
                XCTAssertNil(error)
            }

        wait(for: [exp])
        
        let arrayDeleted = arrayBefore.filter({ $0.isDeleted })
        
        XCTAssertEqual(arrayDeleted.count, 1)
        
    }
    
}

extension BatchDeletableTests {
    
    func createPersons(count: Int = 10, inContext context: NSManagedObjectContext, completion: (Error?) -> Void) {
        
        for i in 0..<count {
            let cdPerson = CDPerson(context: context)
            cdPerson.name = "User \(i)"
            cdPerson.age = Int16(i)
        }
        
        self.sut.save(inContext: context) { result in
            
            completion(result.error)
            
        }
        
    }
    
    func createPersonsWithoutSave(count: Int = 10, inContext context: NSManagedObjectContext, completion: (Error?) -> Void) {
        
        for i in 0..<count {
            let cdPerson = CDPerson(context: context)
            cdPerson.name = "User \(i)"
            cdPerson.age = Int16(i)
        }
        
    }
    
}
