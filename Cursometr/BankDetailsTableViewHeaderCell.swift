//
//  BankDetailsTableViewHeaderCell.swift
//  Cursometr
//
//  Created by iMacAir on 12.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import UIKit

class BankDetailsTableViewHeaderCell: UITableViewCell {
    @IBOutlet weak var lblTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setConfig(title: String){
        lblTitle.text = title
    }

}
