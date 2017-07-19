//
//  NetworkController.swift
//  Cursometr
//
//  Created by iMacAir on 17.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import Foundation

class NetworkController {
    static let shared = NetworkController()
    //let queue = DispatchQueue.global()
    //var item: DispatchWorkItem!
    
    func request(request: URLRequest, onSuccess: @escaping ((JSON, URLResponse)->Void), onError: @escaping ((Error)->Void)){
        let task = URLSession.shared.dataTask(with: request){
            (data, response, error) in
            guard error == nil else {
                onError(error!)
                return
            }
            print(request)
            sleep(2)
            if let usableData = data{
                do{
                    let jsonArray: JSON = try JSONSerialization.jsonObject(with: usableData, options: []) as! JSON
                    onSuccess(jsonArray, response!)
                }
                catch{
                    onError(error)
                }
            }
            //self.item = nil
        }
        //item = DispatchWorkItem{
            task.resume()
        //}
        //queue.sync(execute: item)
    }
}
