//
//  ActivityIndicator.swift
//  Cursometr
//
//  Created by iMacAir on 25.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import UIKit

class ActivityIndicator: UIActivityIndicatorView {
    let delegate = UIApplication.shared.delegate as! AppDelegate
    
    init(){
        super.init(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        initialize()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func initialize(){
        self.frame	= CGRect(x: 0, y: 0, width: 40, height: 40)
        self.hidesWhenStopped = true
        self.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
    }
    
    override func startAnimating() {
        self.center = (delegate.window?.center)!
        super.startAnimating()
    }
    
    override func stopAnimating() {
        super.stopAnimating()
    }
}
