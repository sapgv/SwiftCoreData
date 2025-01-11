//
//  FetchableCountTests.swift
//  SwiftCoreData_Tests
//
//  Created by Grigory Sapogov on 09.01.2025.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import XCTest
import SwiftCoreData
import CoreData

final class FetchableCountTests: XCTestCase {

    var sut: CoreDataStack!
    
    override func setUp() {
        super.setUp()
        self.sut = CoreDataStack.createCoreDataStackInMemory()
    }
    
    override func tearDown() {
        super.tearDown()
        self.sut = nil
    }
    
    func testFetchPersonsWhenCountZero() {
        
        let result = self.sut
            .fetchRequestCount(CDPersonTest.self)
            .fetchCount(inContext: self.sut.viewContext)
        
        XCTAssertEqual(result, 0)
        
    }
    
    func testFetchPersonsWhenCountNotZero() {
        
        let count = 10
        
        self.createPersons(count: count, inContext: self.sut.viewContext) { error in
            XCTAssertNil(error)
        }
        
        let result = self.sut
            .fetchRequestCount(CDPersonTest.self)
            .fetchCount(inContext: self.sut.viewContext)
        
        XCTAssertEqual(result, count)
        
    }

}

extension FetchableCountTests {
    
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
