//
//  WeatherViewController.swift
//  YOJP
//
//  Created by PayBay on 15/11/9.
//  Copyright © 2015年 PayBay. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class WeatherViewController: UIViewController {

    
    var weatherModel : WeatherModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

       // self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "navigation_bar_backgroundClear"), forBarPosition: UIBarPosition.Any, barMetrics: UIBarMetrics.Default)
        
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "navigation_bar_backgroundClear"), forBarMetrics: UIBarMetrics.Default)
//        
//        self.navigationController?.navigationBar.alpha = 0.0
        

        self.view.backgroundColor = UIColor.whiteColor()
        
        let backImageView = UIImageView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
        backImageView.image = UIImage(named: "shanghai")
        self.view.addSubview(backImageView)
        
        let backBtn = UIButton(type: .Custom)
        backBtn.frame = CGRectMake(20, 30, 30, 30)
        backBtn.setBackgroundImage(UIImage(named: "箭头"), forState: UIControlState.Normal)
        backBtn.addTarget(self, action: Selector("backBtnPressed"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(backBtn)

        
        Alamofire.request(.GET, baiduWeatherAkBaseUrl, parameters: ["location":"上海","ak":baiduWeatherAk,"output":"json"])
            
            .response { request, response, data, error in
                
                if error == nil {
                    let json  = JSON(data: data!)
                    
                    
                    self.weatherModel = WeatherModel(json: json)
                    print(self.weatherModel.date)
                    print(self.weatherModel.results.currentCity)
                    print(self.weatherModel.results.pm25)
                    print(self.weatherModel.results.weather_data[0])
                    print(self.weatherModel.results.weather_data[0].date)
                    print(self.weatherModel.results.weather_data[0].dayPictureUrl)
                    print(self.weatherModel.results.weather_data[0].nightPictureUrl)
                    print(self.weatherModel.results.weather_data[0].weather)
                    print(self.weatherModel.results.weather_data[0].wind)
                    print(self.weatherModel.results.weather_data[0].temperature)
                    
                    for i in 0..<3 {
                        let weatherView = WeatherView(frame: CGRectMake(screenWidth/3*CGFloat(i),screenHeight-screenWidth/3-100,screenWidth/3,screenWidth/3-5))
                        weatherView.weatherLabel.text = self.weatherModel.results.weather_data[i].weather
                        switch i {
                        case 0:
                            weatherView.dataLabel.text = "今天"
                        case 1:
                            weatherView.dataLabel.text = "明天"
                        default:
                            weatherView.dataLabel.text = "后天"
                        }
                        
                        
                        var pm25 = Int(self.weatherModel.results.pm25!)
                        
                        if pm25 < 50 {
                            weatherView.pm25.text = "优"
                        }
                        else if pm25 < 100 {
                            weatherView.pm25.text = "良"
                        }
                        else if pm25 < 150 {
                            weatherView.pm25.text = "轻度"
                        }
                        else if pm25 < 200 {
                            weatherView.pm25.text = "中度"
                        }
                        else if pm25 < 300 {
                            weatherView.pm25.text = "重度"
                        }
                        else {
                           weatherView.pm25.text = "严重"
                        }
                        
                        
                        let temperatureString = self.weatherModel.results.weather_data[i].temperature
                        var array = temperatureString?.componentsSeparatedByCharactersInSet(NSCharacterSet(charactersInString:" ℃~"))
                        print(array)
                        weatherView.maxTemperatureLabel.text = String(format: "%@°", array![0])
                        weatherView.minTemperatureLabel.text = String(format: "%@°", array![3])
                        
                        weatherView.dayPictureUrlImageView.image = UIImage(named: "阴")
                        weatherView.dayPictureUrlImageView.image = UIImage(named: self.weatherModel.results.weather_data[i].weather!)
                        
                        self.view.addSubview(weatherView)
                    }
                    
                    
                    
                    for i in 0..<2 {
                        let lineImageView = UIImageView(frame: CGRectMake(screenWidth/3*CGFloat(i+1), screenHeight-screenWidth/6-120, 1, 35))
                        lineImageView.backgroundColor = UIColor.whiteColor()
                        lineImageView.alpha = 0.5
                        self.view.addSubview(lineImageView)
                    }

                }
                else {
                    
                }
        }

    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
//        self.navigationController?.navigationBar.setBackgroundImage(UIImage(named: "navigation_bar_backgroundBlue"), forBarMetrics: UIBarMetrics.Default)
//        self.navigationController?.navigationBar.alpha = 1.0
    }
    
    func backBtnPressed() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
