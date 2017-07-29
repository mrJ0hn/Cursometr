//
//  Repository.swift
//  Cursometr
//
//  Created by iMacAir on 27.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import Foundation
import CoreData

class Repository{
    let context = CoreDataManager.getContext()
    static let shared = Repository()
    
    var subscribedCurrencies : [Currency] = []
    
    private init(){}
    
    func obtainAllCurrencies(onSuccess: @escaping ([Currency])->Void, onError: @escaping ErrorAction){
        let savedCurrenciesObj = fetchCurrenciesFromCoreData()
        onSuccess(savedCurrenciesObj.map(ModelConverter.convert))
        CurrencyListService.shared.obtainCurrencyList(onSuccess: {[weak self] (currencies) in
            if savedCurrenciesObj.count != currencies.count {
                self?.saveCurrenciesToCoreData(currencies: currencies)
                onSuccess(currencies)
            }
            }, onError: onError)
    }
    
    func obtainCurrencySubscription(onSuccess: @escaping ([Currency])->Void, onError: @escaping ErrorAction){
        onSuccess(subscribedCurrencies)
        NotificationCenter.default.post(name: .StartLoadingCurrencySubscription, object: nil)
        CurrencySubscriptionService.shared.obtainCurrencySubscription(onSuccess: { [weak self] (currencies) in
            self?.subscribedCurrencies = currencies
            onSuccess(currencies)
            NotificationCenter.default.post(name: .StopLoadingCurrencySubscription, object: nil)
            }, onError: onError)
    }
    
    func updateCurrencySubscribed(currency: Currency){
        let predicate = NSPredicate(format: "id = %i", currency.id)
        let currenciesObj = fetchCurrenciesFromCoreData(predicate: predicate)
        if let currencyObj = currenciesObj.first{
            let exchangesObj = currencyObj.exchanges?.allObjects as! [ExchangeObj]
            for exchange in currency.sources{
                for exchangeObj in exchangesObj{
                    if exchange.id == Int(exchangeObj.id) && exchange.subscribed != exchangeObj.subscribed{
                        exchangeObj.subscribed = exchange.subscribed
                    }
                }
            }
        }
    }
    
    private func fetchExchangesFromCoreData(predicate: NSPredicate? = nil) -> [ExchangeObj]{
        let request = ExchangeObj.sortedFetchRequest
        do{
            return try context.fetch(request)
        }catch{
            print(error)
        }
        return []
//        let fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
//        let fetchedExchanges = fetchedResultsController.fetchedObjects
//        if let exchanges = fetchedExchanges{
//            return exchanges
//        }
//        return []
    }
    
    private func fetchCurrenciesFromCoreData(predicate: NSPredicate? = nil) -> [CurrencyObj]{
        let request = CurrencyObj.sortedFetchRequest
        request.predicate = predicate
        //        let fetchedResultsController = NSFetchedResultsController(fetchRequest: request, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        do{
            return try context.fetch(request)
        }catch{
            print(error)
        }
        return []
    }
    
    private func saveCurrenciesToCoreData(currencies: [Currency]){
        for currency in currencies{
            saveCurrencyToCoreData(currency: currency, subscribed: false)
        }
        //CoreDataManager.saveContext()
    }
    
    private func saveCurrencyToCoreData(currency: Currency, subscribed: Bool){
        let currencyObj = CurrencyObj.insert(into: context, id: currency.id, name: currency.name, fullName: currency.fullName, subscribed: subscribed)
        var exchangesObj : [ExchangeObj] = []
        for exchange in currency.sources{
            let exchangeObj = ExchangeObj.insert(into: context, id: exchange.id, name: exchange.name, showSellPrice: exchange.showSellPrice, subscribed: exchange.subscribed)
            exchangeObj.addToCurrencies(currencyObj)
            exchangesObj.append(exchangeObj)
        }
        currencyObj.addToExchanges(NSSet(array: exchangesObj))
        CoreDataManager.saveContext()
    }
}
