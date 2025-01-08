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
        self.sut = CoreDataStack.createSUT()
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
    
//        let array2 = FetchRequest<NSManagedObject>(CDPerson.self)
//            .fetch(inContext: self.sut.viewContext)
//        
//        XCTAssertEqual(array2.isEmpty, true)
//        
//        let count = FetchRequest<NSNumber>(CDPerson.self)
//            .fetchCount(inContext: self.sut.viewContext)
//        
//        XCTAssertEqual(count, 0)
        
    }
    
}

