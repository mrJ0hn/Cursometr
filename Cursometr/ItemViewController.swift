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
    
    enum SegueIdentifier: String {
        case leaveFeedbackViewController = "LeaveFeedbackViewController"
    }
    
    //@IBOutlet weak var lblTitle: UILabel!
    
    
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
        self.strTitle = currency.name
    }
    
    func imgLeaveFeedbackTapped()
    {
            performSegue(withIdentifier: SegueIdentifier.leaveFeedbackViewController.rawValue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let id = segue.identifier,
            let sid = SegueIdentifier(rawValue: id) else {
                return
        }
        switch sid {
        case .leaveFeedbackViewController:
            let vc = segue.destination as! LeaveFeedbackViewController
        default:
            break
        }

    }
}
