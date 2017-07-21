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
    
    
    func obtainCurrencySubscription(onSuccess: @escaping ([Currency])->Void){
        if !BankDataDownloadService.isCookiesLoad{
            bankDataDownloadService.obtainCookies(onSuccess: {
                self.loadingCurrencySubscription(onSuccess: {(currencies) in
                    self.curCurrencies = currencies
                    onSuccess(currencies)
                })
            })
        }
        else{
            loadingCurrencySubscription(onSuccess: {(currencies) in
                onSuccess(currencies)
            })
        }
    }
    
    func changeCurrencySubscription(categoryId: Int, subscriptions: [Subscription], deleteAll: Bool = false){
        NotificationCenter.default.post(name: .StartLoadingCurrencySubscription, object: nil)
        if deleteAll{
            group.enter()
            self.deleteCategory(categoryId: categoryId, onSuccess: {
                self.group.leave()
            })
        }
        for data in subscriptions{
            switch data.action{
            case .add:
                group.enter()
                self.addCategory(categoryId: categoryId, onSuccess: {
                    self.group.leave()
                })
                group.enter()
                self.addCurrencySubscription(categoryId: categoryId, sourceId: data.sourceId, onSuccess: {
                    self.group.leave()
                })
            case .delete:
                group.enter()
                self.deleteCurrencySubscription(categoryId: categoryId, sourceId: data.sourceId, onSuccess: {
                    self.group.leave()
                })
            }
        }
        group.notify(queue: DispatchQueue.main){
            NotificationCenter.default.post(name: .FinishLoadingCurrencySubscription, object: nil)
        }
    }
    
    func addCategory(categoryId: Int, onSuccess: @escaping ()->()){
        let strUtl = ApiURL.strUrlCategory.rawValue
        let parameters = [("categoryId", categoryId as AnyObject)]
        let request = bankDataDownloadService.createJsonRequest(strUrl: strUtl, parameters: parameters, json: nil, httpMethod: HttpMethod.post)!
        let success : (JSON, URLResponse)->Void = { (jsonArray, _) in
            print(jsonArray)
            onSuccess()
        }
        let error : (Error) -> Void = {(error) in
            print(error)
        }
        NetworkController.shared.request(request: request, onSuccess: success, onError: error)
    }
    
    func deleteCategory(categoryId: Int, onSuccess: @escaping ()->()){
        let strUtl = ApiURL.strUrlCategory.rawValue
        let parameters = [("categoryId", categoryId as AnyObject)]
        let request = bankDataDownloadService.createJsonRequest(strUrl: strUtl, parameters: parameters, json: nil, httpMethod: HttpMethod.delete)!
        let success : (JSON, URLResponse)->Void = { (jsonArray, _) in
            print(jsonArray)
            onSuccess()
        }
        let error : (Error) -> Void = {(error) in
            print(error)
        }
        NetworkController.shared.request(request: request, onSuccess: success, onError: error)
    }
    
    
    func addCurrencySubscription(categoryId: Int, sourceId: Int, onSuccess: @escaping ()->()){
        let json : JSON = ["categoryId" : categoryId as AnyObject, "sourceId" : sourceId as AnyObject]
        let request = bankDataDownloadService.createJsonRequest(strUrl: ApiURL.strUrlCurrencySubscription.rawValue, json: json, httpMethod: HttpMethod.post)!
        let success : (JSON, URLResponse)->Void = { (jsonArray, _) in
            print(jsonArray)
            onSuccess()
        }
        let error : (Error) -> Void = {(error) in
            print(error)
        }
        NetworkController.shared.request(request: request, onSuccess: success, onError: error)
    }
    
    func deleteCurrencySubscription(categoryId: Int, sourceId: Int, onSuccess: @escaping ()->()){
        let strUrl = ApiURL.strUrlCurrencySubscription.rawValue
        let parameters = [("categoryId", categoryId as AnyObject), ("sourceId", sourceId as AnyObject)]
        let request = bankDataDownloadService.createJsonRequest(strUrl: strUrl, parameters: parameters, json: nil, httpMethod: HttpMethod.delete)!
        let success : (JSON, URLResponse)->Void = { (jsonArray, _) in
            print(jsonArray)
            onSuccess()
        }
        let error : (Error) -> Void = {(error) in
            print(error)
        }
        NetworkController.shared.request(request: request, onSuccess: success, onError: error)
    }
    
    private func loadingCurrencySubscription(onSuccess: @escaping (([Currency])->Void)){
        let url = URL(string: ApiURL.strUrlCurrencySubscription.rawValue)!
        let request = URLRequest(url: url)
        let success : (JSON, URLResponse)->Void = { (jsonArray, _) in
            let jsonCurrencies = jsonArray["subscriptionCategories"] as? JSONArray
            let currencies: [Currency] = jsonCurrencies!.map(Currency.init)
            onSuccess(currencies)
        }
        let error : (Error) -> Void = {(error) in
            print(error)
        }
        NetworkController.shared.request(request: request, onSuccess: success, onError: error)
    }
}
