//
//  StoreInfoTableViewCell.swift
//  YOJP
//
//  Created by PayBay on 16/1/4.
//  Copyright © 2016年 PayBay. All rights reserved.
//

import UIKit
import MapKit

class StoreInfoTableViewCell: UITableViewCell {

    
    @IBOutlet weak var gotoStoreCallBtn: CallBackButton!
    @IBOutlet weak var currentStoreAddressLabel: UILabel!
    @IBOutlet weak var store1AddressLabel: UILabel!
    @IBOutlet weak var store2AddressLabel: UILabel!
    @IBOutlet weak var store3AddressLabel: UILabel!
    @IBOutlet weak var moreCallBackBtn: CallBackButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.gotoStoreCallBtn.setupBlock()
       // self.mapView.autoresizingMask = [UIViewAutoresizing.FlexibleHeight,UIViewAutoresizing.FlexibleWidth]
        
        self.moreCallBackBtn.setupBlock()
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
