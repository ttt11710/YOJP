//
//  LabelView.swift
//  YOJP
//
//  Created by PayBay on 15/11/25.
//  Copyright © 2015年 PayBay. All rights reserved.
//

import UIKit

class LabelView: UIView {

    var imageViewBackView : UIView!
    var labelImageView : UIImageView!
    var labelLabel : UILabel!
    
    override init( frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clearColor()
        self.initView()

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView() {
        
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

        imageViewBackView = UIView(frame: CGRectMake(0,0,26,25))
        imageViewBackView.backgroundColor = UIColor(white: 0, alpha: 0.8)
        labelImageView = UIImageView(frame: CGRectMake(4,3,18,18))
        labelImageView.image = UIImage(named: String(format: "%@金", string))
        imageViewBackView.addSubview(labelImageView)
        
        labelLabel = UILabel(frame: CGRectMake(imageViewBackView.frame.origin.x + imageViewBackView.frame.size.width,imageViewBackView.frame.origin.y,100,25))
        labelLabel.font = font14
        labelLabel.text = string
        labelLabel.textColor = UIColor(red: 234.0/255.0, green: 128.0/255.0, blue: 16.0/255.0, alpha: 1)
        labelLabel.backgroundColor = UIColor(white: 0, alpha: 0.8)
        labelLabel.sizeToFit()
        labelLabel.frame = CGRectMake(imageViewBackView.frame.origin.x + imageViewBackView.frame.size.width,imageViewBackView.frame.origin.y,labelLabel.frame.size.width,25)
        
        self.frame = CGRectMake(self.frame.origin.x, self.frame.origin.y, 26+labelLabel.frame.size.width, 25)
        self.addSubview(imageViewBackView)
        self.addSubview(labelLabel)
    }

}
