//
//  DataController.swift
//  VirtualTourist
//
//  Created by Sam Townsend on 2018-12-16.
//  Copyright © 2018 Sam Townsend. All rights reserved.
//

import Foundation
import CoreData

class DataController {
    let persistentConainer: NSPersistentContainer
    var viewContext: NSManagedObjectContext {
        return persistentConainer.viewContext
    }
    
    init(modelName: String) {
        persistentConainer = NSPersistentContainer(name: modelName)
    }
    
    func load(completion: (() -> Void)? = nil) {
        persistentConainer.loadPersistentStores { storeDescription, error in
            
            guard error == nil else {
                fatalError(error!.localizedDescription)
            }
            completion?()
        }
    }
}
