//
//  ApiURL.swift
//  Cursometr
//
//  Created by iMacAir on 24.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import Foundation

enum ApiURL: String{
    case strUrlAuthentication = "http://currency.btc-solutions.ru:8080/api/Account"
    case strUrlCurrencySubscription = "http://currency.btc-solutions.ru:8080/api/CurrencySubscription"
    case strUrlCurrencyList = "http://currency.btc-solutions.ru:8080/api/CurrencyList"
    case strURLFeedback = "http://currency.btc-solutions.ru:8080/api/Feedback"
    case strUrlCategory = "http://currency.btc-solutions.ru:8080/api/Category"
}
