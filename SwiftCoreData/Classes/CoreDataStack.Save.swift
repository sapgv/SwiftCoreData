//
//  CoreDataStack.Save.swift
//  SwiftCoreData
//
//  Created by Grigory Sapogov on 04.01.2025.
//

import CoreData

public
extension CoreDataStack {
    
    func save(
        inContext context: NSManagedObjectContext,
        savePolicy: ISavePolicy = RollBackSavePolicy(),
        completion: (SaveResult) -> Void
    ) {
        
        guard context.hasChanges else {
            completion(.success)
            return
        }
        
        do {
            try context.save()
            completion(.success)
        }
        catch {
            savePolicy.handle(context: context)
            completion(.failure(error))
        }
        
    }
    
}
