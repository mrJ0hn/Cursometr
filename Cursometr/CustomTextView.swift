//
//  CustomTextView.swift
//  Cursometr
//
//  Created by iMacAir on 14.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import UIKit

@IBDesignable
class CustomTextView: UITextView, UITextViewDelegate {
    
    
    @IBInspectable var strPlaceholder = "Placeholder"{
        didSet{
            self.text = strPlaceholder
        }
    }
    
    override func awakeFromNib() {
        self.text = strPlaceholder
        self.textColor =  UIColor.gray
        self.delegate = self
    }

    func textViewDidBeginEditing(_ textView: UITextView) {
        if self.textColor == UIColor.gray{
            self.text = ""
            self.textColor = Constatns.Color.gray
        }
    }
}
