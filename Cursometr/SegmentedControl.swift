//
//  SegmentControl.swift
//  Cursometr
//
//  Created by iMacAir on 25.07.17.
//  Copyright © 2017 iMacAir. All rights reserved.
//

import UIKit

class SegmentedControl: UIView {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var secondSegmentView: UIView!
    @IBOutlet weak var firstSegmentView: UIView!
    @IBOutlet weak var labelFirstSegment: UILabel!
    @IBOutlet weak var imageViewFirstSegment: UIImageView!
    @IBOutlet weak var labelSecondSegment: UILabel!
    @IBOutlet weak var imageViewSecondSegment: UIImageView!
    
    let icnRepeatOnceBlue = #imageLiteral(resourceName: "icn_repeat_once_blue")
    let icnRepeatOnceWhite = #imageLiteral(resourceName: "icn_repeat_once_white")
    let icnRepeatEachtimeBlue = #imageLiteral(resourceName: "icn_repeat_eachtime_blue")
    let icnRepeatEachtimeWhite = #imageLiteral(resourceName: "icn_repeat_eachtime_white")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        initialize()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initialize()
    }

    func initialize(){
        Bundle.main.loadNibNamed("SegmentedControl", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.layer.masksToBounds = true
        contentView.layer.borderColor = Constatns.Color.aqua.cgColor
        contentView.layer.borderWidth = 1
        contentView.layer.cornerRadius = 5
        
        let tapFirstSegment = UITapGestureRecognizer(target: self, action: #selector(firstSegmentTapped))
        firstSegmentView.addGestureRecognizer(tapFirstSegment)
        
        
        let tapSecondSegment = UITapGestureRecognizer(target: self, action: #selector(secondSegmentTapped))
        secondSegmentView.addGestureRecognizer(tapSecondSegment)
    }
    
    func firstSegmentTapped(){
        firstSegmentView.backgroundColor = Constatns.Color.aqua
        labelFirstSegment.textColor = UIColor.white
        imageViewFirstSegment.image = icnRepeatOnceWhite
        
        secondSegmentView.backgroundColor = Constatns.Color.viewFlipsideBackgroundColor
        labelSecondSegment.textColor = Constatns.Color.aqua
        imageViewSecondSegment.image = icnRepeatEachtimeBlue
    }
    
    func secondSegmentTapped(){
        firstSegmentView.backgroundColor = Constatns.Color.viewFlipsideBackgroundColor
        labelFirstSegment.textColor = Constatns.Color.aqua
        imageViewFirstSegment.image = icnRepeatOnceBlue
        
        secondSegmentView.backgroundColor = Constatns.Color.aqua
        labelSecondSegment.textColor = UIColor.white
        imageViewSecondSegment.image = icnRepeatEachtimeWhite
    }
}
