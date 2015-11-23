//
//  WeatherModel.swift
//  YOJP
//
//  Created by PayBay on 15/11/9.
//  Copyright © 2015年 PayBay. All rights reserved.
//

import UIKit
import SwiftyJSON


class WeatherData : NSObject {
    var date : String?
    var dayPictureUrl : String?
    var nightPictureUrl : String?
    var weather : String?
    var wind : String?
    var temperature : String?
    
    
    init(json : JSON) {
        date = json["date"].stringValue ?? "日期"
        dayPictureUrl = json["dayPictureUrl"].stringValue ?? "url"
        nightPictureUrl = json["nightPictureUrl"].stringValue ?? "url"
        weather = json["weather"].stringValue ?? "天气"
        wind = json["wind"].stringValue ?? "风力"
        temperature = json["temperature"].stringValue ?? "温度"
    }
    
    class func weatherData(json:JSON) -> [WeatherData] {
        
        return json["weather_data"].arrayValue.map{WeatherData(json: $0)}
    }
}


class WeatherResults : NSObject {
    
    var currentCity : String?
    var pm25 : String?
    var weather_data : [WeatherData]
    
    init(json : JSON) {
        currentCity = json["currentCity"].stringValue ?? "城市"
        pm25 = json["pm25"].stringValue ?? "pm25"
        weather_data = WeatherData.weatherData(json)
    }
    
}

class WeatherModel: NSObject {
    
    var date : String?
    var results : WeatherResults!
    
    init(json : JSON) {
    
        date = json["date"].stringValue ?? "日期"
        results = WeatherResults(json: json["results"][0])
    }
}
