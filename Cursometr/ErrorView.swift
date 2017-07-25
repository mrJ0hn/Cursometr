//
//  ErrorView.swift
//  Cursometr
//
//  Created by iMacAir on 21.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import UIKit

class ErrorView: UIView {
    var labelTitle = UILabel()
    let timeDelay: Double = 2
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
    }
    
    func initialize(){
        self.backgroundColor = Constatns.Color.pink
        
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.font.withSize(13)
        labelTitle.textAlignment = NSTextAlignment.center
        labelTitle.textColor = UIColor.white
        self.addSubview(labelTitle)
        labelTitle.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        labelTitle.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16).isActive = true
        labelTitle.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16).isActive = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(tapGesture)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + timeDelay) {
            self.removeFromSuperview()
        }
    }
    
    func handleTap() {
        self.removeFromSuperview()
    }
    
    func configure(title: String){
        labelTitle.text = title
    }
}
