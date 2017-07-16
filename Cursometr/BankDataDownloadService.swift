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

class NetworkController{
    static func request(request: URLRequest, onSuccess: @escaping ((JSON, URLResponse)->Void), onError: @escaping ((Error)->Void)){
        let task = URLSession.shared.dataTask(with: request){
            (data, response, error) in
            guard error == nil else {
                onError(error!)
                return
            }
            if let usableData = data{
                do{
                    let jsonArray: JSON = try JSONSerialization.jsonObject(with: usableData, options: []) as! JSON
                    onSuccess(jsonArray, response!)
                }
                catch{
                    onError(error)
                }
            }
        }
        task.resume()
    }
}

class BankDataDownloadService {
    static let shared = BankDataDownloadService()
    
    enum ApiURL: String{
        case strUrlAuthentication = "http://currency.btc-solutions.ru:8080/api/Account"
        case strUrlCurrencySubscription = "http://currency.btc-solutions.ru:8080/api/CurrencySubscription"
        case strUrlCurrencyList = "http://currency.btc-solutions.ru:8080/api/CurrencyList"
        case strURLFeedback = "http://currency.btc-solutions.ru:8080/api/Feedback"
    }
    
    enum HttpMethod: String{
        case post = "POST"
        case delete = "DELETE"
    }
    
    var isCookiesLoad = false
    
    func getCurrencySubscription(onSuccess: @escaping ([Currency])->Void){
        if !isCookiesLoad{
            getCookies(onSuccess: {
                self.loadingCurrencySubscription(onSuccess: {(currencies) in
                    onSuccess(currencies)
                    //onSuccess([Currency]())
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
    
    func getCurrencyList(onSuccess: @escaping ([Currency])->Void)
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
    
    func sendFeedback(title: String, body: String, onSuccess: @escaping ()->()){
        let json : JSON = ["title" : title as AnyObject, "body" : body as AnyObject]
        let request = createJsonRequest(strUrl: ApiURL.strURLFeedback.rawValue, json: json, httpMethod: HttpMethod.post)!
        let success : (JSON, URLResponse)->Void = { (jsonArray, _) in
            print(jsonArray)
            onSuccess()
        }
        let error : (Error) -> Void = {(error) in
            print(error)
        }
        NetworkController.request(request: request, onSuccess: success, onError: error)
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
        NetworkController.request(request: request, onSuccess: success, onError: error)
    }
    
    func deleteCurrencySubscription(categoryId: Int, sourceId: Int, onSuccess: @escaping ()->()){
        let json : JSON = ["categoryId" : categoryId as AnyObject, "sourceId" : sourceId as AnyObject]
        let request = createJsonRequest(strUrl: ApiURL.strUrlCurrencySubscription.rawValue, json: json,
                                        httpMethod: HttpMethod.delete)!
        let success : (JSON, URLResponse)->Void = { (jsonArray, _) in
            print(jsonArray)
            onSuccess()
        }
        let error : (Error) -> Void = {(error) in
            print(error)
        }
        NetworkController.request(request: request, onSuccess: success, onError: error)
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
        NetworkController.request(request: request, onSuccess: success, onError: error)
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
        NetworkController.request(request: request, onSuccess: success, onError: error)
    }
    
    private func getCookies(onSuccess: @escaping (()->Void)){
        let userId = UIDevice.current.identifierForVendor!.uuidString.replacingOccurrences(of: "-", with: "")
        print(userId)
        let json : JSON = ["userId" : userId as AnyObject]
        let request = createJsonRequest(strUrl: ApiURL.strUrlAuthentication.rawValue, json: json,
                                        httpMethod: HttpMethod.post)!
        let success : (JSON, URLResponse)->Void = { (_, response) in
            self.setCookies(response: response)
            onSuccess()
        }
        let error : (Error) -> Void = {(error) in
            print(error)
        }
        NetworkController.request(request: request, onSuccess: success, onError: error)
    }
    
    private func createJsonRequest(strUrl: String, json: JSON?, httpMethod: HttpMethod) -> URLRequest?
    {
        let url = URL(string: strUrl)!
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        do{
            if json != nil{
                request.httpBody = try JSONSerialization.data(withJSONObject: json!, options: .prettyPrinted)
            }
        }
        catch{
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
