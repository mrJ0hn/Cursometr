//
//  SegmentControlTableViewCell.swift
//  Cursometr
//
//  Created by iMacAir on 19.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import UIKit

class SegmentControlTableViewCell: UITableViewCell {

    @IBOutlet weak var segmentControl: UISegmentedControl!
    var imageSegmentZeroBlue : UIImage!
    var imageSegmentOneBlue : UIImage!
    var imageSegmentZeroWhite : UIImage!
    var imageSegmentOneWhite : UIImage!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        let icnRepeatOnceBlue = UIImage(named: "icn_repeat_once_blue")!
        let icnRepeatEachtimeBlue = UIImage(named: "icn_repeat_eachtime_blue")!
//        let icnRepeatOnceWhite = UIImage(named: "icn_repeat_once_white")!
//        let icnRepeatEachtimeWhite = UIImage(named: "icn_repeat_eachtime_white")!
        
        imageSegmentZeroBlue = UIImage.textEmbededImage(image: icnRepeatOnceBlue, string: "One Time", color: UIColor.white)
        imageSegmentOneBlue = UIImage.textEmbededImage(image: icnRepeatEachtimeBlue, string: "Each Time", color: UIColor.white)
//        imageSegmentZeroWhite = UIImage.textEmbededImage(image: icnRepeatOnceWhite, string: "One Time", color: UIColor.white)
//        imageSegmentOneWhite = UIImage.textEmbededImage(image: icnRepeatEachtimeWhite, string: "Each Time", color: UIColor.white)
        
        segmentControl.setImage(imageSegmentZeroBlue, forSegmentAt: 0)
        segmentControl.setImage(imageSegmentOneBlue, forSegmentAt: 1)
        //segmentControl.addTarget(self, action: #selector(segmentedControlValueChanged), for:.valueChanged)
    }

//    func segmentedControlValueChanged(){
//        if segmentControl.selectedSegmentIndex == 0 {
//            segmentControl.setImage(imageSegmentZeroWhite, forSegmentAt: 0)
//            segmentControl.setImage(imageSegmentOneBlue, forSegmentAt: 1)
//           
//        }
//        else{
//            segmentControl.setImage(imageSegmentZeroBlue, forSegmentAt: 0)
//            segmentControl.setImage(imageSegmentOneWhite, forSegmentAt: 1)
//        }
//    }
}
