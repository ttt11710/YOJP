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
    @IBOutlet weak var collectionBtn: MCFireworksButton!
    @IBOutlet weak var moneyLabel: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.collectionBtn.particleImage = UIImage(named: "spark")
        self.collectionBtn.particleScale = 0.05
        self.collectionBtn.particleScaleRange = 0.02
        self.collectionBtn.addTarget(self, action: Selector("collecBtnPressed:"), forControlEvents: .TouchUpInside)
    }
    
    func collecBtnPressed(sender : MCFireworksButton) {
        sender.selected = !sender.selected
        if sender.selected {
            sender.popOutsideWithDuration(0.5)
            sender.setImage(UIImage(named: "collectionGolden"), forState: .Normal)
            sender.animate()
            
            SVProgressShow.showSuccessWithStatus("收藏成功!")
        }
        else {
            sender.popInsideWithDuration(0.4)
            sender.setImage(UIImage(named: "collectionBlack"), forState: .Normal)
        }

    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
