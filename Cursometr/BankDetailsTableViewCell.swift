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
    @IBOutlet weak var lblFrom: UILabel!
    @IBOutlet weak var lblPurchasePrice: UILabel!
    @IBOutlet weak var lblSalePrice: UILabel!
    @IBOutlet weak var viewCornerRadius: UIView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func setConfig(price: Price){
        lblPurchasePrice.text = String(price.buyPriceNow)
        lblSalePrice.text = String(price.salePriceNow)
        lblFrom.text = "Form \(price.range)"
    }
    
    func roundCorners(_ corners: UIRectCorner, radius: CGFloat) {
        var viewCornerRadiusBounds: CGRect = self.contentView.frame
        viewCornerRadiusBounds.size.width -= 32
        let path = UIBezierPath(roundedRect: viewCornerRadiusBounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: 0))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        viewCornerRadius.layer.mask = mask
    }
    
    func hideSeparator(){
//        let separator : UIView = UIView()
//        separator.translatesAutoresizingMaskIntoConstraints = false
//        separator.heightAnchor.constraint(equalToConstant: 1).isActive = true
//        separator.backgroundColor = UIColor.gray
//        viewCornerRadius.addSubview(separator)
//        separator.bottomAnchor.constraint(equalTo: viewCornerRadius.bottomAnchor).isActive = true
//        separator.leftAnchor.constraint(equalTo: viewCornerRadius.leftAnchor).isActive = true
//        separator.rightAnchor.constraint(equalTo: viewCornerRadius.rightAnchor).isActive = true
        viewSeparator.isHidden = true
    }
    
    func showSeparator(){
        viewSeparator.isHidden = false
    }
}
