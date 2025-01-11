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
    
    let usernameBefore = "User"
    
    override func setUp() {
        super.setUp()
        self.sut = CoreDataStack.createCoreDataStack()
        self.sut.deleteRequest(CDPersonTest.self).delete(inContext: self.sut.viewContext, completion: { _ in })
        self.createPerson()
    }
    
    override func tearDown() {
        super.tearDown()
        self.sut = nil
    }
    
    func testBatchDeleteWhenNoMerge() {
        
        let privateContext = self.sut.createBackgroundContext()
        
        let viewContext = self.sut.createContext(concurrencyType: .mainQueueConcurrencyType)
        
        let person = self.sut.fetchRequest(CDPersonTest.self)
            .predicate(NSPredicate(format: "name == %@", usernameBefore))
            .fetchOne(inContext: viewContext)
        
        XCTAssertEqual(person?.name, usernameBefore)
        
        let exp = expectation(description: "Delete")
        
        self.sut.batchDeleteRequest(CDPersonTest.self)
            .predicate(NSPredicate(format: "name == %@", usernameBefore))
            .delete(inContext: privateContext) { error in
                defer { exp.fulfill() }
                XCTAssertNil(error)
            }

        wait(for: [exp])
        
        XCTAssertEqual(person?.isDeleted, false)
        
    }
    
    func testBatchDeleteWhenMerge() {
        
        let privateContext = self.sut.createBackgroundContext()
        
        let viewContext = self.sut.createContext(concurrencyType: .mainQueueConcurrencyType)
        
        let person = self.sut.fetchRequest(CDPersonTest.self)
            .predicate(NSPredicate(format: "name == %@", usernameBefore))
            .fetchOne(inContext: viewContext)
        
        XCTAssertEqual(person?.name, usernameBefore)
        
        let exp = expectation(description: "Delete")
        
        self.sut.batchDeleteRequest(CDPersonTest.self)
            .predicate(NSPredicate(format: "name == %@", usernameBefore))
            .merge(into: [viewContext])
            .delete(inContext: privateContext) { error in
                defer { exp.fulfill() }
                XCTAssertNil(error)
            }

        wait(for: [exp])
        
        XCTAssertEqual(person?.isDeleted, true)
        
    }
    
}

extension BatchDeletableTests {
    
    func createPerson() {
        
        let person = CDPersonTest(context: self.sut.viewContext)
        person.name = usernameBefore
        person.age = 10
        
        self.sut.save(inContext: self.sut.viewContext) { _ in }
        
    }
    
}
