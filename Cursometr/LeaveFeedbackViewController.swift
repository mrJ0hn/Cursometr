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
    @IBOutlet weak var txtMessage: CustomTextView!
    @IBOutlet weak var lblSubjectFeedback: UILabel!
    @IBOutlet weak var viewAddSource: UIView!
    var subjectFeedback = FeedbackSubject.addSource

    enum SegueIdentifier: String {
        case chooseSubjectViewController = "ChooseSubjectViewController"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imgSourceTap = UITapGestureRecognizer(target: self, action: #selector(imgSourceTapped))
        viewAddSource.addGestureRecognizer(imgSourceTap)
        viewAddSource.isUserInteractionEnabled = true
        
        btnSendFeedback.isEnabled = true
        btnSendFeedback.target = self
        btnSendFeedback.action = #selector(sendFeedback)
        
        btnSendFeedback.isEnabled = false
        txtMessage.isEmptyCallback={[weak self] (isEmpty) in
            self?.btnSendFeedback.isEnabled = !isEmpty
        }
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
            let vc = segue.destination as! ChooseSubjectViewController
            vc.selectedItem = subjectFeedback
        }
    }
    
    func sendFeedback(){
        if !txtMessage.text.isEmpty{
            SendFeedbackService.shared.sendFeedback(title: lblSubjectFeedback.text!, body: txtMessage.text, onSuccess: {
                self.dismiss(animated: true, completion: nil)
            }, onError: { [weak self] (error) in
                DispatchQueue.main.async {
                    self?.showError(error: error)
                }
            })
        }
    }
    
    @IBAction func unwindToLeaveFeedbackViewController(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? ChooseSubjectViewController {
            subjectFeedback = sourceViewController.selectedItem
            lblSubjectFeedback.text = subjectFeedback.description
        }
    }
}
