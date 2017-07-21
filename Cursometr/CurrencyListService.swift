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
    var bankDataDownloadService : BankDataDownloadService!
    var allCurrencies : [Currency] = []
    
    class var shared: CurrencyListService{
        return instance
    }
    
    class func initialize(dependency: BankDataDownloadService){
        guard self.instance == nil else {
            return
        }
        instance = CurrencyListService(bankDataDownloadService: dependency)
    }
    
    private init(bankDataDownloadService : BankDataDownloadService){
        self.bankDataDownloadService = bankDataDownloadService
    }
    
    func obtainCurrencyList(onSuccess: @escaping ([Currency])->Void)
    {
        if allCurrencies.count>0{
            onSuccess(allCurrencies)
            return
        }
        if !BankDataDownloadService.isCookiesLoad{
            bankDataDownloadService.obtainCookies(onSuccess: { //weak
                self.loadingCurrencyList(onSuccess: { (currencies) in
                    self.allCurrencies = currencies
                    onSuccess(currencies)
                })
            })
        }
        else{
            loadingCurrencyList(onSuccess: { (currencies) in
                self.allCurrencies = currencies
                onSuccess(currencies)
            })
        }
    }
    
    private func loadingCurrencyList(onSuccess: @escaping (([Currency])->Void))
    {
        let userId = UIDevice.current.identifierForVendor!.uuidString.replacingOccurrences(of: "-", with: "")
        let json : JSON = ["userId" : userId as AnyObject]
        let request = bankDataDownloadService.createJsonRequest(strUrl: ApiURL.strUrlCurrencyList.rawValue, json: json, httpMethod: HttpMethod.post)!
        let success : (JSON, URLResponse)->Void = { (jsonArray, _) in
            let jsonCurrencies = jsonArray["currencies"] as? JSONArray
            let currencies: [Currency] = jsonCurrencies!.map(Currency.init)
            onSuccess(currencies)
        }
        let error : (Error) -> Void = {(error) in
            print(error)
        }
        NetworkController.shared.request(request: request, onSuccess: success, onError: error)
    }
}
