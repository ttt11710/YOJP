//
//  WeatherView.swift
//  YOJP
//
//  Created by PayBay on 15/11/9.
//  Copyright © 2015年 PayBay. All rights reserved.
//

import UIKit

class WeatherView: UIView {
    
    var dataLabel : UILabel!
    var pm25 : UILabel!
    var dayPictureUrlImageView : UIImageView!
    var maxTemperatureLabel : UILabel!
    var minTemperatureLabel : UILabel!
    var weatherLabel : UILabel!
    var addressLabel : UILabel!

    var myTag : Int!
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clearColor()
        self.alpha = 0.8
        self.initView()
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView() {
        
      dataLabel = UILabel(frame: CGRectMake(self.frame.size.width/2-50,10,50,20))
        dataLabel.text = "今天"
        dataLabel.textColor = UIColor.whiteColor()
        dataLabel.font = font16
        dataLabel.textAlignment = .Center
        dataLabel.opaque = true
        self.addSubview(dataLabel)
       
        
        pm25 = UILabel(frame: CGRectMake(self.frame.size.width/2,10,40,20))
        pm25.text = "轻度"
        pm25.textColor = UIColor(red: 76.0/255.0, green: 55.0/255.0, blue: 58.0/255.0, alpha: 1)
        pm25.backgroundColor = UIColor(red: 252.0/255.0, green: 124.0/255.0, blue: 76.0/255.0, alpha: 1)
        pm25.font = font14
        pm25.textAlignment = .Center
        pm25.layer.cornerRadius = 4
        pm25.layer.masksToBounds = true
        self.addSubview(pm25)

        dayPictureUrlImageView = UIImageView(frame: CGRectMake(10, dataLabel.frame.origin.y + dataLabel.frame.size.height + 10, 60, 60))
        dayPictureUrlImageView.image = UIImage(named: "大雪")
        dayPictureUrlImageView.opaque = true
        self.addSubview(dayPictureUrlImageView)
        
        maxTemperatureLabel = UILabel(frame: CGRectMake(self.frame.size.width-20-20,dayPictureUrlImageView.frame.origin.y + 10, 50,20))
        maxTemperatureLabel.text = "13℃"
        maxTemperatureLabel.textColor = UIColor.whiteColor()
        maxTemperatureLabel.opaque = true
        self.addSubview(maxTemperatureLabel)
        
        
        minTemperatureLabel = UILabel(frame:CGRectMake(self.frame.size.width-20-20,maxTemperatureLabel.frame.origin.y + maxTemperatureLabel.frame.size.height + 10, 50,20))
        minTemperatureLabel.text = "10°"
        minTemperatureLabel.textColor = UIColor.whiteColor()
        minTemperatureLabel.opaque = true
        self.addSubview(minTemperatureLabel)
       
        
        weatherLabel = UILabel()
        weatherLabel.textAlignment = .Center
        weatherLabel.text = "多云转阴"
        weatherLabel.sizeToFit()
        weatherLabel.textColor = UIColor.whiteColor()
        weatherLabel.center = CGPointMake(self.frame.size.width/2, minTemperatureLabel.frame.origin.y + minTemperatureLabel.frame.size.height + 20)
        weatherLabel.opaque = true
        self.addSubview(weatherLabel)
        
//        addressLabel = UILabel(frame: CGRectMake(10,weatherLabel.frame.origin.y + weatherLabel.frame.size.height,200,30))
//        addressLabel.text = "当前位置:上海"
//        addressLabel.textColor = UIColor.whiteColor()
//        self.addSubview(addressLabel)
        
    }

}
