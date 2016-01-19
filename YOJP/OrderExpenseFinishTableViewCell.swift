//
//  ExpenseTableViewCell.swift
//  YOJP
//
//  Created by PayBay on 16/1/12.
//  Copyright © 2016年 PayBay. All rights reserved.
//

import UIKit

class OrderExpenseFinishTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var storeLogoImageView: UIImageView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var label3: UILabel!
    @IBOutlet weak var label4: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
