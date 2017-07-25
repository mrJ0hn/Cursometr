//
//  CustomCheckBox.swift
//  Cursometr
//
//  Created by iMacAir on 13.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import UIKit

class CheckBox: UIButton {
    let checkedImage = #imageLiteral(resourceName: "icn_checkmark")
    
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.setImage(checkedImage, for: UIControlState.normal)
            } else {
                self.setImage(nil, for: UIControlState.normal)
            }
        }
    }
    
    override func awakeFromNib() { 
        self.isChecked = false
    }
    
    func changeStatus(){
        isChecked = !isChecked
    }
    
    func setStatus(isChecked : Bool){
        self.isChecked = isChecked
    }

}
