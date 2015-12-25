//
//  ProductDescriptionTableViewCell.swift
//  YOJP
//
//  Created by PayBay on 15/11/30.
//  Copyright © 2015年 PayBay. All rights reserved.
//

import UIKit

class ProductDescriptionTableViewCell: UITableViewCell {

    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productDicLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var moneyLabel: UILabel!
    @IBOutlet weak var addToShopCarCallBackBtn: CallBackButton!
    @IBOutlet weak var buyCallBackBtn: CallBackButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.addToShopCarCallBackBtn.layer.cornerRadius = 4
        self.buyCallBackBtn.layer.cornerRadius = 4
        self.addToShopCarCallBackBtn.setupBlock()
        self.buyCallBackBtn.setupBlock()
        
        
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
