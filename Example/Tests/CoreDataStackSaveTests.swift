//
//  CoreDataStackSaveTests.swift
//  SwiftCoreData_Tests
//
//  Created by Grigory Sapogov on 04.01.2025.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import XCTest
import SwiftCoreData

final class CoreDataStackSaveTests: XCTestCase {

    var sut: CoreDataStack!
    
    override func setUp() {
        super.setUp()
        self.sut = CoreDataStack.createSUT()
    }
    
    override func tearDown() {
        super.tearDown()
        self.sut = nil
    }
    
    func testSavePerson() {
        
        let arrayBefore = self.sut.fetch(CDPerson.self, inContext: sut.viewContext)
        
        XCTAssertEqual(arrayBefore.isEmpty, true)
        
        let cdPerson = CDPerson(context: sut.viewContext)
        
        cdPerson.name = "User"
        cdPerson.age = 100
        
        sut.save(inContext: sut.viewContext) { result in
            
            XCTAssertNil(result.error)
            
        }
        
        let arrayAfter = self.sut.fetch(CDPerson.self, inContext: sut.viewContext)
        
        XCTAssertEqual(arrayAfter.count, 1)
        XCTAssertEqual(arrayAfter.first?.name, "User")
        XCTAssertEqual(arrayAfter.first?.age, 100)
        
    }
    
}
