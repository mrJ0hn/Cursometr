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
        let savedCurrencies = fetchCurrenciesFromCoreData()
        onSuccess(fetchCurrenciesFromCoreData())
        CurrencyListService.shared.obtainCurrencyList(onSuccess: {[weak self] (currencies) in
            if savedCurrencies.count != currencies.count {
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
        let currenciesObj = fetch(entityName: .currencyObj, predicate: predicate) as! [CurrencyObj]
        if let currencyObj = currenciesObj.first{
            let exchangesObj = currencyObj.exchanges?.allObjects as! [ExchangeObj]
            for i in 0..<exchangesObj.count{
                if Int(exchangesObj[i].id) == currency.sources[i].id{
                    exchangesObj[i].subscribed = currency.sources[i].subscribed
                }
            }
            CoreDataManager.saveContext()
        }
    }
    
    private func fetchExchangesFromCoreData() -> [Exchange]{
        let fetchedCurrencies = fetch(entityName: .exchangeObj) as! [ExchangeObj]
        print(fetchedCurrencies)
        return fetchedCurrencies.map(ModelConverter.convert)
    }
    
    private func fetchCurrenciesFromCoreData() -> [Currency]{
        let fetchedCurrencies = fetch(entityName: .currencyObj) as! [CurrencyObj]
        print(fetchedCurrencies)
        return fetchedCurrencies.map(ModelConverter.convert)
    }
    
    private func fetch(entityName: EntityName, predicate: NSPredicate? = nil) -> [Any]{
        let context = CoreDataManager.getContext()
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: entityName.rawValue)
        if let predicate = predicate{
            fetchRequest.predicate = predicate
        }
        do{
            return try context.fetch(fetchRequest)
        }catch{
            print(error)
        }
        return []
    }
    
    private func saveCurrenciesToCoreData(currencies: [Currency]){
        let currenciesObj = currencies.map(ModelConverter.convert)
        for i in 0..<currencies.count{
            for exchange in currencies[i].sources{
                let exchangeObj = ModelConverter.convert(exchange: exchange)
                currenciesObj[i].addToExchanges(exchangeObj)
                exchangeObj.addToCurrencies(currenciesObj[i])
            }
        }
        CoreDataManager.saveContext()
    }
}
