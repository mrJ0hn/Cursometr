////: Playground - noun: a place where people can play
//
//import Foundation
//import PlaygroundSupport
//import UIKit
//
//typealias JSONArray = [JSON]
//typealias JSON = [String:AnyObject]
//
//var strUrlAuthentication = "http://currency.btc-solutions.ru:8080/api/Account"
//var strUrlData = "http://currency.btc-solutions.ru:8080/api/CurrencyList"
//
//func storeCookies() {
//    let cookiesStorage = HTTPCookieStorage.shared
//    let userDefaults = UserDefaults.standard
//    
//    let serverBaseUrl = urlAuthentication
//    var cookieDict = [String : AnyObject]()
//    
//    for cookie in cookiesStorage.cookies(for: NSURL(string: serverBaseUrl)! as URL)! {
//        cookieDict[cookie.name] = cookie.properties as AnyObject?
//    }
//    
//    userDefaults.set(cookieDict, forKey: "cookiesKey")
//}
//
//storeCookies()
//
//let urlData = URL(string: strUrlData)!
//let task = URLSession.shared.dataTask(with: urlData){
//    (data, response, error) in
//    guard error == nil else{
//        return
//    }
//    if let usableData = data {
//        do{
//            let jsonArray: JSONArray = try JSONSerialization.jsonObject(with: usableData, options: []) as! JSONArray
//        }
//        catch{
//            
//        }
//    }
//}
//
//task.resume()
