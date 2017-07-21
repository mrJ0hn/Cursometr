//
//  Currency.swift
//  Cursometr
//
//  Created by iMacAir on 11.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import Foundation

struct Currency{
    let id: Int
    let name: String
    let fullName: String
    var sources: [Exchange]
}

extension Currency{
    init(json: JSON){
        guard let id = json["id"] as? Int,
            let name = json["name"] as? String,
            let fullName = json["fullName"] as? String,
            let json = json["sources"] as? JSONArray
            else {
                fatalError("extension Currency: init(json:)")
        }
        
        self.id = id
        self.name = name
        self.fullName = fullName
        self.sources = json.flatMap(Exchange.init)
    }
}
