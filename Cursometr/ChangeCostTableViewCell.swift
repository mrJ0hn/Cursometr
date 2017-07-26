//
//  ChangeCostTableViewCell.swift
//  Cursometr
//
//  Created by iMacAir on 19.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import UIKit

class ChangeCostTableViewCell: UITableViewCell {
    @IBOutlet weak var labelCost: UILabel!
    
    var onSelected: ((UITableViewCell)->Void)?
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        onSelected?(self)
    }

    func configure(cost: Double){
        labelCost.text = String(cost)
    }
}
