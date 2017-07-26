//
//  ChooseSourceTableViewCell.swift
//  Cursometr
//
//  Created by iMacAir on 16.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import UIKit

class ChooseCurrencyTableViewCell: UITableViewCell {
    @IBOutlet weak var switchIsSelected: UISwitch!
    @IBOutlet weak var labelExchange: UILabel!
    var onStateChange: ((UITableViewCell) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        switchIsSelected.addTarget(self, action: #selector(stateChange), for: UIControlEvents.valueChanged)
    }

    func configure(exchange: Exchange){
        labelExchange.text = exchange.name
        if exchange.subscribed{
            switchIsSelected.setOn(true, animated: false)
            labelExchange.textColor = Constatns.Color.aqua
        }
    }
    
    func stateChange(switchState: UISwitch){
        onStateChange!(self)
        if switchState.isOn{
            labelExchange.textColor = Constatns.Color.aqua
        }
        else{
            labelExchange.textColor = UIColor.gray
        }
    }
}
