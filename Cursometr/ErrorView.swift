//
//  ErrorView.swift
//  Cursometr
//
//  Created by iMacAir on 21.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import UIKit

class ErrorView: UIView {
    var lblTitle = UILabel()
    let timeDelay: Double = 2
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setConfig()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setConfig(){
        self.backgroundColor = Constatns.Color.pink
        
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        lblTitle.font.withSize(13)
        lblTitle.textAlignment = NSTextAlignment.center
        lblTitle.textColor = UIColor.white
        self.addSubview(lblTitle)
        lblTitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        lblTitle.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        lblTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16).isActive = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(tapGesture)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + timeDelay) {
            self.removeFromSuperview()
        }
    }
    
    func handleTap() {
        self.removeFromSuperview()
    }
    
    func set(title: String){
        lblTitle.text = title
    }
}
