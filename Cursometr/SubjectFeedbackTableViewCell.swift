//
//  FeedbackSubjectTableViewCell.swift
//  Cursometr
//
//  Created by iMacAir on 11.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import UIKit

class SubjectFeedbackTableViewCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var checkBox: CheckBox!
    var firstSelected : Bool = true
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        label.textColor = isSelected ? UIColor.white : UIColor.gray
        checkBox.setStatus(isChecked: isSelected)
    }
    
    func configure(title: String, isSelected: Bool) {
        label.text = title
    }
}
