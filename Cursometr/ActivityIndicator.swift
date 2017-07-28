//
//  ActivityIndicator.swift
//  Cursometr
//
//  Created by iMacAir on 25.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import UIKit

class ActivityIndicator: UIView {
    let activityIndicator = UIActivityIndicatorView()
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
        super.init(coder: coder)!
    }
    
    func initialize(){
        self.backgroundColor = Constatns.Color.viewFlipsideBackgroundColor
        activityIndicator.frame	= CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        self.addSubview(activityIndicator)
    }
    
    func startAnimating() {
        self.frame = (delegate.window?.frame)!
        activityIndicator.center = self.center
        activityIndicator.startAnimating()
    }
    
    func stopAnimating() {
        activityIndicator.stopAnimating()
        self.removeFromSuperview()
    }
}
