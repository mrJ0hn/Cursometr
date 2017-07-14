//
//  QuotationsTableViewCell.swift
//  Cursometr
//
//  Created by iMacAir on 14.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import UIKit

class QuotationsTableViewCell: UITableViewCell {
    @IBOutlet weak var lblSubscribedExchanges: UILabel!
    @IBOutlet weak var lblCurrency: UILabel!
    @IBOutlet weak var imgViewCurrencyIsSelected: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imgViewCurrencyIsSelected.isHidden = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setConfig(currency: Currency){
        lblCurrency.text = currency.fullName
        for exchange in currency.sources{
            if exchange.subscribed{
                if !(lblSubscribedExchanges.text?.isEmpty)!{
                    lblSubscribedExchanges.text = "\(lblSubscribedExchanges.text!), \(exchange.name)"
                }
                else{
                    lblSubscribedExchanges.text = exchange.name
                    imgViewCurrencyIsSelected.isHidden = false
                }
            }
        }
    }
    
}
