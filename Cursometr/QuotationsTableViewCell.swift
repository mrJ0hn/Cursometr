//
//  QuotationsTableViewCell.swift
//  Cursometr
//
//  Created by iMacAir on 14.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import UIKit

class QuotationsTableViewCell: UITableViewCell {
    @IBOutlet weak var labelSubscribedExchanges: UILabel!
    @IBOutlet weak var labelCurrency: UILabel!
    @IBOutlet weak var imageViewCurrencyIsSelected: UIImageView!
    
    func configure(currency: Currency){
        labelCurrency.text = currency.name
        
        labelSubscribedExchanges.text = ""
        labelCurrency.textColor = UIColor.gray
        imageViewCurrencyIsSelected.isHidden = true
        
        labelCurrency.text = currency.fullName
        for exchange in currency.sources{
            if exchange.subscribed{
                if !(labelSubscribedExchanges.text?.isEmpty)!{
                    labelSubscribedExchanges.text! += ", \(exchange.name)"
                }
                else{
                    labelSubscribedExchanges.text = exchange.name
                    imageViewCurrencyIsSelected.isHidden = false
                    labelCurrency.textColor = UIColor.white
                }
            }
        }
    }
    
}
