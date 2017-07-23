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
    @IBOutlet weak var lblTitle: UILabel!
    var callback: ((UITableViewCell) -> Void)?
    var state : Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        switchSelectedCost.addTarget(self, action: #selector(stateChange), for: UIControlEvents.valueChanged)
        let separatorLayer = CALayer()
        separatorLayer.backgroundColor = UIColor.black.cgColor
        self.contentView.layer.addSublayer(separatorLayer)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func set(title: String){
        lblTitle.text = title
    }
    
    func stateChange(switchState: UISwitch){
        state = switchState.isOn
        callback!(self)
        if switchState.isOn{
            lblTitle.textColor = Constatns.Color.aqua
        }
        else{
            lblTitle.textColor = UIColor.gray
        }
    }
}
