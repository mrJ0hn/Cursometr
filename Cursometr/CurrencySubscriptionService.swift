//
//  CurrencySubscriptionService.swift
//  Cursometr
//
//  Created by iMacAir on 18.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import Foundation

typealias Subscription = (sourceId: Int, action: CurrencySubscriptionService.ActionUnderCurrencySubscription)

class CurrencySubscriptionService: BankDataDownloadService {
    static let shared = CurrencySubscriptionService()
    let group = DispatchGroup()
    var startLoading : (()->())?
    var finishLoading : (()->())?
    var curCurrencies : [Currency]?
    
    enum ActionUnderCurrencySubscription{
        case delete
        case add
    }
    
    func getCurrencySubscription(onSuccess: @escaping ([Currency])->Void){
        if !isCookiesLoad{
            getCookies(onSuccess: {
                self.loadingCurrencySubscription(onSuccess: {(currencies) in
                    self.curCurrencies = currencies
                    onSuccess(currencies)
                })
                self.isCookiesLoad = true
            })
        }
        else{
            loadingCurrencySubscription(onSuccess: {(currencies) in
                onSuccess(currencies)
            })
        }
    }
    
    func changeCurrencySubscription(categoryId: Int, subscriptions: [Subscription], deleteAll: Bool = false){
        startLoading?()
        if deleteAll{
            group.enter()
            DispatchQueue.global(qos: .utility).asyncAfter(deadline: .now()) {
                self.deleteCategory(categoryId: categoryId, onSuccess: {
                    self.group.leave()
                })
            }
        }
        for data in subscriptions{
            switch data.action{
            case .add:
                group.enter()
                DispatchQueue.global(qos: .utility).asyncAfter(deadline: .now()) {
                    self.addCategory(categoryId: categoryId, onSuccess: {
                        self.group.leave()
                    })
                }
                group.enter()
                DispatchQueue.global(qos: .utility).asyncAfter(deadline: .now()) {
                    self.addCurrencySubscription(categoryId: categoryId, sourceId: data.sourceId, onSuccess: {
                        self.group.leave()
                    })
                }
            case .delete:
                group.enter()
                DispatchQueue.global(qos: .utility).asyncAfter(deadline: .now()) {
                    self.deleteCurrencySubscription(categoryId: categoryId, sourceId: data.sourceId, onSuccess: {
                        self.group.leave()
                    })
                }
            }
        }
        group.notify(queue: DispatchQueue.main){
            self.finishLoading?()
        }
    }
    
    func addCategory(categoryId: Int, onSuccess: @escaping ()->()){
        //let json : JSON = ["categoryId" : categoryId as AnyObject, "sourceId" : sourceId as AnyObject]
        let strUtl = ApiURL.strUrlCategory.rawValue + "?categoryId=\(categoryId)"
        let request = createJsonRequest(strUrl: strUtl, json: nil,
                                        httpMethod: HttpMethod.post)!
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
        //let json : JSON = ["categoryId" : categoryId as AnyObject, "sourceId" : sourceId as AnyObject]
        let strUtl = ApiURL.strUrlCategory.rawValue + "?categoryId=\(categoryId)"
        let request = createJsonRequest(strUrl: strUtl, json: nil,
                                        httpMethod: HttpMethod.delete)!
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
        let request = createJsonRequest(strUrl: ApiURL.strUrlCurrencySubscription.rawValue, json: json,
                                        httpMethod: HttpMethod.post)!
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
        //let json : JSON = ["categoryId" : categoryId as AnyObject, "sourceId" : sourceId as AnyObject]
        let strUrl = ApiURL.strUrlCurrencySubscription.rawValue + "?categoryId=\(categoryId)&sourceId=\(sourceId)"
        let request = createJsonRequest(strUrl: strUrl, json: nil, httpMethod: HttpMethod.delete)!
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
