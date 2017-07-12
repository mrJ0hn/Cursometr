//
//  LeaveFeedbackViewController.swift
//  Cursometr
//
//  Created by iMacAir on 09.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import UIKit

class LeaveFeedbackViewController: UIViewController {

    @IBOutlet weak var imgSource: UIImageView!

    enum SegueIdentifier: String {
        case chooseSubjectViewController = "ChooseSubjectViewController"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let imgSourceTap = UITapGestureRecognizer(target: self, action: #selector(imgSourceTapped))
        imgSource.addGestureRecognizer(imgSourceTap)
        imgSource.isUserInteractionEnabled = true
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
    
}
