//
//  BankDataDownloadService.swift
//  Cursometr
//
//  Created by iMacAir on 10.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import UIKit

class AuthorizationService {
    static let shared = AuthorizationService()
    var isCookiesLoad = false
    
    private init() {}
    
    func loginIfNecessary(onSuccess: @escaping Action, onError: @escaping ErrorAction){
        if isCookiesLoad{
            onSuccess()
        }else {
            let userId = UIDevice.current.identifierForVendor!.uuidString.replacingOccurrences(of: "-", with: "")
            print(userId)
            let json : JSON = ["userId" : userId as AnyObject]
            let url = URL(string: ApiURL.strUrlAuthentication.rawValue)!
            let onSuccess : (JSON, URLResponse)->Void = { [weak self] (_, response) in
                self?.setCookies(response: response)
                self?.isCookiesLoad = true
                onSuccess()
            }
            NetworkController.request(endpoint: url, query: nil, body: json, httpMethod: .post, onSuccess: onSuccess, onError: onError)
        }
    }
    
    private func setCookies(response: URLResponse?) {
        if let httpResponce = response as? HTTPURLResponse{
            if let url = httpResponce.url,
                let allHeaderFiels = httpResponce.allHeaderFields as? [String:String]{
                let cookies = HTTPCookie.cookies(withResponseHeaderFields: allHeaderFiels, for: url)
                for cookie in cookies {
                    HTTPCookieStorage.shared.setCookie(cookie)
                }
            }
        }
    }
}
