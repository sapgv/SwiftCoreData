//
//  SortableTests.swift
//  SwiftCoreData_Tests
//
//  Created by Grigory Sapogov on 09.01.2025.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import XCTest
import SwiftCoreData
import CoreData

final class SortableTests: XCTestCase {

    var sut: CoreDataStack!
    
    override func setUp() {
        super.setUp()
        self.sut = CoreDataStack.createCoreDataStackInMemory()
    }
    
    override func tearDown() {
        super.tearDown()
        self.sut = nil
    }
    
    func testFetchPersonsWhenNoSorting() {
        
        let count = 5
        
        self.createPersons(count: count, inContext: self.sut.viewContext) { error in
            XCTAssertNil(error)
        }
        
        let array = self.sut
            .fetchRequest(CDPerson.self)
            .fetch(inContext: self.sut.viewContext)
            .compactMap { Int($0.age) }
        
        XCTAssertEqual(array.count, count)
        XCTAssertNotEqual(array, [1, 2, 3, 4, 5])
        XCTAssertNotEqual(array, [5, 4, 3, 2, 1])
        
    }
    
    func testFetchPersonsWhenSortingAscending() {
        
        let count = 5
        
        self.createPersons(count: count, inContext: self.sut.viewContext) { error in
            XCTAssertNil(error)
        }
        
        let array = self.sut
            .fetchRequest(CDPerson.self)
            .sortDescriptor(NSSortDescriptor(keyPath: \CDPerson.age, ascending: true))
            .fetch(inContext: self.sut.viewContext)
            .compactMap { Int($0.age) }
        
        XCTAssertEqual(array.count, count)
        XCTAssertNotEqual(array, [1, 2, 3, 4, 5])
        
    }
    
    func testFetchPersonsWhenSortingDescending() {
        
        let count = 5
        
        self.createPersons(count: count, inContext: self.sut.viewContext) { error in
            XCTAssertNil(error)
        }
        
        let array = self.sut
            .fetchRequest(CDPerson.self)
            .sortDescriptor(NSSortDescriptor(keyPath: \CDPerson.age, ascending: false))
            .fetch(inContext: self.sut.viewContext)
            .compactMap { Int($0.age) }
        
        XCTAssertEqual(array.count, count)
        XCTAssertNotEqual(array, [5, 4, 3, 2, 1])
        
    }
    
    func testFetchPersonsWhenResetSorting() {
        
        let count = 5
        
        self.createPersons(count: count, inContext: self.sut.viewContext) { error in
            XCTAssertNil(error)
        }
        
        let array = self.sut
            .fetchRequest(CDPerson.self)
            .sortDescriptor(NSSortDescriptor(keyPath: \CDPerson.age, ascending: false))
            .sortDescriptor(nil)
            .fetch(inContext: self.sut.viewContext)
            .compactMap { Int($0.age) }
        
        XCTAssertEqual(array.count, count)
        XCTAssertNotEqual(array, [1, 2, 3, 4, 5])
        XCTAssertNotEqual(array, [5, 4, 3, 2, 1])
        
    }
    

}

extension SortableTests {
    
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
