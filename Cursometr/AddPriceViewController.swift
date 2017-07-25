//
//  AddPriceViewController.swift
//  Cursometr
//
//  Created by iMacAir on 21.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import UIKit

class AddPriceViewController: UIViewController, UITabBarDelegate {
    
    @IBOutlet weak var buttonDone: UIBarButtonItem!
    @IBOutlet weak var textFieldCost: UITextField!
    @IBOutlet weak var labelCurrentQuotation: UILabel!
    
    var cost : Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let strCost = String(format: "%.3f", cost!)
        textFieldCost.text = strCost
        self.labelCurrentQuotation.text = "Current quotatoin: " + strCost
        textFieldCost.addTarget(self, action: #selector(costDidChange), for: .editingChanged)
    }
    
    func costDidChange(){
        if let text = textFieldCost.text, text.isEmpty{
            buttonDone.isEnabled = false
        }
        else if buttonDone.isEnabled == false{
            buttonDone.isEnabled = true
        }
    }
    
    func configure(cost: Double){
        self.cost = cost
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cost = Double(textFieldCost.text!){
            self.cost = cost
        }
        else{
            self.cost = nil
        }
    }
}
