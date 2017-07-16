//
//  SourcesFeedback.swift
//  Cursometr
//
//  Created by iMacAir on 15.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import Foundation

class SourcesFeedback{
    static let shared = SourcesFeedback()
    
    enum Source: Int {
        case addSource
        case addQuotations
        case addFunction
        case another
    }
    
    let sources : [String] = ["Add source", "Add quotation", "Add function", "Another"]
}
