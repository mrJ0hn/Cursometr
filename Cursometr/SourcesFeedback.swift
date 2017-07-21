//
//  SourcesFeedback.swift
//  Cursometr
//
//  Created by iMacAir on 15.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import Foundation

enum FeedbackSubject: CustomStringConvertible {
    case addSource
    case addQuotations
    case addFunction
    case another
    
    var description: String {
        switch self {
        case .addSource:
            return "Add source"
        case .addQuotations:
            return "Add quotation"
        case .addFunction:
            return "Add function"
        case .another:
            return "Another"
        }
    }
    
    static let allValues: [FeedbackSubject] = [ .addSource, .addQuotations, .addFunction, .another]
}
