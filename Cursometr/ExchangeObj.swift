//
//  ExchangeObj+CoreDataClass.swift
//  Cursometr
//
//  Created by iMacAir on 27.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import Foundation
import CoreData

@objc(ExchangeObj)
public class ExchangeObj: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<ExchangeObj> {
        return NSFetchRequest<ExchangeObj>(entityName: "ExchangeObj")
    }
    
    @NSManaged public var id: Int32
    @NSManaged public var name: String
    @NSManaged public var showSellPrice: Bool
    @NSManaged public var subscribed: Bool
    @NSManaged public var currencies: NSSet?
    @NSManaged public var prices: NSSet?
    
    convenience init(context: NSManagedObjectContext){
        self.init(entity: CoreDataManager.entityForName(entityName: .exchangeObj), insertInto: context)
    }
    
    static func insert(into context: NSManagedObjectContext, id: Int, name: String, showSellPrice: Bool, subscribed: Bool) -> ExchangeObj{
        let exhcangeObj = ExchangeObj(context: context)
        exhcangeObj.id = Int32(id)
        exhcangeObj.name = name
        exhcangeObj.showSellPrice = showSellPrice
        exhcangeObj.subscribed = subscribed
        return exhcangeObj
    }
}

extension ExchangeObj: Managed{
    static var defaultSortDescriptors: [NSSortDescriptor] {
        return [NSSortDescriptor(key: #keyPath(id), ascending: false)]
    }
}

// MARK: Generated accessors for currencies
extension ExchangeObj {
    
    @objc(addCurrenciesObject:)
    @NSManaged public func addToCurrencies(_ value: CurrencyObj)
    
    @objc(removeCurrenciesObject:)
    @NSManaged public func removeFromCurrencies(_ value: CurrencyObj)
    
    @objc(addCurrencies:)
    @NSManaged public func addToCurrencies(_ values: NSSet)
    
    @objc(removeCurrencies:)
    @NSManaged public func removeFromCurrencies(_ values: NSSet)
    
}

// MARK: Generated accessors for prices
extension ExchangeObj {
    
    @objc(addPricesObject:)
    @NSManaged public func addToPrices(_ value: PriceObj)
    
    @objc(removePricesObject:)
    @NSManaged public func removeFromPrices(_ value: PriceObj)
    
    @objc(addPrices:)
    @NSManaged public func addToPrices(_ values: NSSet)
    
    @objc(removePrices:)
    @NSManaged public func removeFromPrices(_ values: NSSet)
    
}
