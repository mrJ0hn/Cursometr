//
//  SwitchCostTableViewCell.swift
//  Cursometr
//
//  Created by iMacAir on 19.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import UIKit

class SwitchCostTableViewCell: UITableViewCell {

    @IBOutlet weak var switchSelectedCost: UISwitch!
    @IBOutlet weak var label: UILabel!
    var onStateChange: ((UITableViewCell) -> Void)?
    var switchState : Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        switchSelectedCost.addTarget(self, action: #selector(stateChange), for: UIControlEvents.valueChanged)
        let separatorLayer = CALayer()
        separatorLayer.backgroundColor = UIColor.black.cgColor
        self.contentView.layer.addSublayer(separatorLayer)
    }
    
    func configure(title: String){
        label.text = title
    }
    
    func stateChange(switchState: UISwitch){
        self.switchState = switchState.isOn
        onStateChange!(self)
        if switchState.isOn{
            label.textColor = Constatns.Color.aqua
        }
        else{
            label.textColor = UIColor.gray
        }
    }
}
