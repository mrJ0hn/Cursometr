//
//  PriceObj+CoreDataClass.swift
//  Cursometr
//
//  Created by iMacAir on 27.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import Foundation
import CoreData

@objc(PriceObj)
public class PriceObj: NSManagedObject {
    @nonobjc public class func fetchRequest() -> NSFetchRequest<PriceObj> {
        return NSFetchRequest<PriceObj>(entityName: "PriceObj")
    }
    
    @NSManaged public var buyPriceNow: Double
    @NSManaged public var id: Int32
    @NSManaged public var range: Int32
    @NSManaged public var salePriceNow: Double
    @NSManaged public var exchanges: ExchangeObj?
    
    convenience init(){
        self.init(entity: CoreDataManager.entityForName(entityName: .priceObj), insertInto: CoreDataManager.getContext())
    }
    
    convenience init(id: Int32, range: Int32, buyPriceNow: Double, salePriceNow: Double){
        self.init()
        self.id = id
        self.range = range
        self.buyPriceNow = buyPriceNow
        self.salePriceNow = salePriceNow
    }
}
