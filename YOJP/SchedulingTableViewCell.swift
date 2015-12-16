//
//  SchedulingTableViewCell.swift
//  YOJP
//
//  Created by PayBay on 15/12/15.
//  Copyright © 2015年 PayBay. All rights reserved.
//

import UIKit

class SchedulingTableViewCell: UITableViewCell {

    @IBOutlet weak var noButton: UIButton!
    @IBOutlet weak var noLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var garbageBtn: CallBackButton!
    @IBOutlet weak var addItemBtn: CallBackButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        
        self.noButton.backgroundColor = UIColor.whiteColor()
        self.noButton.layer.borderColor = yojpTableViewColor.CGColor
        self.noButton.layer.borderWidth = 1
        
        self.addItemBtn.backgroundColor = yojpBlue
        self.addItemBtn.setupBlock()
        self.garbageBtn.setupBlock()

        
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
