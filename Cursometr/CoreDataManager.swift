//
//  DatabaseController.swift
//  Cursometr
//
//  Created by iMacAir on 27.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import Foundation
import CoreData

enum EntityName: String {
    case currencyObj = "CurrencyObj"
    case exchangeObj = "ExchangeObj"
    case priceObj = "PriceObj"
}

class CoreDataManager{
    
    private init(){}
    
    class func getContext() -> NSManagedObjectContext{
        return persistentContainer.viewContext
    }
    
    static var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Cursometr")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    class func saveContext () {
        let context = getContext()
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    static func entityForName(entityName: EntityName) -> NSEntityDescription{
        return NSEntityDescription.entity(forEntityName: entityName.rawValue, in: getContext())!
    }
}
