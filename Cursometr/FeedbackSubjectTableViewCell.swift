//
//  FeedbackSubjectTableViewCell.swift
//  Cursometr
//
//  Created by iMacAir on 11.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import UIKit

class FeedbackSubjectTableViewCell: UITableViewCell {
    
    @IBOutlet weak var chkBxIsSelected: CustomCheckBox!
    @IBOutlet weak var lblTitle: UILabel!
    
    var lastSelectedCell : CustomCheckBox? = nil
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setSelected(){
        lblTitle.textColor = UIColor.white
        chkBxIsSelected.setStatus(isChecked: true)
    }

    func setConfig(title: String){
        lblTitle.text = title
    }
    
    
}
