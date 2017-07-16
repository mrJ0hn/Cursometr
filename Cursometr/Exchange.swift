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
    let prices: [Price]
}

extension Exchange {
    
//    init(json: JSON){
//        guard let id = json["id"] as? Int,
//            let name = json["name"] as? String,
//            let subscribed = json["subscribed"] as? Bool else{
//                fatalError()
//        }
//        self.id = id
//        self.name = name
//        self.subscribed = subscribed
//        self.prices = [Price(),Price(),Price()]
//    }
    
    init(json: JSON){
        guard let id = json["id"] as? Int,
            let name = json["name"] as? String
            //let prices = json["ranges"] as? JSONArray
            //let subscribed = json["subscribed"] as? Bool
        else{
                fatalError("extension Exchange: init(json:)")
        }
        self.id = id
        self.name = name
        if let subscribed = (json["subscribed"] as? Bool){
            self.subscribed = subscribed
        }
        else{
            self.subscribed = false
        }
        if let prices = (json["ranges"] as? JSONArray){
            self.prices = prices.map(Price.init)
        }
        else{
            self.prices = []
        }
    }
}
