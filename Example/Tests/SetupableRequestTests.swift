//
//  SetupableRequestTests.swift
//  SwiftCoreData_Tests
//
//  Created by Grigory Sapogov on 09.01.2025.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import XCTest
import SwiftCoreData
import CoreData

final class SetupableRequestTests: XCTestCase {

    var sut: CoreDataStack!
    
    override func setUp() {
        super.setUp()
        self.sut = CoreDataStack.createCoreDataStackInMemory()
    }
    
    override func tearDown() {
        super.tearDown()
        self.sut = nil
    }
    
    func testFetchRequestWhenSetup() {
        
        var request = self.sut
            .fetchRequest(CDPersonTest.self)
        
        let predicateBefore: NSPredicate? = nil
        
        request.request.predicate = predicateBefore
        
        XCTAssertEqual(request.request.predicate, predicateBefore)
        
        let predicateAfter = NSPredicate(format: "name CONTAINS[cd] %@", "us")
        
        request = request.setup { request in
            request.predicate = predicateAfter
        }
        
        XCTAssertEqual(request.request.predicate, predicateAfter)
        
    }
    
    func testFetchRequestIDWhenSetup() {
        
        var request = self.sut
            .fetchRequestID(CDPersonTest.self)
        
        let predicateBefore: NSPredicate? = nil
        
        request.request.predicate = predicateBefore
        
        XCTAssertEqual(request.request.predicate, predicateBefore)
        
        let predicateAfter = NSPredicate(format: "name CONTAINS[cd] %@", "us")
        
        request = request.setup { request in
            request.predicate = predicateAfter
        }
        
        XCTAssertEqual(request.request.predicate, predicateAfter)
        
    }
    
    func testFetchRequestDictionaryWhenSetup() {
        
        var request = self.sut
            .fetchRequestDictionary(CDPersonTest.self)
        
        let predicateBefore: NSPredicate? = nil
        
        request.request.predicate = predicateBefore
        
        XCTAssertEqual(request.request.predicate, predicateBefore)
        
        let predicateAfter = NSPredicate(format: "name CONTAINS[cd] %@", "us")
        
        request = request.setup { request in
            request.predicate = predicateAfter
        }
        
        XCTAssertEqual(request.request.predicate, predicateAfter)
        
    }
    
    func testFetchRequestCountWhenSetup() {
        
        var request = self.sut
            .fetchRequestCount(CDPersonTest.self)
        
        let predicateBefore: NSPredicate? = nil
        
        request.request.predicate = predicateBefore
        
        XCTAssertEqual(request.request.predicate, predicateBefore)
        
        let predicateAfter = NSPredicate(format: "name CONTAINS[cd] %@", "us")
        
        request = request.setup { request in
            request.predicate = predicateAfter
        }
        
        XCTAssertEqual(request.request.predicate, predicateAfter)
        
    }

}
