//
//  CustomActivityIndicator.swift
//  Cursometr
//
//  Created by iMacAir on 19.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import UIKit

class CustomActivityIndicator {
    
    var activityIndicator = UIActivityIndicatorView()
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    func get()-> UIActivityIndicatorView{
        activityIndicator.frame	= CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.center = (delegate.window?.center)!
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        return activityIndicator
    }
}
