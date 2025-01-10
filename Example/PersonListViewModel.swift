//
//  PersonListViewModel.swift
//  SwiftCoreData_Example
//
//  Created by Grigory Sapogov on 10.01.2025.
//  Copyright © 2025 CocoaPods. All rights reserved.
//

import Foundation
import CoreData

final class PersonListViewModel {
    
    lazy private(set) var viewContext = {
        coreDataStack.viewContext
    }()
    
    var refreshListCompletion: ((Error?) -> Void)?
    
    var cleanListCompletion: ((Error?) -> Void)?
    
    func refreshList() {
        
        coreDataStack.performBackgroundTask { privateContext in
            
            self.cleanList(inContext: privateContext)
                
            self.createList(inContext: privateContext)
            
            coreDataStack.save(inContext: privateContext) { result in
                
                DispatchQueue.main.async {
                    self.refreshListCompletion?(result.error)
                }
                
            }
            
        }
        
    }
    
    func cleanList() {
        
        coreDataStack.performBackgroundTask { privateContext in
            
            self.cleanList(inContext: privateContext) { [weak self] error in
                
                DispatchQueue.main.async {
                    self?.cleanListCompletion?(error)
                }
                
            }

        }
        
    }
    
}

extension PersonListViewModel {
    
    private func cleanList(inContext context: NSManagedObjectContext, completion: ((Error?) -> Void)? = nil) {
        coreDataStack
            .batchDeleteRequest(CDPerson.self)
            .merge(into: [context])
            .delete(inContext: context) { error in
                completion?(error)
            }
    }
    
    private func createList(inContext context: NSManagedObjectContext) {
        let count = Int.random(in: 1...10)
        for i in 1...count {
            let cdPerson = CDPerson(context: context)
            cdPerson.name = "Person \(i)"
            cdPerson.age = i.int16
        }
    }
    
}
