//
//  CoreDataStackSaveTests.swift
//  SwiftCoreData_Tests
//
//  Created by Grigory Sapogov on 04.01.2025.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import XCTest
import CoreData
import SwiftCoreData

final class CoreDataStackSaveTests: XCTestCase {

    var sut: CoreDataStack!
    
    override func setUp() {
        super.setUp()
        self.sut = CoreDataStack.createCoreDataStackInMemory()
    }
    
    override func tearDown() {
        super.tearDown()
        self.sut = nil
    }
    
    func testSavePerson() {
        
        let arrayBefore = self.sut
            .fetchRequest(CDPerson.self)
            .fetch(inContext: sut.viewContext)
        
        XCTAssertEqual(arrayBefore.isEmpty, true)
        
        let cdPerson = CDPerson(context: sut.viewContext)
        
        cdPerson.name = "User"
        cdPerson.age = 100
        
        sut.save(inContext: sut.viewContext) { result in
            
            XCTAssertNil(result.error)
            
        }
        
        let arrayAfter = self.sut
            .fetchRequest(CDPerson.self)
            .fetch(inContext: sut.viewContext)
        
        XCTAssertEqual(arrayAfter.count, 1)
        XCTAssertEqual(arrayAfter.first?.name, "User")
        XCTAssertEqual(arrayAfter.first?.age, 100)
        
        
        let array = self.sut.fetchRequest(CDPerson.self)
//            .pre
//            .sor
            .fetch(inContext: self.sut.viewContext)
        
        XCTAssertEqual(array.isEmpty, false)
        
        let count = self.sut.fetchRequestCount(CDPerson.self)
//            .pre
//            .s
//            .f
            .fetchCount(inContext: self.sut.viewContext)
        
        XCTAssertEqual(count, 1)
        
//        let ids = FetchRequest<NSManagedObjectID>(CDPerson.self)
//            .fetch(inContext: sut.viewContext)
        
//        XCTAssertEqual(ids.count, 1)
        
        let data = sut.fetchRequestDictionary(CDPerson.self)
//            .f
//            .f
            .fetch(inContext: sut.viewContext)
        
        XCTAssertEqual(data.isEmpty, false)
        
        let ids = sut.fetchRequestID(CDPerson.self)
//            .fe
            .fetch(inContext: sut.viewContext)
        
        
        XCTAssertEqual(ids.isEmpty, false)
        
    }
    
}
