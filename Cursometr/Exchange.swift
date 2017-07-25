//
//  Exchange.swift
//  Cursometr
//
//  Created by iMacAir on 11.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import Foundation

struct Exchange {
    let id: Int
    let name: String
    var subscribed: Bool = false
    var showSellPrice: Bool = true
    var prices: [Price] = []
}

extension Exchange {
    
    init?(json: JSON){
        guard let id = json["id"] as? Int,
            let name = json["name"] as? String
            else{
                return nil
        }
        self.id = id
        self.name = name
        if let subscribed = (json["subscribed"] as? Bool){
            self.subscribed = subscribed
        }
        if let showSellPrice = (json["showSellPrice"] as? Bool){
            self.showSellPrice = showSellPrice
        }
        if let prices = (json["ranges"] as? JSONArray){
            self.prices = prices.map(Price.init)
        }
    }
}
