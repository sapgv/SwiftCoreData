//
//  PredicatableTests.swift
//  SwiftCoreData_Tests
//
//  Created by Grigory Sapogov on 09.01.2025.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import XCTest
import SwiftCoreData
import CoreData

final class PredicatableTests: XCTestCase {

    var sut: CoreDataStack!
    
    override func setUp() {
        super.setUp()
        self.sut = CoreDataStack.createCoreDataStackInMemory()
    }
    
    override func tearDown() {
        super.tearDown()
        self.sut = nil
    }

    func testFetchPersonsWhenNoPredicate() {
        
        let count = 10
        
        self.createPersons(count: count, inContext: self.sut.viewContext) { error in
            XCTAssertNil(error)
        }
        
        let array = self.sut
            .fetchRequest(CDPersonTest.self)
            .fetch(inContext: self.sut.viewContext)
        
        XCTAssertEqual(array.count, count)
        
    }
    
    func testFetchPersonsWhenPredicate() {
        
        let count = 10
        
        self.createPersons(count: count, inContext: self.sut.viewContext) { error in
            XCTAssertNil(error)
        }
        
        let array = self.sut
            .fetchRequest(CDPersonTest.self)
            .predicate(NSPredicate(format: "age == %i", Int16(0)))
            .fetch(inContext: self.sut.viewContext)
        
        XCTAssertEqual(array.count, 1)
        
    }
    
    func testFetchPersonWhenPredicate() {
        
        let count = 10
        
        self.createPersons(count: count, inContext: self.sut.viewContext) { error in
            XCTAssertNil(error)
        }
        
        let person = self.sut
            .fetchRequest(CDPersonTest.self)
            .predicate(NSPredicate(format: "age == %i", Int16(0)))
            .fetchOne(inContext: self.sut.viewContext)
        
        XCTAssertNotNil(person)
        
        XCTAssertEqual(person?.name, "User \(0)")
        XCTAssertEqual(person?.age, Int16(0))
        
    }
    
    func testFetchPersonWhenResetPredicate() {
        
        let count = 10
        
        self.createPersons(count: count, inContext: self.sut.viewContext) { error in
            XCTAssertNil(error)
        }
        
        let array = self.sut
            .fetchRequest(CDPersonTest.self)
            .predicate(NSPredicate(format: "age == %i", Int16(0)))
            .predicate(nil)
            .fetch(inContext: self.sut.viewContext)
        
        XCTAssertEqual(array.count, count)
        
    }
    
    func testFetchPersonWhenMultiplePredicate() {
        
        let count = 10
        
        self.createPersons(count: count, inContext: self.sut.viewContext) { error in
            XCTAssertNil(error)
        }
        
        let array = self.sut
            .fetchRequest(CDPersonTest.self)
            .predicate(NSPredicate(format: "name CONTAINS[cd] %@", "us"))
            .predicate(NSPredicate(format: "name CONTAINS[cd] %@", "er"))
            .fetch(inContext: self.sut.viewContext)
        
        XCTAssertEqual(array.count, count)
        
    }
    
    func testFetchPersonWhenPredicates() {
        
        let count = 10
        
        self.createPersons(count: count, inContext: self.sut.viewContext) { error in
            XCTAssertNil(error)
        }
        
        let predicates = [
            NSPredicate(format: "name CONTAINS[cd] %@", "er")
        ]
        
        let array = self.sut
            .fetchRequest(CDPersonTest.self)
            .predicate(NSPredicate(format: "name CONTAINS[cd] %@", "us"))
            .predicates(predicates)
            .fetch(inContext: self.sut.viewContext)
        
        XCTAssertEqual(array.count, count)
        
    }
    
}

extension PredicatableTests {
    
    func createPersons(count: Int = 10, inContext context: NSManagedObjectContext, completion: (Error?) -> Void) {
        
        for i in 0..<count {
            let cdPerson = CDPersonTest(context: context)
            cdPerson.name = "User \(i)"
            cdPerson.age = Int16(i)
        }
        
        self.sut.save(inContext: context) { result in
            
            completion(result.error)
            
        }
        
    }
    
}
