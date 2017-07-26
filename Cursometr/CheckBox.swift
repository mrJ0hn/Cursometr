//
//  CustomCheckBox.swift
//  Cursometr
//
//  Created by iMacAir on 13.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import UIKit

class CheckBox: UIImageView {
    let checkedImage = #imageLiteral(resourceName: "icn_checkmark")
    
    var isChecked: Bool = false {
        didSet{
            if isChecked == true {
                self.image = checkedImage
            } else {
                self.image = nil
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
