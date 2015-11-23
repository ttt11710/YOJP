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

    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        self.backgroundColor = UIColor(white: 0, alpha: 0.5)
        self.initView()
        
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initView() {
        
      dataLabel = UILabel(frame: CGRectMake(self.frame.size.width/2-50,5,50,20))
        dataLabel.text = "今天"
        dataLabel.textColor = UIColor.whiteColor()
        dataLabel.font = font16
        dataLabel.textAlignment = .Center
        self.addSubview(dataLabel)
       
        
        pm25 = UILabel(frame: CGRectMake(self.frame.size.width/2,5,40,20))
        pm25.text = "轻度"
        pm25.textColor = UIColor(red: 76.0/255.0, green: 55.0/255.0, blue: 58.0/255.0, alpha: 1)
        pm25.backgroundColor = UIColor(red: 252.0/255.0, green: 124.0/255.0, blue: 76.0/255.0, alpha: 1)
        pm25.font = font14
        pm25.textAlignment = .Center
        pm25.layer.cornerRadius = 4
        pm25.layer.masksToBounds = true
        self.addSubview(pm25)

        dayPictureUrlImageView = UIImageView(frame: CGRectMake(10, self.frame.size.height/2-30, 60, 60))
        dayPictureUrlImageView.image = UIImage(named: "大雪")
        self.addSubview(dayPictureUrlImageView)
        
        maxTemperatureLabel = UILabel(frame: CGRectMake(self.frame.size.width-20-20,self.frame.size.height/2-23, 50,20))
        maxTemperatureLabel.text = "13°"
        maxTemperatureLabel.textColor = UIColor.whiteColor()
        self.addSubview(maxTemperatureLabel)
        
        
        minTemperatureLabel = UILabel(frame:CGRectMake(self.frame.size.width-20-20,self.frame.size.height/2+3, 50,20))
        minTemperatureLabel.text = "10°"
        minTemperatureLabel.textColor = UIColor.whiteColor()
        self.addSubview(minTemperatureLabel)
       
        
        weatherLabel = UILabel()
        weatherLabel.textAlignment = .Center
        weatherLabel.text = "多云转阴"
        weatherLabel.sizeToFit()
        weatherLabel.textColor = UIColor.whiteColor()
        weatherLabel.center = CGPointMake(self.frame.size.width/2, self.frame.size.height-20)
        self.addSubview(weatherLabel)
        
    }

}
