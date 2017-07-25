//
//  CornerRadiusView.swift
//  Cursometr
//
//  Created by iMacAir on 25.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import UIKit

class CornerRadiusView: UIView {
    var valueCornerRadius : CGFloat = 0
    var positionCornerRadius : UIRectCorner!
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configure(positionCornerRadius: UIRectCorner, valueCornerRadius: CGFloat){
        self.valueCornerRadius = valueCornerRadius
        self.positionCornerRadius = positionCornerRadius
    }
    
    override func draw(_ rect: CGRect) {
        super.draw(rect)
        self.roundCorners(positionCornerRadius, radius: valueCornerRadius)
    }

    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: self.bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        self.layer.mask = mask
    }
}
