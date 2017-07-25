//
//  CustomTextView.swift
//  Cursometr
//
//  Created by iMacAir on 14.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import UIKit

@IBDesignable
class TextView: UITextView, UITextViewDelegate {
    var isEmptyCallback : ((Bool)->Void)?
    
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

    func textViewDidChange(_ textView: UITextView) {
        isEmptyCallback?(text.isEmpty || textColor ==  UIColor.gray)
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if self.textColor == UIColor.gray{
            self.text = ""
            self.textColor = UIColor.white
        }
    }
}
