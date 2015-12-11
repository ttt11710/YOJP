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

class LeftViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,IQActionSheetPickerViewDelegate {

    
    var tableView : UITableView!
    
    var weatherModel : WeatherModel!
    
    var dataArray1 : NSMutableArray = ["全部","免费券","打折券","抵扣券","福袋"]
    var dataArray2 : NSMutableArray = ["卡券","行程","消息"]
    
    
    var cityArray : NSMutableArray = ["山中湖村","前桥","美瑛","冰库","富士山","大分","川本","枥木","德岛","鸟取","青森","千叶","广岛","鹿儿岛","金泽","北九州","神户","熊本","京都","松山","长崎","名古屋","那霸","奈良","新潟","冲绳","埼玉","大阪","札幌","长野","静冈","福冈","仙台"]
    
    var allWeatherViewBackView : UIView!
    var allWeatherView : UIView!
    
    var weatherView : WeatherView!
    
    var addressLabel : UILabel!
    var picker : IQActionSheetPickerView!
    var showPickerViewFlag : Bool = false
    
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
        self.requestData("上海")
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
        userCenterBtn.addTarget(self, action: Selector("userCenterBtnPressed"), forControlEvents: .TouchUpInside)
        self.view.addSubview(userCenterBtn)
        
        let collectBtn : UIButton = UIButton(frame: CGRectMake((screenWidth-80)/2+1,screenHeight-44,(screenWidth-80)/2,44))
        collectBtn.setTitle("我的收藏", forState: UIControlState.Normal)
        collectBtn.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        collectBtn.addTarget(self, action: Selector("collectBtnPressed"), forControlEvents: .TouchUpInside)
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

    func creatWeatherView() {
        
        
        self.allWeatherViewBackView = UIView(frame: CGRectMake(0,0,screenWidth,screenHeight))
        self.allWeatherViewBackView.backgroundColor = UIColor.clearColor()
        self.allWeatherViewBackView.userInteractionEnabled = true
        
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("removeAllWeatherViewBackView"))
        self.allWeatherViewBackView.addGestureRecognizer(tap)
        UIApplication.sharedApplication().keyWindow?.addSubview(self.allWeatherViewBackView)
        self.allWeatherView = UIView(frame: CGRectMake(0,150,screenWidth,screenWidth/3-5))
        
        
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.allWeatherViewBackView.backgroundColor = UIColor(white: 0, alpha: 0.8)
            }) { (finished : Bool) -> Void in
             self.allWeatherViewBackView.addSubview(self.allWeatherView)
        }
        
        
        let label = UILabel(frame:  CGRectMake(12,0,120,30))
        label.text = "天气情况"
        label.textColor = UIColor.whiteColor()
        self.allWeatherView.addSubview(label)
        
        
        self.addressLabel = UILabel(frame: CGRectMake(screenWidth-250,0,240,30))
        self.addressLabel.textAlignment = .Right
        self.addressLabel.textColor = UIColor.whiteColor()
        self.addressLabel.text = String(format: "当前位置:%@", self.weatherModel.results.currentCity!)
        
        let selectWeatherTap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("selectWeatherCity"))
            addressLabel.addGestureRecognizer(selectWeatherTap)
            addressLabel.userInteractionEnabled = true
        self.allWeatherView.addSubview(addressLabel)
        
        for i in 0..<3 {
            self.weatherView = WeatherView(frame: CGRectMake(screenWidth/3*CGFloat(i),30,screenWidth/3,screenWidth/3-5))
            weatherView.weatherLabel.text = self.weatherModel.results.weather_data[i].weather
            weatherView.myTag = i
            weatherView.weatherLabel.sizeToFit()
            
            switch i {
            case 0:
                weatherView.dataLabel.text = "今天"
            case 1:
                weatherView.dataLabel.text = "明天"
            default:
                weatherView.dataLabel.text = "后天"
            }
            
            
            let pm25 = Int(self.weatherModel.results.pm25!)
            
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
            
            self.allWeatherView.addSubview(weatherView)
        }
        
        
        
        for i in 0..<2 {
            let lineImageView = UIImageView(frame: CGRectMake(screenWidth/3*CGFloat(i+1), (screenWidth/3-35)/2+30, 1, 35))
            lineImageView.backgroundColor = UIColor.whiteColor()
            lineImageView.alpha = 0.5
            self.allWeatherView.addSubview(lineImageView)
        }

    }
    
    func removeAllWeatherViewBackView() {
        if self.showPickerViewFlag {
           self.picker.dismiss()
           self.showPickerViewFlag = false
        }
        else {
           self.allWeatherViewBackView.removeFromSuperview()
        }
        
        
        
    }
    
    func requestData(location : String) {
        Alamofire.request(.GET, baiduWeatherAkBaseUrl, parameters: ["location":location,"ak":baiduWeatherAk,"output":"json"])
        
            .response { request, response, data, error in
                
                if error == nil {
                    let json  = JSON(data: data!)

                    self.weatherModel = WeatherModel(json: json)
                    self.tableView.reloadData()
                 //   self.updataWeatherView()
                }
        }
    }
    
    func updataWeatherView() {
        
        if self.allWeatherViewBackView != nil {
            self.addressLabel.text = String(format: "当前位置:%@", self.weatherModel.results.currentCity!)
            
            
            for view in self.allWeatherView.subviews {
                if view.isKindOfClass(WeatherView) {
                    
                    let view  = view as! WeatherView
                    
                    let pm25 = Int(self.weatherModel.results.pm25!)
                    
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
                    
                    let temperatureString = self.weatherModel.results.weather_data[view.myTag].temperature
                    var array = temperatureString?.componentsSeparatedByCharactersInSet(NSCharacterSet(charactersInString:" ℃~"))
                    print(array)
                    weatherView.maxTemperatureLabel.text = String(format: "%@°", array![0])
                    weatherView.minTemperatureLabel.text = String(format: "%@°", array![3])
                    
                    weatherView.dayPictureUrlImageView.image = UIImage(named: "阴")
                    weatherView.dayPictureUrlImageView.image = UIImage(named: self.weatherModel.results.weather_data[view.myTag].weather!)
                }
                
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
                    let weatherView = WeatherView(frame: CGRectMake(16,10,screenWidth/3,128))
                    weatherView.weatherLabel.text = self.weatherModel.results.weather_data[0].weather
                    weatherView.weatherLabel.sizeToFit()
                    weatherView.dataLabel.text = "今天"
                    let pm25 = Int(self.weatherModel.results.pm25!)
                    
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
                    
                  //  weatherView.addressLabel.text = String(format: "当前位置:%@", self.weatherModel.results.currentCity!)
                    
                    cell.backgroundColor = UIColor.clearColor()
                    
                    let lineImageView : UIImageView = UIImageView(frame: CGRectMake(16, weatherView.frame.origin.y + weatherView.frame.size.height+8, screenWidth-80-32, 1))
                    lineImageView.alpha = 0.2
                    lineImageView.backgroundColor = yojpLightCell
                    
                    
                    
                    let searchBtn = UIButton(type: .Custom)
                    searchBtn.center = CGPointMake((screenWidth-80)/2, lineImageView.frame.origin.y + lineImageView.frame.size.height + 15 + 8)
                    searchBtn.bounds = CGRectMake(0, 0, 255, 30)
                    searchBtn.setImage(UIImage(named: "search"), forState: .Normal)
                    searchBtn.addTarget(self, action: Selector("showSearchView"), forControlEvents: .TouchUpInside)
                    
                    cell.contentView.addSubview(weatherView)
                    cell.contentView.addSubview(lineImageView)
                    cell.contentView.addSubview(searchBtn)
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
        return indexPath.row == 0 && indexPath.section == 0 ? 184 : 44
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == 0 ? 40 : 0
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view : UIView = UIView(frame: CGRectMake(0,0,screenWidth-80,40))
        view.backgroundColor = UIColor.clearColor()
        
        return view
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                self.creatWeatherView()
            }
            else {
                self.mm_drawerController.closeDrawerAnimated(true) { (finished : Bool) -> Void in
                    MainViewController.shareMainViewController().changeNavigationItemTitleView(indexPath.row)
                }
 
            }
        }
        else if indexPath.section == 1 {
            if indexPath.row == 0 {
                self.mm_drawerController.closeDrawerAnimated(true, completion: { (finished : Bool) -> Void in
                    
                    MainViewController.shareMainViewController().navigationController?.pushViewController(CardListViewController(), animated: true)
                    MainViewController.shareMainViewController().changeShowLeftBtnType()
                })
            }
            else if indexPath.row == 1 {
                self.mm_drawerController.closeDrawerAnimated(true, completion: { (finished : Bool) -> Void in
                    
                    MainViewController.shareMainViewController().navigationController?.pushViewController(SchedulingViewController(), animated: true)
                    MainViewController.shareMainViewController().changeShowLeftBtnType()
                })
                
            }
                
            else if indexPath.row == 2 {
                self.mm_drawerController.closeDrawerAnimated(true, completion: { (finished : Bool) -> Void in
                    
                    MainViewController.shareMainViewController().navigationController?.pushViewController(MessageViewController(), animated: true)
                    MainViewController.shareMainViewController().changeShowLeftBtnType()
                })

            }
        }
    }
    
    
    func userCenterBtnPressed() {
        self.mm_drawerController.closeDrawerAnimated(true, completion: { (finished : Bool) -> Void in
            
            MainViewController.shareMainViewController().navigationController?.pushViewController(UserCentreViewController(), animated: true)
            MainViewController.shareMainViewController().changeShowLeftBtnType()
        })
    }
    
    func collectBtnPressed() {
        self.mm_drawerController.closeDrawerAnimated(true, completion: { (finished : Bool) -> Void in
            
            MainViewController.shareMainViewController().navigationController?.pushViewController(CollectViewController(), animated: true)
            MainViewController.shareMainViewController().changeShowLeftBtnType()
        })
    }
    
    func showSearchView() {
        
        self.mm_drawerController.closeDrawerAnimated(true) { (finished : Bool) -> Void in
            
            MainViewController.shareMainViewController().changeShowLeftBtnType()
            MainViewController.shareMainViewController().presentSearchView()
            
        }
    }
    
    func selectWeatherCity() {
       
        if self.picker == nil {
            self.picker = IQActionSheetPickerView(title: "Single Picker", delegate: self)
            self.picker.titlesForComponenets = [self.cityArray]
            self.picker.selectRow(0, inComponent: 0, animated: true)
            self.picker.show()
            self.showPickerViewFlag = true
        }
        else if !self.showPickerViewFlag {
            self.picker.selectRow(0, inComponent: 0, animated: true)
            self.picker.show()
            self.showPickerViewFlag = true
        }
    }
    
    func actionSheetPickerView(pickerView: IQActionSheetPickerView!, didSelectTitles titles: [AnyObject]!) {
        
        let array : NSArray = titles as NSArray
        self.addressLabel.text = String(format: "当前位置:%@", array[0] as! String )
        self.showPickerViewFlag = false
       // self.requestData(array[0] as! String)
    }
    
    func pickerCancelClicked(barButton: UIBarButtonItem!) {
        print("pickerCancelClicked")
        self.showPickerViewFlag = false
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
