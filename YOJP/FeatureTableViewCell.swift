//
//  FeatureTableViewCell.swift
//  YOJP
//
//  Created by PayBay on 16/4/12.
//  Copyright © 2016年 PayBay. All rights reserved.
//

import UIKit

class FeatureTableViewCell: UITableViewCell {

    @IBOutlet weak var storeLogoImageView: UIImageView!
    @IBOutlet weak var storeName: UILabel!
    @IBOutlet weak var storeSubLabel: UILabel!
    @IBOutlet weak var item1View: UIView!
    @IBOutlet weak var item2View: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
