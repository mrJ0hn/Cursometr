//
//  ItemViewController.swift
//  Cursometr
//
//  Created by iMacAir on 08.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import UIKit

class ItemViewController: UIViewController{

    @IBOutlet weak var imgLeaveFeedback: UIImageView!
    
    var itemIndex: Int = 0
    var itemTitle = String()
    
    enum SegueIdentifier: String {
        case leaveFeedbackViewController = "LeaveFeedbackViewController"
    }
    
    //@IBOutlet weak var lblTitle: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let imgLeaveFeedbackTap = UITapGestureRecognizer(target: self, action: #selector(imgLeaveFeedbackTapped))
        imgLeaveFeedback.addGestureRecognizer(imgLeaveFeedbackTap)
        imgLeaveFeedback.isUserInteractionEnabled = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setConfig(title: String)
    {
        itemTitle  = title
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
