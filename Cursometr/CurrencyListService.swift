//
//  CurrencyListService.swift
//  Cursometr
//
//  Created by iMacAir on 18.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import UIKit

class CurrencyListService{
    private static var instance: CurrencyListService!
    var authorizationService : AuthorizationService!
    
    class var shared: CurrencyListService{
        return instance
    }
    
    class func initialize(dependency: AuthorizationService){
        guard self.instance == nil else {
            return
        }
        instance = CurrencyListService(authorizationService: dependency)
    }
    
    private init(authorizationService : AuthorizationService){
        self.authorizationService = authorizationService
    }
    
    private init(){}
    
    func obtainCurrencyList(onSuccess: @escaping ([Currency])->Void, onError: @escaping ErrorAction)
    {
        authorizationService.loginIfNecessary(onSuccess: {
            let url = URL(string: ApiURL.strUrlCurrencyList.rawValue)!
            let userId = UIDevice.current.identifierForVendor!.uuidString.replacingOccurrences(of: "-", with: "")
            let json : JSON = ["userId" : userId as AnyObject]
            let onSuccess : (JSON, URLResponse)->Void = {(jsonArray, _) in
                let jsonCurrencies = jsonArray["currencies"] as? JSONArray
                let currencies: [Currency] = jsonCurrencies!.map(Currency.init)
                onSuccess(currencies)
            }
            NetworkController.request(endpoint: url, query: nil, body: json, httpMethod: .post, onSuccess: onSuccess, onError: onError)

        }, onError: onError)
    }
}
