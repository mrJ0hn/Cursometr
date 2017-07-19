//
//  SendFeedbackService.swift
//  Cursometr
//
//  Created by iMacAir on 18.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import Foundation

class SendFeedbackService : BankDataDownloadService{
    static let shared = SendFeedbackService()
    func sendFeedback(title: String, body: String, onSuccess: @escaping ()->()){
        let json : JSON = ["title" : title as AnyObject, "body" : body as AnyObject]
        let request = createJsonRequest(strUrl: ApiURL.strURLFeedback.rawValue, json: json, httpMethod: HttpMethod.post)!
        let success : (JSON, URLResponse)->Void = { (jsonArray, _) in
            onSuccess()
        }
        let error : (Error) -> Void = {(error) in
            print(error)
        }
        NetworkController.shared.request(request: request, onSuccess: success, onError: error)
    }
}
