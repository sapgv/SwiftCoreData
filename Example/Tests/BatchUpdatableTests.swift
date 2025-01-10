//
//  BatchUpdatableTests.swift
//  SwiftCoreData_Tests
//
//  Created by Grigory Sapogov on 10.01.2025.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import XCTest
import SwiftCoreData
import CoreData

final class BatchUpdatableTests: XCTestCase {

    var sut: CoreDataStack!
    
    let usernameBefore = "User"
    
    let usernameAfter = "John Doe"
    
    override func setUp() {
        super.setUp()
        self.sut = CoreDataStack.createCoreDataStack()
        self.sut.deleteRequest(CDPerson.self).delete(inContext: self.sut.viewContext, completion: { _ in })
        self.createPerson()
    }
    
    override func tearDown() {
        super.tearDown()
        self.sut = nil
    }
    
    func testBatchUpdateWhenNoMerge() {
        
        let privateContext = self.sut.createBackgroundContext()
        
        let viewContext = self.sut.createContext(concurrencyType: .mainQueueConcurrencyType)
        
        let person = self.sut.fetchRequest(CDPerson.self)
            .predicate(NSPredicate(format: "name == %@", usernameBefore))
            .fetchOne(inContext: viewContext)
        
        XCTAssertEqual(person?.name, usernameBefore)
        
        let exp = expectation(description: "Update")
        
        let usernameAfter = "John Doe"
        
        self.sut.batchUpdateRequest(CDPerson.self)
            .predicate(NSPredicate(format: "name == %@", usernameBefore))
            .propertiesToUpdate(["name": usernameAfter])
            .update(inContext: privateContext) { error in
                defer { exp.fulfill() }
                XCTAssertNil(error)
            }

        wait(for: [exp])
        
        XCTAssertEqual(person?.name, usernameBefore)
        
    }
    
    func testBatchUpdateWhenMerge() {
        
        let privateContext = self.sut.createBackgroundContext()
        
        let viewContext = self.sut.createContext(concurrencyType: .mainQueueConcurrencyType)
        
        let person = self.sut.fetchRequest(CDPerson.self)
            .predicate(NSPredicate(format: "name == %@", usernameBefore))
            .fetchOne(inContext: viewContext)
        
        XCTAssertEqual(person?.name, usernameBefore)
        
        let exp = expectation(description: "Update")
        
        let usernameAfter = "John Doe"
        
        self.sut.batchUpdateRequest(CDPerson.self)
            .predicate(NSPredicate(format: "name == %@", usernameBefore))
            .propertiesToUpdate(["name": usernameAfter])
            .merge(into: [viewContext])
            .update(inContext: privateContext) { error in
                defer { exp.fulfill() }
                XCTAssertNil(error)
            }

        wait(for: [exp])
        
        XCTAssertEqual(person?.name, usernameAfter)
        
    }
    
}

extension BatchUpdatableTests {
    
    func createPerson() {
        
        let person = CDPerson(context: self.sut.viewContext)
        person.name = usernameBefore
        person.age = 10
        
        self.sut.save(inContext: self.sut.viewContext) { _ in }
        
    }
    
}

