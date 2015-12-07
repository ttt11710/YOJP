//
//  CardListTableViewWithTimeCell.swift
//  YOJP
//
//  Created by PayBay on 15/12/4.
//  Copyright © 2015年 PayBay. All rights reserved.
//

import UIKit

class CardListTableViewWithTimeCell: UITableViewCell {

    @IBOutlet weak var barcodeImagwView: UIImageView!
    @IBOutlet weak var ticketTypeLabel: UILabel!
    @IBOutlet weak var validityLabel: UILabel!
    @IBOutlet weak var useTimeLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
