//
//  Repository.swift
//  Cursometr
//
//  Created by iMacAir on 27.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import Foundation
import CoreData

class Repository{
    let context = CoreDataManager.getContext()
    static let shated = Repository()
    
    private init(){}
    
    func save(item: NSManagedObject){
        do{
            try context.save()
        }catch let error as NSError{
            print("Could not save \(error) \(error.userInfo)")
        }
    }
    
    func fetch(entityName: EntityName) -> [NSManagedObject]?{
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName.rawValue)
        
        do{
            let fatchedData = try context.fetch(fetchRequest) as! [NSManagedObject]
            return fatchedData
        }
        catch{
            print(error)
        }
        return nil
    }
    
    func delete(item: NSManagedObject){
        context.delete(item)
        do{
            try context.save()
        }
        catch{
            print(error)
        }
    }
}
