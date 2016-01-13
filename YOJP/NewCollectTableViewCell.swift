//
//  NewCollectTableViewCell.swift
//  YOJP
//
//  Created by PayBay on 16/1/12.
//  Copyright © 2016年 PayBay. All rights reserved.
//

import UIKit

class NewCollectTableViewCell: UITableViewCell {

    @IBOutlet weak var productImageView: UIImageView!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    
    @IBOutlet weak var editView: UIView!
    @IBOutlet weak var editProductImageView: UIImageView!
    @IBOutlet weak var editProductName: UILabel!
    @IBOutlet weak var editProductPriceLabel: UILabel!
    @IBOutlet weak var editDeleteCallBtn: CallBackButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.editDeleteCallBtn.setupBlock()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
