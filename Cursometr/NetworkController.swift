//
//  NetworkController.swift
//  Cursometr
//
//  Created by iMacAir on 17.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import Foundation

enum HttpMethod: String{
    case post = "POST"
    case delete = "DELETE"
    case get = "GET"
}

class NetworkController {
    private init(){}
    
    static func request(endpoint: URL, query: JSON? = nil, body: JSON? = nil, httpMethod: HttpMethod,
                 onSuccess: @escaping ((JSON, URLResponse)->Void), onError: @escaping ErrorAction){
        let request = createRequest(url: endpoint, query: query, body: body, httpMethod: httpMethod)!
        let task = URLSession.shared.dataTask(with: request){(data, response, error) in
            guard error == nil else {
                onError(error!)
                return
            }
            sleep(1)
            print("\(request) \(httpMethod)")
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
    
    private static func createRequest(url: URL, query: JSON? = nil, body: JSON? = nil, httpMethod: HttpMethod) -> URLRequest?
    {
        var url = url
        if let query = query, !query.isEmpty {
            var parameters = String()
            for (name, value) in query {
                parameters += parameters.isEmpty ? "?" : "&"
                parameters += "\(name)=\(value)"
            }
            url=URL(string: url.absoluteString + parameters)!
        }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod.rawValue
        do{
            if body != nil{
                request.httpBody = try JSONSerialization.data(withJSONObject: body!, options: .prettyPrinted)
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
}
