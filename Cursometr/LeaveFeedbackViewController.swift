//
//  LeaveFeedbackViewController.swift
//  Cursometr
//
//  Created by iMacAir on 09.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import UIKit

class LeaveFeedbackViewController: UIViewController {
    @IBOutlet weak var buttonSend: UIBarButtonItem!
    @IBOutlet weak var textViewMessage: TextView!
    @IBOutlet weak var labelSubjectFeedback: UILabel!
    @IBOutlet weak var viewAddSource: UIView!
    
    var subjectFeedback = FeedbackSubject.addSource
    
    enum SegueIdentifier: String {
        case chooseSubjectViewController = "ChooseSubjectViewController"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let viewSourceTap = UITapGestureRecognizer(target: self, action: #selector(viewSourceTapped))
        viewAddSource.addGestureRecognizer(viewSourceTap)
        viewAddSource.isUserInteractionEnabled = true
        
        buttonSend.isEnabled = true
        buttonSend.target = self
        buttonSend.action = #selector(sendFeedback)
        
        buttonSend.isEnabled = false
        textViewMessage.isEmptyCallback={[weak self] (isEmpty) in
            self?.buttonSend.isEnabled = !isEmpty
        }
    }
    
    func viewSourceTapped(){
        performSegue(withIdentifier: SegueIdentifier.chooseSubjectViewController.rawValue, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let id = segue.identifier,
            let sid = SegueIdentifier(rawValue: id) else {
                return
        }
        switch sid {
        case .chooseSubjectViewController:
            let vc = segue.destination as! SubjectFeedbackViewController
            vc.selectedItem = subjectFeedback
        }
    }
    
    func sendFeedback(){
        SendFeedbackService.sendFeedback(title: labelSubjectFeedback.text!, body: textViewMessage.text, onSuccess: {
            self.dismiss(animated: true, completion: nil)
        }, onError: { [weak self] (error) in
            DispatchQueue.main.async {
                self?.showError(error: error)
            }
        })
    }
    
    @IBAction func unwindToLeaveFeedbackViewController(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? SubjectFeedbackViewController {
            subjectFeedback = sourceViewController.selectedItem
            labelSubjectFeedback.text = subjectFeedback.description
        }
    }
}
