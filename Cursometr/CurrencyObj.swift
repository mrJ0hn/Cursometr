//
//  CurrencyObj+CoreDataClass.swift
//  Cursometr
//
//  Created by iMacAir on 27.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import Foundation
import CoreData
import CoreLocation

@objc(CurrencyObj)
public class CurrencyObj: NSManagedObject {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CurrencyObj> {
        return NSFetchRequest<CurrencyObj>(entityName: "CurrencyObj")
    }
    
    @NSManaged public var id: Int32
    @NSManaged public var name: String
    @NSManaged public var fullName: String
    @NSManaged public var subscribed: Bool
    @NSManaged public var exchanges: NSSet?
    
    convenience init(context: NSManagedObjectContext){
        self.init(entity: CoreDataManager.entityForName(entityName: .currencyObj), insertInto: context)
    }
    
    static func insert(into context: NSManagedObjectContext, id: Int, name: String, fullName: String, subscribed: Bool) -> CurrencyObj {
        let currencyObj = CurrencyObj(context: context)
        currencyObj.id = Int32(id)
        currencyObj.name = name
        currencyObj.fullName = fullName
        currencyObj.subscribed = subscribed
        return currencyObj
    }
}

extension CurrencyObj: Managed{
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(name), ascending: false)]
    }
}

// MARK: Generated accessors for exchanges
extension CurrencyObj {
    
    @objc(addExchangesObject:)
    @NSManaged public func addToExchanges(_ value: ExchangeObj)
    
    @objc(removeExchangesObject:)
    @NSManaged public func removeFromExchanges(_ value: ExchangeObj)
    
    @objc(addExchanges:)
    @NSManaged public func addToExchanges(_ values: NSSet)
    
    @objc(removeExchanges:)
    @NSManaged public func removeFromExchanges(_ values: NSSet)
    
}
