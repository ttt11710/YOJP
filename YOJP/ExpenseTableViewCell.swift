//
//  ExpenseTableViewCell.swift
//  YOJP
//
//  Created by PayBay on 16/1/12.
//  Copyright © 2016年 PayBay. All rights reserved.
//

import UIKit

class ExpenseTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var barcodeImageView: UIImageView!
    @IBOutlet weak var storeLogoImageView: UIImageView!
    @IBOutlet weak var orderNumberLabel: UILabel!
    @IBOutlet weak var orderMoneyLabel: UILabel!
    @IBOutlet weak var orderStateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
