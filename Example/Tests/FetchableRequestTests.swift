//
//  FetchableRequestTests.swift
//  SwiftCoreData_Tests
//
//  Created by Grigory Sapogov on 09.01.2025.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import XCTest
import SwiftCoreData
import CoreData

final class FetchableRequestTests: XCTestCase {

    var sut: CoreDataStack!
    
    override func setUp() {
        super.setUp()
        self.sut = CoreDataStack.createCoreDataStackInMemory()
    }
    
    override func tearDown() {
        super.tearDown()
        self.sut = nil
    }
    
    func testFetchPersonsWhenEmpty() {
        
        let array = self.sut
            .fetchRequest(CDPerson.self)
            .fetch(inContext: self.sut.viewContext)
        
        XCTAssertEqual(array.isEmpty, true)
    
    }
    
    func testFetchPersonWhenNil() {
        
        let person = self.sut
            .fetchRequest(CDPerson.self)
            .fetchOne(inContext: self.sut.viewContext)
        
        XCTAssertNil(person)
    
    }
    
    func testFetchPersonsWhenNotEmpty() {
        
        let count = 10
        
        self.createPersons(count: count, inContext: self.sut.viewContext) { error in
            XCTAssertNil(error)
        }
        
        let array = self.sut
            .fetchRequest(CDPerson.self)
            .fetch(inContext: self.sut.viewContext)
        
        XCTAssertEqual(array.count, count)
        
    }
    
    func testFetchPersonWhenNotNil() {
        
        let count = 10
        
        self.createPersons(count: count, inContext: self.sut.viewContext) { error in
            XCTAssertNil(error)
        }
        
        let person = self.sut
            .fetchRequest(CDPerson.self)
            .fetchOne(inContext: self.sut.viewContext)
        
        XCTAssertNotNil(person)
        
    }
    
    func testFetchPersonsWhenLimit() {
        
        let count = 10
        
        self.createPersons(count: count, inContext: self.sut.viewContext) { error in
            XCTAssertNil(error)
        }
        
        let fetchLimit = 2
        
        let array = self.sut
            .fetchRequest(CDPerson.self)
            .setupLimit(fetchLimit)
            .fetch(inContext: self.sut.viewContext)
        
        XCTAssertEqual(array.count, fetchLimit)
        
    }
    
    func testFetchPersonsWhenBatch() {
        
        let count = 10
        
        self.createPersons(count: count, inContext: self.sut.viewContext) { error in
            XCTAssertNil(error)
        }
        
        let fetchBatchSize = 2
        
        let request = self.sut
            .fetchRequest(CDPerson.self)
            .setupBatchSize(fetchBatchSize)
        
        XCTAssertEqual(request.request.fetchBatchSize, fetchBatchSize)
        
    }

}

extension FetchableRequestTests {
    
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
