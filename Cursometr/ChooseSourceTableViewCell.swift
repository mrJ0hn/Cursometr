//
//  ChooseSourceTableViewCell.swift
//  Cursometr
//
//  Created by iMacAir on 16.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import UIKit

class ChooseSourceTableViewCell: UITableViewCell {

    @IBOutlet weak var switchIsSelected: UISwitch!
    @IBOutlet weak var lblExchange: UILabel!
    var callback: ((UITableViewCell) -> Void)?

    
    override func awakeFromNib() {
        super.awakeFromNib()
        switchIsSelected.addTarget(self, action: #selector(stateChange), for: UIControlEvents.valueChanged)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }

    func setConfig(exchange: Exchange){
        lblExchange.text = exchange.name
        if exchange.subscribed{
            switchIsSelected.setOn(true, animated: false)
            lblExchange.textColor = Constatns.Color.aqua
        }
    }
    
    func stateChange(switchState: UISwitch){
        callback!(self)
        if switchState.isOn{
            lblExchange.textColor = Constatns.Color.aqua
        }
        else{
            lblExchange.textColor = UIColor.gray
        }
    }
}
