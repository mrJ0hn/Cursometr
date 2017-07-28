//
//  ModelConverter.swift
//  Cursometr
//
//  Created by iMacAir on 27.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import Foundation

class ModelConverter{
    static func convert(currency: Currency) -> CurrencyObj{
        let currencyObj = CurrencyObj()
        currencyObj.id = Int32(currency.id)
        currencyObj.name = currency.name
        currencyObj.fullName = currency.fullName
        return currencyObj
    }
    
    static func convert(currencyObj: CurrencyObj) -> Currency{
        let exchangesObj = currencyObj.exchanges?.allObjects as! [ExchangeObj]
        let exchanges = exchangesObj.map(convert)
        return Currency(id: Int(currencyObj.id), name: currencyObj.name, fullName: currencyObj.fullName, sources: exchanges )
    }
    
    static func convert(exchange: Exchange) -> ExchangeObj{
        return ExchangeObj(id: Int32(exchange.id), name: exchange.name, showSellPrice: exchange.showSellPrice, subscribed: exchange.subscribed)
    }
    
    static func convert(exchangeObj: ExchangeObj) -> Exchange{
        return Exchange(id: Int(exchangeObj.id), name: exchangeObj.name, subscribed: exchangeObj.subscribed, showSellPrice: exchangeObj.showSellPrice, prices: [])
    }
    
    static func convert(price: Price) -> PriceObj{
        return PriceObj(id: Int32(price.id), range: Int32(price.range), buyPriceNow: price.buyPriceNow, salePriceNow: price.salePriceNow)
    }
    
    static func convert(priceObj: PriceObj) -> Price{
        return Price(id: Int(priceObj.id), range: Int(priceObj.range), buyPriceNow: priceObj.buyPriceNow, salePriceNow: priceObj.salePriceNow)
    }
}
