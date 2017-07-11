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
    let subscribed: Bool
}

extension Exchange {
    
    init(json: JSON){
        guard let id = json["id"] as? Int,
            let name = json["name"] as? String,
            let subscribed = json["subscribed"] as? Bool else{
                fatalError()
        }
        self.id = id
        self.name = name
        self.subscribed = subscribed
    }
}
