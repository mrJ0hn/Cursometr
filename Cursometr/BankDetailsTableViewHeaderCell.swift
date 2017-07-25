//
//  BankDetailsTableViewHeaderCell.swift
//  Cursometr
//
//  Created by iMacAir on 12.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import UIKit

class BankDetailsTableViewHeaderCell: UITableViewCell {
    @IBOutlet weak var label: UILabel!
    
    func configure(title: String){
        label.text = title
    }
}
