//
//  BankDataDownloadService.swift
//  Cursometr
//
//  Created by iMacAir on 10.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import UIKit

typealias JSONArray = [JSON]
typealias JSON = [String:AnyObject]

class BankDataDownloadService{
    
    enum ApiURL: String{
        case strUrlAuthentication = "http://currency.btc-solutions.ru:8080/api/Account"
        case strUrlCurrencySubscription = "http://currency.btc-solutions.ru:8080/api/CurrencySubscription"
        case strUrlCurrencyList = "http://currency.btc-solutions.ru:8080/api/CurrencyList"
    }
    
    var isCookiesLoad = false
    
    func getCurrencySubscription(onSuccess: @escaping (([Currency])->Void)){
        if !isCookiesLoad{
            getCookies(onSuccess: {
                self.loadingCurrencySubscription(onSuccess: {(currencies) in
                    onSuccess(currencies)
                })
            })
            isCookiesLoad = true
        }
        else{
            loadingCurrencySubscription(onSuccess: {(currencies) in
                onSuccess(currencies)
            })
        }

    }
    
    func getCurrencyList(onSuccess: @escaping (([Currency])->Void))
    {
        if !isCookiesLoad{
            getCookies(onSuccess: {
                self.loadingCurrencyList(onSuccess: { (currencies) in
                    onSuccess(currencies)
                })
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
        let request = createPostRequest(strUrl: ApiURL.strUrlCurrencyList.rawValue)!
        let task = URLSession.shared.dataTask(with: request){
            (data, response, error) in
            guard error == nil else {
                return
            }
            if let usableData = data{
                do{
                    let jsonArray: JSON = try JSONSerialization.jsonObject(with: usableData, options: []) as! JSON
                    let jsonCurrencies = jsonArray["currencies"] as? JSONArray
                    let currencies: [Currency] = jsonCurrencies!.map(Currency.init)
                    onSuccess(currencies)
                }
                catch let error{
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    private func loadingCurrencySubscription(onSuccess: @escaping (([Currency])->Void)){
        let url = URL(string: ApiURL.strUrlCurrencySubscription.rawValue)!
        let task = URLSession.shared.dataTask(with: url){
            (data, response, error) in
            guard error == nil else {
                return
            }
            if let usableData = data{
                do{
                    let jsonArray: JSON = try JSONSerialization.jsonObject(with: usableData, options: []) as! JSON
                    //print(jsonArray)
                    let jsonCurrencies = jsonArray["subscriptionCategories"] as? JSONArray
                    let currencies: [Currency] = jsonCurrencies!.map(Currency.init)
                    onSuccess(currencies)
                }
                catch let error{
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    private func getCookies(onSuccess: @escaping (()->Void)){
        
        let request = createPostRequest(strUrl: ApiURL.strUrlAuthentication.rawValue)!
        let task = URLSession.shared.dataTask(with: request){
            (data, response, error) in
            guard error == nil else {
                return
            }
            if let usableData = data{
                do{
                    let jsonArray: JSON = try JSONSerialization.jsonObject(with: usableData, options: []) as! JSON
                    print(jsonArray)
                    self.setCookies(response: response!)
                    onSuccess()
                }
                catch let error{
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    private func createPostRequest(strUrl: String) -> URLRequest?
    {
        let userId = UIDevice.current.identifierForVendor!.uuidString.replacingOccurrences(of: "-", with: "")
        print(userId)
        let rowJson : [String:String] = ["userId" : userId]
        let url = URL(string: strUrl)!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        do{
            request.httpBody = try JSONSerialization.data(withJSONObject: rowJson, options: .prettyPrinted)
        }
        catch let error{
            print(error)
            return nil
        }
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        return request
    }
    
    private func setCookies(response: URLResponse?){
        if let httpResponce = response as? HTTPURLResponse{
            if let url = httpResponce.url,
                let allHeaderFiels = httpResponce.allHeaderFields as? [String:String]{
                let cookies = HTTPCookie.cookies(withResponseHeaderFields: allHeaderFiels, for: url)
                for cookie in cookies{
                    HTTPCookieStorage.shared.setCookie(cookie)
                }
            }
        }
    }
}
