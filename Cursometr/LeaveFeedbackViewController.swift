//
//  LeaveFeedbackViewController.swift
//  Cursometr
//
//  Created by iMacAir on 09.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import UIKit

class LeaveFeedbackViewController: UIViewController {

    @IBOutlet weak var btnSendFeedback: UIBarButtonItem!
    @IBOutlet weak var txtMessage: UITextView!
    @IBOutlet weak var lblSubjectFeedback: UILabel!
    @IBOutlet weak var viewAddSource: UIView!

    enum SegueIdentifier: String {
        case chooseSubjectViewController = "ChooseSubjectViewController"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imgSourceTap = UITapGestureRecognizer(target: self, action: #selector(imgSourceTapped))
        viewAddSource.addGestureRecognizer(imgSourceTap)
        viewAddSource.isUserInteractionEnabled = true
        
        btnSendFeedback.target = self
        btnSendFeedback.action = #selector(sendFeedback)
    }
    
    func imgSourceTapped(){
        performSegue(withIdentifier: SegueIdentifier.chooseSubjectViewController.rawValue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let id = segue.identifier,
            let sid = SegueIdentifier(rawValue: id) else {
                return
        }
        switch sid {
        case .chooseSubjectViewController:
            let _ = segue.destination as! ChooseSubjectViewController
        default:
            break
        }
    }
    
    func sendFeedback(){
        if !txtMessage.text.isEmpty{
            BankDataDownloadService.shared.sendFeedback(title: lblSubjectFeedback.text!, body: txtMessage.text, onSuccess: {
                self.dismiss(animated: true, completion: nil)
            })
        }
    }
    
    @IBAction func unwindToLeaveFeedbackViewController(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? ChooseSubjectViewController {
            let dataRecieved = sourceViewController.selectedItem
            if let subject = dataRecieved{
                lblSubjectFeedback.text = subject
            }
        }
    }
}
