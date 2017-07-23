//
//  SendFeedbackService.swift
//  Cursometr
//
//  Created by iMacAir on 18.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import Foundation

class SendFeedbackService{
    private static var instance: SendFeedbackService!
    var bankDataDownloadService: BankDataDownloadService!
    
    class var shared: SendFeedbackService{
        return instance
    }
    
    class func initialize(dependency: BankDataDownloadService){
        guard self.instance == nil else {
            return
        }
        self.instance = SendFeedbackService(bankDataDownloadService: dependency)
    }
    
    private init(bankDataDownloadService: BankDataDownloadService){
        self.bankDataDownloadService = bankDataDownloadService
    }
    
    func sendFeedback(title: String, body: String, onSuccess: @escaping () -> Void, onError: @escaping (Error)->Void){
        let json : JSON = ["title" : title as AnyObject, "body" : body as AnyObject]
        let request = bankDataDownloadService.createJsonRequest(strUrl: ApiURL.strURLFeedback.rawValue, json: json, httpMethod: HttpMethod.post)!
        let success : (JSON, URLResponse)->Void = { (jsonArray, _) in
            onSuccess()
        }
        NetworkController.shared.request(request: request, onSuccess: success, onError: onError)
    }
}
