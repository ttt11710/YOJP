//
//  ChooseView.swift
//  GreenPepper
//
//  Created by PayBay on 16/3/10.
//  Copyright © 2016年 ttt. All rights reserved.
//

import UIKit

class ChooseView: UIView {
    
    var chooseCallBack : CallBackButton!
    var label : UILabel!
    var imageSelectString : String = "icon"
    var imageNormalString : String = "icon"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setView()
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setView() {
        
        self.chooseCallBack = CallBackButton(frame: CGRectMake(0,0,self.frame.size.height,self.frame.size.height))
        self.chooseCallBack.setBackgroundImage(UIImage(named: imageSelectString), forState: .Selected)
        self.chooseCallBack.setBackgroundImage(UIImage(named: imageNormalString), forState: .Normal)
       // self.chooseCallBack.setupBlock()
        self.addSubview(self.chooseCallBack)
        
        self.label = UILabel(frame: CGRectMake(self.frame.size.height+8,self.frame.size.height-25,150,25))
        self.label.textColor = yojpText
        self.label.font = font14
        self.addSubview(self.label)
    }
    
    func chooseImageSelectString(imageSelectString : String, imageNormalString : String) {
        self.chooseCallBack.setBackgroundImage(UIImage(named: imageSelectString), forState: .Selected)
        self.chooseCallBack.setBackgroundImage(UIImage(named: imageNormalString), forState: .Normal)
    }
}
