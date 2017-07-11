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
        case strUrlData = "http://currency.btc-solutions.ru:8080/api/CurrencyList"
    }
    
    func getData(onSuccess: @escaping (([Currency])->Void))
    {
        getCookies(onSuccess: {
            self.loadingJsonToData(strURL: ApiURL.strUrlData.rawValue, onSuccess: { (currencies) in
                onSuccess(currencies)
            })
        })
    }
    
    func loadingJsonToData(strURL: String, onSuccess: @escaping (([Currency])->Void))
    {
        //https://code.bradymower.com/swift-3-apis-network-requests-json-getting-the-data-4aaae8a5efc0
        //let url = URL(string: strURL)!
        let request = createPostRequest(strUrl: ApiURL.strUrlData.rawValue)!
        let task = URLSession.shared.dataTask(with: request){
            (data, response, error) in
            guard error == nil else {
                //onError?(error!)
                return
            }
            if let usableData = data{
                do{
                    //print(response)
                    let jsonArray: JSON = try JSONSerialization.jsonObject(with: usableData, options: []) as! JSON
                    //print(jsonArray)
                    let jsonCurrencies = jsonArray["currencies"] as? JSONArray
                    let currencies: [Currency] = jsonCurrencies!.map(Currency.init)
                    onSuccess(currencies)
                    //print(jsonCurrencies)
                    //onSuccess(repositories)
                }
                catch let error{
                    //onError?(error)
                    print(error)
                }
            }
        }
        task.resume()
    }
    
    private func getCookies( onSuccess: @escaping (()->Void)){
        
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
        let rowJson : [String:String] = ["userId" : "1"]
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
                HTTPCookieStorage.shared.setCookie(cookies[1])
            }
        }
    }
}
