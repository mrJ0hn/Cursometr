//
//  SendFeedbackService.swift
//  Cursometr
//
//  Created by iMacAir on 18.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import Foundation

class SendFeedbackService{
    static func sendFeedback(title: String, body: String, onSuccess: @escaping Action, onError: @escaping ErrorAction){
        let url = URL(string: ApiURL.strURLFeedback.rawValue)!
        let json : JSON = ["title" : title as AnyObject, "body" : body as AnyObject]
        let onSuccess : (JSON, URLResponse)->Void = { (jsonArray, _) in
            print(jsonArray)
            onSuccess()
        }
        NetworkController.request(endpoint: url, query: nil, body: json, httpMethod: .post, onSuccess: onSuccess, onError: onError)
    }
}
