//
//  myCollectionViewCell.swift
//  swiftShrb
//
//  Created by PayBay on 15/11/12.
//  Copyright © 2015年 PayBay. All rights reserved.
//

import UIKit

class myCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var backImageView: UIImageView!
    @IBOutlet weak var desLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var labelBackView: UIView!
    @IBOutlet weak var labelImageView: UIImageView!
    @IBOutlet weak var labelLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.backImageView.backgroundColor = UIColor.whiteColor()
        self.desLabel.backgroundColor = UIColor.whiteColor()
        self.dateLabel.backgroundColor = UIColor.whiteColor()
        
        var string : String = "免费券"
        switch arc4random()%4 {
        case 0:
            string = "免费券"
        case 1:
            string = "打折券"
        case 2:
            string = "抵扣券"
        default:
            string = "福袋"
        }
        
        labelLabel.text = string
        labelImageView.image = UIImage(named: String(format: "%@金", string))
        // Initialization code
    }

}
