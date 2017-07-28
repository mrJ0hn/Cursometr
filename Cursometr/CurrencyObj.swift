//
//  CurrencyObj+CoreDataClass.swift
//  Cursometr
//
//  Created by iMacAir on 27.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import Foundation
import CoreData

@objc(CurrencyObj)
public class CurrencyObj: NSManagedObject {
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<CurrencyObj> {
        return NSFetchRequest<CurrencyObj>(entityName: "CurrencyObj")
    }
    
    @NSManaged public var fullName: String
    @NSManaged public var id: Int32
    @NSManaged public var name: String
    @NSManaged public var subscribed: Bool
    @NSManaged public var exchanges: NSSet?

    convenience init(){
        self.init(entity: CoreDataManager.entityForName(entityName: .currencyObj), insertInto: CoreDataManager.getContext())
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
