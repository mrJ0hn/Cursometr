//
//  ItemViewController.swift
//  Cursometr
//
//  Created by iMacAir on 08.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController{

    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgLeaveFeedback: UIImageView!
    
    var itemIndex: Int = 0
    var strTitle: String? = String()
    var currency : Currency?
    
    enum SegueIdentifier: String {
        case leaveFeedbackViewController = "LeaveFeedbackViewController"
        case bankDetailsTableViewController = "BankDetailsTableViewController"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imgLeaveFeedbackTap = UITapGestureRecognizer(target: self, action: #selector(imgLeaveFeedbackTapped))
        imgLeaveFeedback.addGestureRecognizer(imgLeaveFeedbackTap)
        imgLeaveFeedback.isUserInteractionEnabled = true
        lblTitle.text = strTitle
        
    }
    
    func setConfig(title: String){
        self.strTitle = title
    }
    
    func setConfig(currency: Currency)
    {
        self.currency = currency
        self.strTitle = currency.name
    }
    
    func imgLeaveFeedbackTapped()
    {
        performSegue(withIdentifier: SegueIdentifier.leaveFeedbackViewController.rawValue, sender: self)
    }
    
    @IBAction func cancelFeedback(segue: UIStoryboardSegue) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let id = segue.identifier,
            let sid = SegueIdentifier(rawValue: id) else {
                return
        }
        switch sid {
        case .bankDetailsTableViewController:
            let vc = segue.destination as! BankDetailsTableViewController
            if let currency = currency{
                vc.setConfig(exchanges: currency.sources)
            }
        default:
            break
        }
    }
}
