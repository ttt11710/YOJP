//
//  ShopCarTableViewCell.swift
//  YOJP
//
//  Created by PayBay on 15/12/23.
//  Copyright © 2015年 PayBay. All rights reserved.
//

import UIKit

class ShopCarTableViewCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var reduceCallBtn: CallBackButton!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var increaseCallBtn: CallBackButton!
    
    @IBOutlet weak var editView: UIView!
    @IBOutlet weak var editReduceCallBtn: CallBackButton!
    @IBOutlet weak var editCountLabel: UILabel!
    @IBOutlet weak var editIncreaseCallBtn: CallBackButton!
    @IBOutlet weak var editDeleteCallBtn: CallBackButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    
        self.reduceCallBtn.layer.cornerRadius = 4
        self.increaseCallBtn.layer.cornerRadius = 4
        self.editReduceCallBtn.layer.cornerRadius = 4
        self.editIncreaseCallBtn.layer.cornerRadius = 4
        self.reduceCallBtn.setupBlock()
        self.increaseCallBtn.setupBlock()
        self.editReduceCallBtn.setupBlock()
        self.editIncreaseCallBtn.setupBlock()
        self.editDeleteCallBtn.setupBlock()
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
