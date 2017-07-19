//
//  CurrencyListService.swift
//  Cursometr
//
//  Created by iMacAir on 18.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import UIKit

class CurrencyListService: BankDataDownloadService{
    static let shared = CurrencyListService()
    var allCurrencies : [Currency]?
    
    func getCurrencyList(onSuccess: @escaping ([Currency])->Void)
    {
//        if allCurrencies != nil {
//            onSuccess(allCurrencies!)
//            return
//        }
        if !isCookiesLoad{
            getCookies(onSuccess: {
                self.loadingCurrencyList(onSuccess: { (currencies) in
                    self.allCurrencies = currencies
                    onSuccess(currencies)
                })
                self.isCookiesLoad = true
            })
        }
        else{
            loadingCurrencyList(onSuccess: { (currencies) in
                onSuccess(currencies)
            })
        }
    }
    
    private func loadingCurrencyList(onSuccess: @escaping (([Currency])->Void))
    {
        let userId = UIDevice.current.identifierForVendor!.uuidString.replacingOccurrences(of: "-", with: "")
        let json : JSON = ["userId" : userId as AnyObject]
        let request = createJsonRequest(strUrl: ApiURL.strUrlCurrencyList.rawValue, json: json,
                                        httpMethod: HttpMethod.post)!
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
