//
//  LeftViewController.swift
//  YOJP
//
//  Created by PayBay on 15/11/11.
//  Copyright © 2015年 PayBay. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class LeftViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    var tableView : UITableView!
    
    var weatherModel : WeatherModel!
    
    var dataArray1 : NSMutableArray = ["全部","免费券","打折券","抵扣券","福袋"]
    var dataArray2 : NSMutableArray = ["卡券","行程","消息"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor(white: 0, alpha: 0.9)
        self.navigationController?.navigationBarHidden = true
        
        
        let backImageView : UIImageView = UIImageView(image: UIImage(named: "LeftViewbackView"))
        backImageView.frame = CGRectMake(0, 0, screenWidth-80, screenHeight)
        self.view.addSubview(backImageView)
        
        let backView : UIView = UIView(frame: CGRectMake(0,0,screenWidth-80,screenHeight))
        backView.backgroundColor = UIColor(white: 0, alpha: 0.85)
        self.view.addSubview(backView)
        
        self.creatTableView()
        self.requestData()
        self.creatBtn()
        
    }
    
    func creatTableView() {
        tableView = UITableView(frame: CGRectMake(0, 0, screenWidth, screenHeight-44))
        tableView.separatorStyle = .None
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = UIColor.clearColor()
        
        self.view.addSubview(tableView)
    }
    
    func creatBtn() {
        
        let userCenterBtn : UIButton = UIButton(frame: CGRectMake(0,screenHeight-44,(screenWidth-80)/2,44))
        userCenterBtn.setTitle("个人中心", forState: UIControlState.Normal)
        userCenterBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        userCenterBtn.alpha = 0.8
        self.view.addSubview(userCenterBtn)
        
        let collectBtn : UIButton = UIButton(frame: CGRectMake((screenWidth-80)/2+1,screenHeight-44,(screenWidth-80)/2,44))
        collectBtn.setTitle("我的收藏", forState: UIControlState.Normal)
        collectBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        collectBtn.alpha = 0.8
        self.view.addSubview(collectBtn)
        
        let horLineImageView : UIImageView = UIImageView(frame: CGRectMake(8, screenHeight-45, screenWidth-80-16, 1))
        horLineImageView.backgroundColor = UIColor.whiteColor()
        horLineImageView.alpha = 0.2
        self.view.addSubview(horLineImageView)
        
        
        let verLineImageView : UIImageView = UIImageView(frame: CGRectMake((screenWidth-80)/2, screenHeight-38, 1, 28))
        verLineImageView.backgroundColor = UIColor.whiteColor()
        verLineImageView.alpha = 0.2
        self.view.addSubview(verLineImageView)
    }
    
    func requestData() {
        Alamofire.request(.GET, baiduWeatherAkBaseUrl, parameters: ["location":"上海","ak":baiduWeatherAk,"output":"json"])
        
            .response { request, response, data, error in
                
                if error == nil {
                    let json  = JSON(data: data!)

                    self.weatherModel = WeatherModel(json: json)
                    self.tableView.reloadData()
                }
        }
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 6 : 3
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cellId")
                let cell = tableView.dequeueReusableCellWithIdentifier("cellId", forIndexPath: indexPath) as UITableViewCell
                
                cell.selectionStyle = .None
                
                if self.weatherModel != nil {
                    let weatherView = WeatherView(frame: CGRectMake(16,10,screenWidth/3,screenWidth/3+40))
                    weatherView.weatherLabel.text = self.weatherModel.results.weather_data[0].weather
                    weatherView.dataLabel.text = "今天"
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
                    let temperatureString = self.weatherModel.results.weather_data[0].temperature
                    var array = temperatureString?.componentsSeparatedByCharactersInSet(NSCharacterSet(charactersInString:" ℃~"))
                    print(array)
                    weatherView.maxTemperatureLabel.text = String(format: "%@℃", array![0])
                    weatherView.minTemperatureLabel.text = String(format: "%@℃", array![3])
                    
                    weatherView.dayPictureUrlImageView.image = UIImage(named: "阴")
                    weatherView.dayPictureUrlImageView.image = UIImage(named: self.weatherModel.results.weather_data[0].weather!)
                    
                    weatherView.addressLabel.text = String(format: "当前位置:%@", self.weatherModel.results.currentCity!)
                    
                    cell.backgroundColor = UIColor.clearColor()
                    
                    let lineImageView : UIImageView = UIImageView(frame: CGRectMake(16, cell.frame.size.height-1, screenWidth-80-32, 1))
                    lineImageView.alpha = 0.2
                    lineImageView.backgroundColor = yojpLightCell
                    
                    cell.contentView.addSubview(weatherView)
                    cell.contentView.addSubview(lineImageView)
                }
                return cell
                
            }
            else {
                tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cellId")
                let cell = tableView.dequeueReusableCellWithIdentifier("cellId", forIndexPath: indexPath) as UITableViewCell
                
                cell.selectionStyle = .None
                
                let string : String = self.dataArray1[indexPath.row-1] as! String
                cell.imageView?.image = UIImage(named: string)
                cell.textLabel?.text = string
                cell.textLabel?.textColor = yojpLightText
                cell.backgroundColor = UIColor.clearColor()
                
                return cell
                
            }
            
        }
        else {
            tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cellId")
            let cell = tableView.dequeueReusableCellWithIdentifier("cellId", forIndexPath: indexPath) as UITableViewCell
            
            cell.selectionStyle = .None
            
            let string : String = self.dataArray2[indexPath.row] as! String
            cell.imageView?.image = UIImage(named: string)
            cell.textLabel?.text = string
            cell.textLabel?.textColor = yojpLightText
            cell.backgroundColor = UIColor.clearColor()
            
            return cell
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return indexPath.row == 0 && indexPath.section == 0 ? screenWidth/3+50 : 44
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == 0 ? 60 : 0
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view : UIView = UIView(frame: CGRectMake(0,0,screenWidth-80,60))
        view.backgroundColor = UIColor.clearColor()
        
        return view
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
