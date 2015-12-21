//
//  SchedulingSubTableViewCell.swift
//  YOJP
//
//  Created by PayBay on 15/12/17.
//  Copyright © 2015年 PayBay. All rights reserved.
//

import UIKit

class SchedulingSubTableViewCell: UITableViewCell {

    
    
    var callBack:(()->())?
    
    @IBOutlet weak var itemLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    
        
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("tap"))
        self.addGestureRecognizer(tap)
        
        
        let pan : UIPanGestureRecognizer = UIPanGestureRecognizer(target: self, action: Selector("pan"))
        self.addGestureRecognizer(pan)
    }
    
    func tap() {
        self.callBack!()
    }
    
    func pan() {
        print("pan")
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
