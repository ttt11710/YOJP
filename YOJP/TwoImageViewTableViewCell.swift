//
//  TwoImageViewTableViewCell.swift
//  YOJP
//
//  Created by PayBay on 16/3/16.
//  Copyright © 2016年 PayBay. All rights reserved.
//

import UIKit

class TwoImageViewTableViewCell: UITableViewCell {

    @IBOutlet weak var imageView1: UIImageView!
    @IBOutlet weak var label1: UILabel!
    @IBOutlet weak var imageView2: UIImageView!
    @IBOutlet weak var label2: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
