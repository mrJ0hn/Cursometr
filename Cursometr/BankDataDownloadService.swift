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

class BankDataDownloadService {
    var isCookiesLoad = false

    enum ApiURL: String{
        case strUrlAuthentication = "http://currency.btc-solutions.ru:8080/api/Account"
        case strUrlCurrencySubscription = "http://currency.btc-solutions.ru:8080/api/CurrencySubscription"
        case strUrlCurrencyList = "http://currency.btc-solutions.ru:8080/api/CurrencyList"
        case strURLFeedback = "http://currency.btc-solutions.ru:8080/api/Feedback"
        case strUrlCategory = "http://currency.btc-solutions.ru:8080/api/Category"
    }
    
    enum HttpMethod: String{
        case post = "POST"
        case delete = "DELETE"
    }
    
    func getCookies(onSuccess: @escaping ()->()){
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
        NetworkController.shared.request(request: request, onSuccess: success, onError: error)
    }
    
    func createJsonRequest(strUrl: String, json: JSON?, httpMethod: HttpMethod) -> URLRequest?
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
    
    func setCookies(response: URLResponse?){
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
