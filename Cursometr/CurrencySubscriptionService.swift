//
//  CurrencySubscriptionService.swift
//  Cursometr
//
//  Created by iMacAir on 18.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import Foundation

typealias Subscription = (sourceId: Int, action: CurrencySubscriptionService.ActionUnderCurrencySubscription)

class CurrencySubscriptionService {
    private static var instance: CurrencySubscriptionService!
    var bankDataDownloadService: BankDataDownloadService!
    let group = DispatchGroup()
    var curCurrencies : [Currency] = []
    
    class var shared: CurrencySubscriptionService {
        return instance
    }
    
    enum ActionUnderCurrencySubscription{
        case delete
        case add
    }
    
    class func initialize(dependency: BankDataDownloadService){
        guard self.instance == nil else {
            return
        }
        instance = CurrencySubscriptionService(bankDataDownloadService: dependency)
    }
    
    private init(bankDataDownloadService: BankDataDownloadService) {
        self.bankDataDownloadService = bankDataDownloadService
    }
    
    
    func obtainCurrencySubscription(onSuccess: @escaping ([Currency])->Void, onError: @escaping (Error)->Void){
        if !BankDataDownloadService.isCookiesLoad{
            bankDataDownloadService.obtainCookies(onSuccess: { [weak self] in
                self?.loadingCurrencySubscription(onSuccess: {(currencies) in
                    self?.curCurrencies = currencies
                    onSuccess(currencies)
                }, onError: onError)
            }, onError: onError)
        }
        else{
            loadingCurrencySubscription(onSuccess: {(currencies) in
                onSuccess(currencies)
            }, onError: onError)
        }
    }
    
    func changeCurrencySubscription(categoryId: Int, subscriptions: [Subscription], deleteAll: Bool = false, onError: @escaping (Error)->Void){
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
    
    func addCategory(categoryId: Int, onSuccess: @escaping ()->Void, onError: @escaping (Error)->Void){
        let strUtl = ApiURL.strUrlCategory.rawValue
        let parameters = [("categoryId", categoryId as AnyObject)]
        let request = bankDataDownloadService.createJsonRequest(strUrl: strUtl, parameters: parameters, json: nil, httpMethod: HttpMethod.post)!
        let success : (JSON, URLResponse)->Void = { (jsonArray, _) in
            print(jsonArray)
            onSuccess()
        }
        NetworkController.shared.request(request: request, onSuccess: success, onError: onError)
    }
    
    func deleteCategory(categoryId: Int, onSuccess: @escaping ()->Void, onError: @escaping (Error)->Void){
        let strUtl = ApiURL.strUrlCategory.rawValue
        let parameters = [("categoryId", categoryId as AnyObject)]
        let request = bankDataDownloadService.createJsonRequest(strUrl: strUtl, parameters: parameters, json: nil, httpMethod: HttpMethod.delete)!
        let success : (JSON, URLResponse)->Void = { (jsonArray, _) in
            onSuccess()
        }
        NetworkController.shared.request(request: request, onSuccess: success, onError: onError)
    }
    
    
    func addCurrencySubscription(categoryId: Int, sourceId: Int, onSuccess: @escaping ()->Void, onError: @escaping (Error)->Void){
        let json : JSON = ["categoryId" : categoryId as AnyObject, "sourceId" : sourceId as AnyObject]
        let request = bankDataDownloadService.createJsonRequest(strUrl: ApiURL.strUrlCurrencySubscription.rawValue, json: json, httpMethod: HttpMethod.post)!
        let success : (JSON, URLResponse)->Void = { (jsonArray, _) in
            onSuccess()
        }
        NetworkController.shared.request(request: request, onSuccess: success, onError: onError)
    }
    
    func deleteCurrencySubscription(categoryId: Int, sourceId: Int, onSuccess: @escaping ()->Void, onError: @escaping (Error)->Void){
        let strUrl = ApiURL.strUrlCurrencySubscription.rawValue
        let parameters = [("categoryId", categoryId as AnyObject), ("sourceId", sourceId as AnyObject)]
        let request = bankDataDownloadService.createJsonRequest(strUrl: strUrl, parameters: parameters, json: nil, httpMethod: HttpMethod.delete)!
        let success : (JSON, URLResponse)->Void = { (jsonArray, _) in
            onSuccess()
        }
        NetworkController.shared.request(request: request, onSuccess: success, onError: onError)
    }
    
    private func loadingCurrencySubscription(onSuccess: @escaping ([Currency])->Void, onError: @escaping (Error)->Void){
        let url = URL(string: ApiURL.strUrlCurrencySubscription.rawValue)!
        let request = URLRequest(url: url)
        let success : (JSON, URLResponse)->Void = { (jsonArray, _) in
            let jsonCurrencies = jsonArray["subscriptionCategories"] as? JSONArray
            let currencies: [Currency] = jsonCurrencies!.map(Currency.init)
            onSuccess(currencies)
        }
        NetworkController.shared.request(request: request, onSuccess: success, onError: onError)
    }
}
