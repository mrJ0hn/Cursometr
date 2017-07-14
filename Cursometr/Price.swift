//
//  Price.swift
//  Cursometr
//
//  Created by iMacAir on 12.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import Foundation

struct Price{
    let id: Int
    let range: Int
    let buyPriceNow: Double
    let salePriceNow: Double
}
extension Price{
    
    init(json: JSON){
        guard let id = json["id"] as? Int,
            let range = json["range"] as? Int,
            let buyPriceNow = json["buyPriceNow"] as? Double,
            let salePriceNow = json["salePriceNow"] as? Double
            else{
                fatalError("extension Price: init(json:)")
        }
        self.id = id
        self.range = range
        self.buyPriceNow = buyPriceNow
        self.salePriceNow = salePriceNow
    }
}
