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
    var subscribed: Bool
    let showSellPrice: Bool
    let prices: [Price]
}

extension Exchange {
    
    init?(json: JSON){
        guard let id = json["id"] as? Int,
            let name = json["name"] as? String
            //let prices = json["ranges"] as? JSONArray
            //let subscribed = json["subscribed"] as? Bool
        else{
           return nil
        }
        self.id = id
        self.name = name
        if let subscribed = (json["subscribed"] as? Bool){
            self.subscribed = subscribed
        }
        else{
            self.subscribed = false
        }
        if let showSellPrice = (json["showSellPrice"] as? Bool){
            self.showSellPrice = showSellPrice
        }
        else{
            showSellPrice = true
        }
        if let prices = (json["ranges"] as? JSONArray){
            self.prices = prices.map(Price.init)
        }
        else{
            self.prices = []
        }
    }
}
