//
//  AddPriceViewController.swift
//  Cursometr
//
//  Created by iMacAir on 21.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import UIKit

class AddPriceViewController: UIViewController, UITabBarDelegate {
    
    @IBOutlet weak var btnDone: UIBarButtonItem!
    @IBOutlet weak var txtCost: UITextField!
    @IBOutlet weak var lblCurrentQuotation: UILabel!
    var cost : Double?
    override func viewDidLoad() {
        super.viewDidLoad()
        let strCost = String(format: "%.3f", cost!)
        txtCost.text = strCost
        self.lblCurrentQuotation.text = "Current quotatoin: " + strCost
        txtCost.addTarget(self, action: #selector(costDidChange), for: .editingChanged)
        // Do any additional setup after loading the view.
    }
    
    func costDidChange(){
        if let text = txtCost.text, text.isEmpty{
            btnDone.isEnabled = false
        }
        else if btnDone.isEnabled == false{
            btnDone.isEnabled = true
        }
    }
    
    func set(cost: Double){
        self.cost = cost
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let cost = Double(txtCost.text!){
            self.cost = cost
        }
        else{
            self.cost = nil
        }
    }
}
