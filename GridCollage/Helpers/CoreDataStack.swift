//
//  CoreDataStack.swift
//  GridCollage
//
//  Created by Daniil Subbotin on 11/11/2018.
//  Copyright © 2018 Daniil Subbotin. All rights reserved.
//

import Foundation
import CoreData

class CoreDataStack {
    
    static let shared = CoreDataStack()
    
    private lazy var persistanceContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GridCollage")
        container.loadPersistentStores(completionHandler: { (description, error) in
            if let error = error as NSError? {
                print(error.localizedDescription)
            }
        })
        return container
    }()
    
    lazy var viewContext: NSManagedObjectContext = {
        return persistanceContainer.viewContext
    }()
    
    private init() {
    }
    
    func saveContext() {
        guard viewContext.hasChanges else { return }
        do {
            try viewContext.save()
        } catch let error as NSError {
            print(error.localizedDescription)
        }
    }
}
