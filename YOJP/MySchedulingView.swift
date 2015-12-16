//
//  MySchedulingView.swift
//  YOJP
//
//  Created by PayBay on 15/12/14.
//  Copyright © 2015年 PayBay. All rights reserved.
//

import UIKit

class MySchedulingView: UIView {
    

    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var noLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var addItemBtn: CallBackButton!
    
    func setView() {
        
        self.noButton.backgroundColor = UIColor.whiteColor()
        self.noButton.layer.borderColor = yojpTableViewColor.CGColor
        self.noButton.layer.borderWidth = 1
        
        self.addItemBtn.backgroundColor = yojpBlue
        self.addItemBtn.setupBlock()
        
        
//        self.noButton.layer.shadowOffset = CGSizeMake(1, 1)
//        self.noButton.layer.shadowOpacity = 0.8
//        self.noButton.layer.shadowRadius = 1.0
//        
//        self.noButton.layer.shadowColor = UIColor.blackColor().CGColor
//        
//        
//        self.noButton.layer.shadowOpacity = 1.0
        
        
      //  self.noLabel.clipsToBounds = false
      //  self.noLabel.layer.masksToBounds = true
    }
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
    }
    */

}


