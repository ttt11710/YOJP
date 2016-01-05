//
//  CardListTableViewWithOnlyMoneyCell.swift
//  YOJP
//
//  Created by PayBay on 16/1/5.
//  Copyright © 2016年 PayBay. All rights reserved.
//

import UIKit

class CardListTableViewWithOnlyMoneyCell: UITableViewCell {

    @IBOutlet weak var payMoneyLabel: UILabel!
    @IBOutlet weak var userTimeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
