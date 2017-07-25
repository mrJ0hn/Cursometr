//
//  Typealias.swift
//  Cursometr
//
//  Created by iMacAir on 24.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import Foundation

typealias JSONArray = [JSON]
typealias JSON = [String:AnyObject]
typealias Action = () -> Void
typealias ErrorAction = (Error) -> Void
typealias Subscription = (sourceId: Int, action: CurrencySubscriptionService.ActionUnderCurrencySubscription)
