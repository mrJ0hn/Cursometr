//
//  BankDataTableViewCell.swift
//  Cursometr
//
//  Created by iMacAir on 09.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import UIKit

class BankDetailsTableViewCell: UITableViewCell {
    @IBOutlet weak var viewSeparator: UIView!
    @IBOutlet weak var labelFrom: UILabel!
    @IBOutlet weak var labelPurchasePrice: UILabel!
    @IBOutlet weak var labelSalePrice: UILabel!
    @IBOutlet weak var viewSalePrice: UIView!
    @IBOutlet weak var viewCornerRadius: CornerRadiusView!
    let valueCornerRadius: CGFloat = 10
    
    func configure(price: Price, showSellPrice: Bool) {
        labelPurchasePrice.text = String(price.buyPriceNow)
        labelSalePrice.text = String(price.salePriceNow)
        viewSalePrice.isHidden = showSellPrice
        labelFrom.text = "Form \(price.range)"
    }
    
    private func hideSeparator(){
        viewSeparator.isHidden = true
    }
    
    private func showSeparator(){
        viewSeparator.isHidden = false
    }
    
    func configureCorners(for row: Int, countInSection count: Int){
    
        if row == 0{
            //if only one cell
            if row == count-1 {
                viewCornerRadius.configure(positionCornerRadius: [.topLeft, .topRight, .bottomLeft, .bottomRight], valueCornerRadius: valueCornerRadius)
                hideSeparator()
            }
                //if first cell
            else{
                viewCornerRadius.configure(positionCornerRadius: [.topLeft, .topRight], valueCornerRadius: valueCornerRadius)
                showSeparator()
            }
        }
            //if last cell
        else if row == count-1 {
            viewCornerRadius.configure(positionCornerRadius: [.bottomLeft, .bottomRight], valueCornerRadius: valueCornerRadius)
            hideSeparator()
        }
            //if center cell
        else{
            viewCornerRadius.configure(positionCornerRadius: [.topLeft, .topRight, .bottomLeft, .bottomRight], valueCornerRadius: 0)
            showSeparator()
        }
    }
}
