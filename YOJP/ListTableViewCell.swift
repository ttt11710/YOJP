//
//  ListTableViewCell.swift
//  YOJP
//
//  Created by PayBay on 15/12/18.
//  Copyright © 2015年 PayBay. All rights reserved.
//

import UIKit

class ListTableViewCell: UITableViewCell {

    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var listLabel: UILabel!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var deleteBtn: CallBackButton!
    @IBOutlet weak var newBtn: CallBackButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.parentView.layer.borderColor = yojpBlue.CGColor
        self.parentView.layer.borderWidth = 1
        
        self.backView.backgroundColor = yojpBlue
        self.deleteBtn.setupBlock()
        self.newBtn.setupBlock()
        
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ListTableViewCell.tap))
        self.backView.addGestureRecognizer(tap)
    }
    
    func tap() {
        return 
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
