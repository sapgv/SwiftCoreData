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
            .fetchRequest(CDPersonTest.self)
            .fetch(inContext: sut.viewContext)
        
        XCTAssertEqual(arrayBefore.isEmpty, true)
        
        let count = 10
        
        self.sut.createPersons(count: count, inContext: sut.viewContext) { error in
            XCTAssertNil(error)
        }
        
        let arrayAfter = self.sut
            .fetchRequest(CDPersonTest.self)
            .sortDescriptor(NSSortDescriptor(keyPath: \CDPersonTest.age, ascending: true))
            .fetch(inContext: sut.viewContext)
        
        XCTAssertEqual(arrayAfter.count, count)
        
        for i in 0..<count {
            XCTAssertEqual(arrayAfter[i].name, "User \(i)")
            XCTAssertEqual(arrayAfter[i].age, Int16(i))
        }
        
    }
    
}

extension CoreDataStack {
    
    func createPersons(count: Int = 10, inContext context: NSManagedObjectContext, completion: (Error?) -> Void) {
        
        for i in 0..<count {
            let cdPerson = CDPersonTest(context: context)
            cdPerson.name = "User \(i)"
            cdPerson.age = Int16(i)
        }
        
        self.save(inContext: context) { result in
            
            completion(result.error)
            
        }
        
    }
    
}
