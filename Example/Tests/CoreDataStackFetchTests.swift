//
//  CoreDataStackFetchTests.swift
//  SwiftCoreData_Tests
//
//  Created by Grigory Sapogov on 04.01.2025.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import XCTest
import SwiftCoreData
import CoreData

final class CoreDataStackFetchTests: XCTestCase {

    var sut: CoreDataStack!
    
    override func setUp() {
        super.setUp()
        self.sut = CoreDataStack.createCoreDataStackInMemory()
    }
    
    override func tearDown() {
        super.tearDown()
        self.sut = nil
    }
    
    func testFetchWhenNoPersonExist() {
        
        let array = self.sut
            .fetchRequest(CDPerson.self)
            .fetch(inContext: self.sut.viewContext)
        
        XCTAssertEqual(array.isEmpty, true)
    
    }
    
    func testFetchWhenPersonExist() {
        
        let count = 10
        
        self.createPersons(count: count, inContext: self.sut.viewContext) { error in
            XCTAssertNil(error)
        }
        
        let array = self.sut
            .fetchRequest(CDPerson.self)
            .sortDescriptor(NSSortDescriptor(keyPath: \CDPerson.age, ascending: true))
            .fetch(inContext: self.sut.viewContext)
        
        XCTAssertEqual(array.count, count)
        
        for i in 0..<count {
            XCTAssertEqual(array[i].name, "User \(i)")
            XCTAssertEqual(array[i].age, Int16(i))
        }
    
    }
    
    func testFetchWhenLimit() {
        
        let count = 10
        
        self.createPersons(count: count, inContext: self.sut.viewContext) { error in
            XCTAssertNil(error)
        }
        
        let limit = 5
        
        let array = self.sut
            .fetchRequest(CDPerson.self)
            .setupLimit(limit)
            .sortDescriptor(NSSortDescriptor(keyPath: \CDPerson.age, ascending: true))
            .fetch(inContext: self.sut.viewContext)
        
        XCTAssertEqual(array.count, limit)
        
        for i in 0..<limit {
            XCTAssertEqual(array[i].name, "User \(i)")
            XCTAssertEqual(array[i].age, Int16(i))
        }
    
    }
    
    func testFetchWhenDescending() {
        
        let count = 3
        
        self.createPersons(count: count, inContext: self.sut.viewContext) { error in
            XCTAssertNil(error)
        }
        
        let array = self.sut
            .fetchRequest(CDPerson.self)
            .sortDescriptor(NSSortDescriptor(keyPath: \CDPerson.age, ascending: false))
            .fetch(inContext: self.sut.viewContext)
        
        XCTAssertEqual(array.count, count)
        
        XCTAssertEqual(array[0].name, "User \(2)")
        XCTAssertEqual(array[0].age, Int16(2))
        
        XCTAssertEqual(array[1].name, "User \(1)")
        XCTAssertEqual(array[1].age, Int16(1))
        
        XCTAssertEqual(array[2].name, "User \(0)")
        XCTAssertEqual(array[2].age, Int16(0))
        
    }
    
    func testFetchWhenPredicate() {
        
        let count = 10
        
        self.createPersons(count: count, inContext: self.sut.viewContext) { error in
            XCTAssertNil(error)
        }
        
        let array = self.sut
            .fetchRequest(CDPerson.self)
            .predicate(NSPredicate(format: "age == %i", Int16(0)))
            .sortDescriptor(NSSortDescriptor(keyPath: \CDPerson.age, ascending: true))
            .fetch(inContext: self.sut.viewContext)
        
        XCTAssertEqual(array.count, 1)
        
        for i in 0..<array.count {
            XCTAssertEqual(array[i].name, "User \(0)")
            XCTAssertEqual(array[i].age, Int16(0))
        }
        
    }
    
    func testFetchOneWhenPredicate() {
        
        let count = 10
        
        self.createPersons(count: count, inContext: self.sut.viewContext) { error in
            XCTAssertNil(error)
        }
        
        let age = 5
        
        let person = self.sut
            .fetchRequest(CDPerson.self)
            .predicate(NSPredicate(format: "age == %i", 5))
            .fetchOne(inContext: self.sut.viewContext)
        
        XCTAssertNotNil(person)
        
        XCTAssertEqual(person?.name, "User \(age)")
        XCTAssertEqual(person?.age, Int16(age))
        
    }
    
    func testFetchCount() {
        
        let count = 10
        
        self.createPersons(count: count, inContext: self.sut.viewContext) { error in
            XCTAssertNil(error)
        }
        
        let result = self.sut
            .fetchRequestCount(CDPerson.self)
            .fetchCount(inContext: self.sut.viewContext)
        
        XCTAssertEqual(result, 10)
        
    }
    
    func testFetchCountWhenPredicate() {
        
        let count = 10
        
        self.createPersons(count: count, inContext: self.sut.viewContext) { error in
            XCTAssertNil(error)
        }
        
        let age = 5
        
        let result = self.sut
            .fetchRequestCount(CDPerson.self)
            .predicate(NSPredicate(format: "age == %i", age))
            .fetchCount(inContext: self.sut.viewContext)
        
        XCTAssertEqual(result, 1)
        
    }
    
}

extension CoreDataStackFetchTests {
    
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
