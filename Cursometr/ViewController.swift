//
//  ViewController.swift
//  Cursometr
//
//  Created by iMacAir on 21.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import UIKit

extension UIViewController{
    func showError(error: Error){
        print(error)
        let view = ErrorView(frame: CGRect(x: 0, y: 0, width: self.view.bounds.width, height: 80))
        view.configure(title: error.localizedDescription)
        let delegate = UIApplication.shared.delegate as! AppDelegate
        delegate.window?.addSubview(view)
    }
}
