//
//  DetailTableViewCell.swift
//  YOJP
//
//  Created by PayBay on 16/1/4.
//  Copyright © 2016年 PayBay. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productDicLabel: UILabel!
    @IBOutlet weak var ProductImageView: UIImageView!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var stockLabel: UILabel!
    @IBOutlet weak var addShopCarCallBtn: CallBackButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.addShopCarCallBtn.layer.cornerRadius = 4
        self.addShopCarCallBtn.setupBlock()
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
