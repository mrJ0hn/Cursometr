//
//  SetNotificationsTableViewHeader.swift
//  Cursometr
//
//  Created by iMacAir on 20.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import UIKit

class SetNotificationsTableViewHeader: UIView {
    var label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    convenience init() {
        self.init(frame: CGRect.zero)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("This class does not support NSCoding")
    }
    
    func initialize() {
        self.backgroundColor = Constatns.Color.viewFlipsideBackgroundColor
        label.font = UIFont(name: label.font.fontName, size: 22)
        label.textColor = UIColor.white
        self.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints=false
        label.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16).isActive = true
        label.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 16).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
    
    func set(title: String){
        label.text = title
    }
}
