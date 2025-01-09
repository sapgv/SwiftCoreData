//
//  DeletableTests.swift
//  SwiftCoreData_Tests
//
//  Created by Grigory Sapogov on 09.01.2025.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import XCTest
import SwiftCoreData
import CoreData

final class DeletableTests: XCTestCase {

    var sut: CoreDataStack!
    
    override func setUp() {
        super.setUp()
        self.sut = CoreDataStack.createCoreDataStackInMemory()
    }
    
    override func tearDown() {
        super.tearDown()
        self.sut = nil
    }
    
    func testDeletePersonsWhenNotExistedBefore() {
        
        let arrayBefore = self.sut
            .fetchRequest(CDPerson.self)
            .fetch(inContext: self.sut.viewContext)
        
        XCTAssertEqual(arrayBefore.isEmpty, true)
        
        let exp = expectation(description: "Delete persons")
        
        self.sut.deleteRequest(CDPerson.self)
            .delete(inContext: self.sut.viewContext) { error in
                defer { exp.fulfill() }
                XCTAssertNil(error)
            }

        wait(for: [exp])
        
        let arrayAfter = self.sut
            .fetchRequest(CDPerson.self)
            .fetch(inContext: self.sut.viewContext)
        
        XCTAssertEqual(arrayAfter.isEmpty, true)
        
    }
    
    func testDeletePersonsWhenExistedBefore() {
        
        let count = 10
        
        self.createPersons(count: count, inContext: self.sut.viewContext) { error in
            XCTAssertNil(error)
        }
        
        let arrayBefore = self.sut
            .fetchRequest(CDPerson.self)
            .fetch(inContext: self.sut.viewContext)
        
        XCTAssertEqual(arrayBefore.count, count)
        
        let exp = expectation(description: "Delete persons")
        
        self.sut.deleteRequest(CDPerson.self)
            .delete(inContext: self.sut.viewContext) { error in
                defer { exp.fulfill() }
                XCTAssertNil(error)
            }

        wait(for: [exp])
        
        let arrayAfter = self.sut
            .fetchRequest(CDPerson.self)
            .fetch(inContext: self.sut.viewContext)
        
        XCTAssertEqual(arrayAfter.isEmpty, true)
        
    }
    
    func testDeletePersonsWhenPredicate() {
        
        let count = 10
        
        self.createPersons(count: count, inContext: self.sut.viewContext) { error in
            XCTAssertNil(error)
        }
        
        let arrayBefore = self.sut
            .fetchRequest(CDPerson.self)
            .fetch(inContext: self.sut.viewContext)
        
        XCTAssertEqual(arrayBefore.count, count)
        
        let exp = expectation(description: "Delete persons")
        
        self.sut.deleteRequest(CDPerson.self)
            .predicate(NSPredicate(format: "age == %i", Int16(0)))
            .delete(inContext: self.sut.viewContext) { error in
                defer { exp.fulfill() }
                XCTAssertNil(error)
            }

        wait(for: [exp])
        
        let arrayAfter = self.sut
            .fetchRequest(CDPerson.self)
            .fetch(inContext: self.sut.viewContext)
        
        let countAfter = count - 1
        
        XCTAssertEqual(arrayAfter.count, countAfter)
        
    }

}

extension DeletableTests {
    
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
    
}
