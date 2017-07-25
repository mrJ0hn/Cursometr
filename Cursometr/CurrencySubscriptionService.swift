//
//  CurrencySubscriptionService.swift
//  Cursometr
//
//  Created by iMacAir on 18.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import Foundation

class CurrencySubscriptionService {
    private static var instance: CurrencySubscriptionService!
    var authorizationService: AuthorizationService!
    let group = DispatchGroup()
    var currentCurrencies : [Currency] = []
    
    enum ActionUnderCurrencySubscription{
        case delete
        case add
    }
    
    class var shared: CurrencySubscriptionService {
        return instance
    }

    class func initialize(dependency: AuthorizationService){
        guard self.instance == nil else {
            return
        }
        instance = CurrencySubscriptionService(authorizationService: dependency)
    }
    
    private init(authorizationService: AuthorizationService) {
        self.authorizationService = authorizationService
    }
    
    private init(){}
    
    func obtainCurrencySubscription(onSuccess: @escaping ([Currency])->Void, onError: @escaping ErrorAction){
        authorizationService.loginIfNecessary(onSuccess: {[weak self] in
            let url = URL(string: ApiURL.strUrlCurrencySubscription.rawValue)!
            let onSuccess : (JSON, URLResponse)->Void = { [weak self] (jsonArray, _) in
                let jsonCurrencies = jsonArray["subscriptionCategories"] as? JSONArray
                let currencies: [Currency] = jsonCurrencies!.map(Currency.init)
                self?.currentCurrencies = currencies
                onSuccess(currencies)
            }
            NetworkController.request(endpoint: url, query: nil, body: nil, httpMethod: .get, onSuccess: onSuccess, onError: onError)
        }, onError: onError)
    }
    
    func changeCurrencySubscription(categoryId: Int, subscriptions: [Subscription], deleteAll: Bool = false, onError: @escaping ErrorAction){
        NotificationCenter.default.post(name: .StartLoadingCurrencySubscription, object: nil)
        if deleteAll{
            group.enter()
            self.deleteCategory(categoryId: categoryId, onSuccess: {
                self.group.leave()
            }, onError: onError)
        }
        for data in subscriptions{
            switch data.action{
            case .add:
                group.enter()
                self.addCategory(categoryId: categoryId, onSuccess: {
                    self.group.leave()
                }, onError: onError)
                group.enter()
                self.addCurrencySubscription(categoryId: categoryId, sourceId: data.sourceId, onSuccess: {
                    self.group.leave()
                }, onError: onError)
            case .delete:
                group.enter()
                self.deleteCurrencySubscription(categoryId: categoryId, sourceId: data.sourceId, onSuccess: {
                    self.group.leave()
                }, onError: onError)
            }
        }
        group.notify(queue: DispatchQueue.main){
            NotificationCenter.default.post(name: .FinishLoadingCurrencySubscription, object: nil)
        }
    }
    
    func addCategory(categoryId: Int, onSuccess: @escaping Action, onError: @escaping ErrorAction){
        let url = URL(string: ApiURL.strUrlCategory.rawValue)!
        let parameters : JSON = ["categoryId" : categoryId as AnyObject]
        let onSuccess : (JSON, URLResponse)->Void = { (_, _) in
            onSuccess()
        }
        NetworkController.request(endpoint: url, query: parameters, body: nil, httpMethod: .post, onSuccess: onSuccess, onError: onError)
    }
    
    func deleteCategory(categoryId: Int, onSuccess: @escaping Action, onError: @escaping ErrorAction){
        let url = URL(string: ApiURL.strUrlCategory.rawValue)!
        let parameters : JSON = ["categoryId" : categoryId as AnyObject]
        let onSuccess : (JSON, URLResponse)->Void = { (_, _) in
            onSuccess()
        }
        NetworkController.request(endpoint: url, query: parameters, body: nil, httpMethod: .delete, onSuccess: onSuccess, onError: onError)
    }
    
    
    func addCurrencySubscription(categoryId: Int, sourceId: Int, onSuccess: @escaping Action, onError: @escaping ErrorAction){
        let url = URL(string: ApiURL.strUrlCurrencySubscription.rawValue)!
        let json : JSON = ["categoryId" : categoryId as AnyObject, "sourceId" : sourceId as AnyObject]
        let onSuccess : (JSON, URLResponse)->Void = { (_, _) in
            onSuccess()
        }
        NetworkController.request(endpoint: url, query: nil, body: json, httpMethod: .post, onSuccess: onSuccess, onError: onError)
    }
    
    func deleteCurrencySubscription(categoryId: Int, sourceId: Int, onSuccess: @escaping Action, onError: @escaping ErrorAction){
        let url = URL(string: ApiURL.strUrlCurrencySubscription.rawValue)!
        let parameters : JSON = ["categoryId" : categoryId as AnyObject, "sourceId" : sourceId as AnyObject]
        let onSuccess : (JSON, URLResponse)->Void = { (_, _) in
            onSuccess()
        }
        NetworkController.request(endpoint: url, query: parameters, body: nil, httpMethod: .delete, onSuccess: onSuccess, onError: onError)
    }
}
