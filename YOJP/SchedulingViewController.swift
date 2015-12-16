//
//  SchedulingViewController.swift
//  YOJP
//
//  Created by PayBay on 15/12/8.
//  Copyright © 2015年 PayBay. All rights reserved.
//

import UIKit

class SchedulingViewController: UIViewController,IQActionSheetPickerViewDelegate,UITableViewDelegate,UITableViewDataSource {

    
    var customNavigationBar : UIView!
    
    var chooseScheduingView : UIView!
    
    var cityBtn : UIButton!
    var picker : IQActionSheetPickerView!
    var cityArray : NSMutableArray = ["山中湖村","前桥","美瑛","冰库","富士山","大分","川本","枥木","德岛","鸟取","青森","千叶","广岛","鹿儿岛","金泽","北九州","神户","熊本","京都","松山","长崎","名古屋","那霸","奈良","新潟","冲绳","埼玉","大阪","札幌","长野","静冈","福冈","仙台"]
    
    
    var beginDateBtn : UIButton!
    var endDateBtn : UIButton!
    var beginDateString : String = ""
    var endDateString : String = ""
    var altogetherDay : Int = 0
    
    
    var backView : UIView!
    var datePicker : UIDatePicker!
    var changeTypeDate : Int = 0
    
    
    var scrollView : UIScrollView!
    
    var tableView : UITableView!
    
    
    var dict = [Int:NSMutableDictionary]()
    var array : NSMutableArray = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = yojpTableViewColor
        self.creatCustomNavigationBar()
        self.creatChooseScheduingView()
        self.creatDatePickerView()
        
     //   dict = [1:["时间":"2015.12.11","数据":["滑雪","溜冰","自由安排"]],2:["时间":"2015.12.11","数据":["泡温泉","小吃街","游船"]],3:["时间":"2015.12.11","数据":["登山","环岛自行车","购物一条街"]]]
        
        
        // Do any additional setup after loading the view.
    }

    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.sharedApplication().statusBarStyle = .Default
        self.navigationController?.navigationBarHidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBarHidden = false
    }
    
    func creatCustomNavigationBar() {
        self.customNavigationBar = UIView(frame: CGRectMake(0,screenHeight-44,screenWidth,44))
        self.customNavigationBar.backgroundColor = yojpBlue
        
        
        let backBtn = UIButton(type: .Custom)
        backBtn.frame = CGRectMake(20, 7, 30, 30)
        backBtn.setBackgroundImage(UIImage(named: "箭头"), forState: UIControlState.Normal)
        backBtn.addTarget(self, action: Selector("backClicked"), forControlEvents: UIControlEvents.TouchUpInside)
        self.customNavigationBar.addSubview(backBtn)
        
        
        let addScheduingBtn = UIButton(type: .Custom)
        addScheduingBtn.frame = CGRectMake(screenWidth-50, 7, 30, 30)
        addScheduingBtn.setBackgroundImage(UIImage(named: "新建行程"), forState: UIControlState.Normal)
        addScheduingBtn.setBackgroundImage(UIImage(named: "新建行程"), forState: UIControlState.Highlighted)
        addScheduingBtn.addTarget(self, action: Selector("addScheduingBtnClicked"), forControlEvents: UIControlEvents.TouchUpInside)
        //self.customNavigationBar.addSubview(addScheduingBtn)
        
        self.view.addSubview(self.customNavigationBar)
    }
    
    func creatChooseScheduingView() {
        
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("dismissPickerView"))
        self.view.addGestureRecognizer(tap)
        self.view.userInteractionEnabled = true
        
        self.chooseScheduingView = UIView(frame: CGRectMake(16,screenHeight/3,screenWidth-32,screenHeight/2))
        self.chooseScheduingView.backgroundColor = UIColor.whiteColor()
        self.view.addSubview(self.chooseScheduingView)
        
        let constLabel : UILabel = UILabel()
        constLabel.text = "请选择行程"
        constLabel.textAlignment = .Center
        constLabel.center = CGPointMake((screenWidth-32)/2, 30)
        constLabel.bounds = CGRectMake(0, 0, 200, 30)
        constLabel.textColor = yojpText
        constLabel.font = font15
        self.chooseScheduingView.addSubview(constLabel)
        
        
        let lineImageView = UIImageView(frame: CGRectMake(0, 60, screenWidth-32, 1))
        lineImageView.image = UIImage(named: "dashedLine")
        self.chooseScheduingView.addSubview(lineImageView)
    
        
        self.cityBtn = UIButton(frame: CGRectMake(16,80,screenWidth-64,40))
        self.cityBtn.setTitle("请选择城市", forState: .Normal)
        self.cityBtn.setTitleColor(yojpText, forState: .Normal)
        self.cityBtn.addTarget(self, action: Selector("selectCityBtnPressed"), forControlEvents: .TouchUpInside)
        self.cityBtn.titleLabel?.font = font15
        self.cityBtn.backgroundColor = yojpTableViewColor
        self.chooseScheduingView.addSubview(self.cityBtn)
        
        let constSchedulingLabel : UILabel = UILabel(frame: CGRectMake(16,self.cityBtn.frame.origin.y+self.cityBtn.frame.size.height+16,100,25))
        constSchedulingLabel.text = "日程安排"
        constSchedulingLabel.textColor = yojpLightText
        constSchedulingLabel.font = font14
        self.chooseScheduingView.addSubview(constSchedulingLabel)
       
        self.beginDateBtn = UIButton(frame: CGRectMake(16,constSchedulingLabel.frame.origin.y + constSchedulingLabel.frame.size.height + 16,(self.chooseScheduingView.frame.size.width-48)/2,50))
        self.beginDateBtn.setTitle("出发日期", forState: .Normal)
        self.beginDateBtn.setTitleColor(yojpText, forState: .Normal)
        self.beginDateBtn.titleLabel?.font = font15
        self.beginDateBtn.tag = 1
        self.beginDateBtn.backgroundColor = yojpTableViewColor
        self.beginDateBtn.addTarget(self, action: Selector("selectBeginDatePressed:"), forControlEvents: .TouchUpInside)
        self.chooseScheduingView.addSubview(self.beginDateBtn)
        
        
        let imageView : UIImageView = UIImageView(frame: CGRectMake(self.beginDateBtn.frame.origin.x + self.beginDateBtn.frame.size.width + 1, self.beginDateBtn.center.y, 14, 1))
        imageView.backgroundColor = yojpText
        self.chooseScheduingView.addSubview(imageView)
        
        
        self.endDateBtn = UIButton(frame: CGRectMake(self.beginDateBtn.frame.size.width+32,constSchedulingLabel.frame.origin.y + constSchedulingLabel.frame.size.height + 16,(self.chooseScheduingView.frame.size.width-48)/2,50))
        self.endDateBtn.setTitle("结束日期", forState: .Normal)
        self.endDateBtn.setTitleColor(yojpText, forState: .Normal)
        self.endDateBtn.titleLabel?.font = font15
        self.endDateBtn.tag = 2
        self.endDateBtn.backgroundColor = yojpTableViewColor
        self.endDateBtn.addTarget(self, action: Selector("selectBeginDatePressed:"), forControlEvents: .TouchUpInside)
        self.chooseScheduingView.addSubview(self.endDateBtn)
        self.endDateBtn.userInteractionEnabled = false
        self.endDateBtn.alpha = 0.5
        
        let sureBtn : UIButton = UIButton(frame: CGRectMake(0,screenHeight/2-40,screenWidth-32,40))
        sureBtn.setTitle("确定", forState: .Normal)
        sureBtn.backgroundColor = yojpBlue
        sureBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        sureBtn.addTarget(self, action: Selector("sureBtnPressed"), forControlEvents: .TouchUpInside)
        self.chooseScheduingView.addSubview(sureBtn)
    }
    
    func creatDatePickerView() {
        self.backView = UIView(frame: CGRectMake(0,0,screenWidth,screenHeight))
        self.backView.backgroundColor = UIColor(white: 0, alpha: 0.5)
        self.backView.hidden = true
        self.view.addSubview(self.backView)
        
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("showOrHiddenDatePickerView"))
        
        self.backView.addGestureRecognizer(tap)
        self.backView.userInteractionEnabled = true
        
        
        let view : UIView = UIView()
        view.backgroundColor = UIColor.whiteColor()
        view.center = CGPointMake(screenWidth/2, screenHeight/2)
        view.bounds = CGRectMake(0, 0, screenWidth-32, screenWidth-32)
        backView.addSubview(view)
        
        self.datePicker = UIDatePicker()
        self.datePicker.datePickerMode = .Date
        self.datePicker.locale = NSLocale(localeIdentifier: "zh_CN")
        self.datePicker.center = CGPointMake(view.frame.size.width/2, view.frame.size.height/2)
        self.datePicker.minimumDate = NSDate()
        view.addSubview(self.datePicker)
    }
    
    func selectCityBtnPressed() {
        
        if self.picker == nil {
            self.picker = IQActionSheetPickerView(title: "Single Picker", delegate: self)
            self.picker.titlesForComponenets = [self.cityArray]
            self.picker.selectRow(0, inComponent: 0, animated: true)
            self.picker.show()

        }
        else {
            self.picker.selectRow(0, inComponent: 0, animated: true)
            self.picker.show()
        }
    }
    
    func actionSheetPickerView(pickerView: IQActionSheetPickerView!, didSelectTitles titles: [AnyObject]!) {
        
        let array : NSArray = titles as NSArray
        let string = String(format: "所在地   %@", array[0] as! String)
        self.cityBtn.setTitle(string, forState: .Normal)
    }
    
    func pickerCancelClicked(barButton: UIBarButtonItem!) {
        print("pickerCancelClicked")

    }
    
    func selectBeginDatePressed(sender : UIButton) {
        
        self.backView.hidden = false
        
        self.changeTypeDate = sender.tag
        
        
        if !self.endDateString.isEmpty && !self.beginDateString.isEmpty {
            switch self.changeTypeDate {
            case 1:
                self.datePicker.minimumDate = NSDate()
                let dateFormat : NSDateFormatter = NSDateFormatter()
                dateFormat.dateFormat = "yyyy.MM.dd"
                self.datePicker.maximumDate = dateFormat.dateFromString(self.endDateString)!
                
            default:
                let dateFormat : NSDateFormatter = NSDateFormatter()
                dateFormat.dateFormat = "yyyy.MM.dd"
                self.datePicker.minimumDate = dateFormat.dateFromString(self.beginDateString)!
                self.datePicker.maximumDate = nil
            }
        }
        
        if self.endDateString.isEmpty && !self.beginDateString.isEmpty {
            switch self.changeTypeDate {
            case 1:
                self.datePicker.minimumDate = NSDate()
                self.datePicker.maximumDate = nil
                
            default:
                let dateFormat : NSDateFormatter = NSDateFormatter()
                dateFormat.dateFormat = "yyyy.MM.dd"
                self.datePicker.minimumDate = dateFormat.dateFromString(self.beginDateString)!
                self.datePicker.maximumDate = nil
            }
        }
        
    }
    
    
    func showOrHiddenDatePickerView() {
        self.backView.hidden = true
        print(self.datePicker.date)
        let dateFormat : NSDateFormatter = NSDateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        let string : String = dateFormat.stringFromDate(self.datePicker.date)
        
            switch self.changeTypeDate {
            case 1:
                self.beginDateBtn.setTitle(string, forState: .Normal)
                self.datePicker.minimumDate = self.datePicker.date
                self.datePicker.maximumDate = nil
                self.endDateBtn.userInteractionEnabled = true
                self.endDateBtn.alpha = 1
                self.beginDateString = string
                
            default:
                self.endDateBtn.setTitle(string, forState: .Normal)
                self.datePicker.minimumDate = NSDate()
                self.datePicker.maximumDate = self.datePicker.date
                self.endDateString = string
            }
        
    }
    
    func sureBtnPressed() {
        
        if self.endDateString.isEmpty || self.beginDateString.isEmpty {
            SVProgressShow.showInfoWithStatus("日期未设定!")
            return
        }
        if !self.endDateString.isEmpty && !self.beginDateString.isEmpty {
            
            let dateFormat : NSDateFormatter = NSDateFormatter()
            dateFormat.dateFormat = "yyyy.MM.dd"
            let interval : NSTimeInterval = dateFormat.dateFromString(self.endDateString)!.timeIntervalSinceDate(dateFormat.dateFromString(self.beginDateString)!)
            let days = (Int(interval))/86400+1
            
            for i in 1...days {
                
                dict[i] = ["时间":dateFormat.stringFromDate(NSDate(timeInterval: NSTimeInterval(24*3600*(i-1)), sinceDate: dateFormat.dateFromString(self.beginDateString)!)),"数据":["","",""]]
                
                let dictt : NSMutableDictionary = ["时间":dateFormat.stringFromDate(NSDate(timeInterval: NSTimeInterval(24*3600*(i-1)), sinceDate: dateFormat.dateFromString(self.beginDateString)!)),"数据":["","",""]]
                array.addObject(dictt)
                
               // array.addObject(["时间":dateFormat.stringFromDate(NSDate(timeInterval: NSTimeInterval(24*3600*(i-1)), sinceDate: dateFormat.dateFromString(self.beginDateString)!)),"数据":["","",""]])
            }
            
        }

        self.creatTableView()
        
//        self.scrollView = UIScrollView(frame: CGRectMake(0,0,screenWidth,screenHeight-44))
//        self.scrollView.contentSize = CGSizeMake(screenWidth*3, 0)
//        self.scrollView.contentOffset = CGPointMake(0, 0)
//        self.scrollView.pagingEnabled = true
//        self.view.addSubview(self.scrollView)
//        
//        
//        for i in 0...2 {
//            let nib : NSArray = NSBundle.mainBundle().loadNibNamed("MySchedulingView", owner: nil, options: nil)
//            let mySchedulingView : MySchedulingView = nib.objectAtIndex(0) as! MySchedulingView
//            mySchedulingView.tag = i
//            mySchedulingView.frame = CGRectMake(16 + CGFloat(i)*screenWidth, screenHeight/3, screenWidth-32, screenHeight/2)
//            mySchedulingView.setView()
//            mySchedulingView.noButton.setTitle(String(format: "%d/3", i+1), forState: .Normal)
//            mySchedulingView.noLabel.text = String(format: "第%d天", i+1)
//            mySchedulingView.addItemBtn.tag = i
//            mySchedulingView.addItemBtn.callBack = { tag in
//             
//                print(tag)
//            }
//            self.scrollView.addSubview(mySchedulingView)
//            
//            
//        }
        
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.chooseScheduingView.alpha = 0
            }) { (finished : Bool) -> Void in
                
        }
        UIView.animateWithDuration(0.5, animations: { () -> Void in
            self.tableView.alpha = 1
            }) { (finished : Bool) -> Void in
                
        }
    }
    
    func backClicked() {
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    func dismissPickerView() {
      //  self.picker.dismiss()
    }

    
    func creatTableView() {
        self.tableView = UITableView(frame: CGRectMake((screenHeight-screenWidth)/2, 7*screenHeight/12-screenWidth/2, screenHeight/2,screenWidth), style: .Plain)
        self.tableView.tableFooterView = UIView()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .None
        self.tableView.backgroundColor = yojpTableViewColor
        self.view.addSubview(self.tableView)
        
        self.tableView.center = CGPointMake(screenWidth/2, screenHeight/12*7)
        self.tableView.transform = CGAffineTransformMakeRotation(-CGFloat(M_PI/2.000000))
        self.tableView.showsVerticalScrollIndicator = false
        
        self.tableView.alpha = 0
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if tableView == self.tableView {
            return 1
        }
        else {
            return 3
        }
        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == self.tableView {
            return array.count
        }
        else {
            return 1
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if tableView == self.tableView {
            return screenWidth
        }
        else {
            return  (screenHeight/2-110-40-8)/3
        }
        
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        if tableView == self.tableView {
            tableView.registerNib(UINib(nibName: "SchedulingTableViewCell", bundle: nil), forCellReuseIdentifier: "SchedulingTableViewCellId")
            let cell = tableView.dequeueReusableCellWithIdentifier("SchedulingTableViewCellId", forIndexPath: indexPath) as! SchedulingTableViewCell
            
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            cell.contentView.backgroundColor = yojpTableViewColor
            
            cell.dateLabel.text = array[indexPath.row]["时间"] as? String
            cell.noButton.setTitle(String(format: "%d/%d", indexPath.row+1,self.array.count), forState: .Normal)
            cell.noLabel.text = String(format: "第%d天", indexPath.row+1)
            cell.addItemBtn.tag = indexPath.row
            cell.addItemBtn.callBack = { tag in
                
                print(tag)
            }
            
            cell.garbageBtn.tag = indexPath.row
            cell.garbageBtn.callBack = { tag in
                
                self.array.removeObjectAtIndex(tag)
                
                
                let dateFormat : NSDateFormatter = NSDateFormatter()
                dateFormat.dateFormat = "yyyy.MM.dd"
                
                
                for i in 0..<self.array.count {
                    
                    
                 //   array.addObject(["时间":dateFormat.stringFromDate(NSDate(timeInterval: NSTimeInterval(24*3600*(i-1)), sinceDate: dateFormat.dateFromString(self.beginDateString)!)),"数据":["","",""]])
                    
                    let string1 : String = dateFormat.stringFromDate(NSDate(timeInterval: NSTimeInterval(24*3600*(i)), sinceDate: dateFormat.dateFromString(self.beginDateString)!))
                    
                    (self.array.objectAtIndex(i) as! NSMutableDictionary)["时间"]  = string1
                    
                }

                
                
                self.tableView.reloadData()
                
                if self.array.count == 0 {
                    
                    self.tableView.alpha = 0
                    UIView.animateWithDuration(0.5, animations: { () -> Void in
                        self.chooseScheduingView.alpha = 1
                        }) { (finished : Bool) -> Void in
                        
                    }
                }
                
                print(tag)
            }
            
            
            cell.transform = CGAffineTransformMakeRotation(CGFloat(M_PI/2.000000))
            
            
            let tableView = UITableView(frame: CGRectMake(16, 110, screenWidth-32,screenHeight/2-110-40), style: .Plain)
            tableView.tableFooterView = UIView()
            tableView.delegate = self
            tableView.dataSource = self
            tableView.tag = indexPath.row
            tableView.separatorStyle = .None
            tableView.showsVerticalScrollIndicator = false
            tableView.showsHorizontalScrollIndicator = false
            tableView.backgroundColor = UIColor.whiteColor()
            cell.addSubview(tableView)
            
            
            return cell
        }
        else {
            tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cellId")
            let cell : UITableViewCell = UITableViewCell(style: .Subtitle, reuseIdentifier: "cellId")
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.backgroundColor = yojpTableViewColor
            
            cell.textLabel?.text = (array[tableView.tag]["数据"] as! NSArray).objectAtIndex(indexPath.section) as? String

            cell.textLabel?.font = font14
            cell.textLabel?.textColor = yojpText
                        return cell

        }
        
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if tableView == self.tableView {
            return 0
        }
        else {
           return 4
        }
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRectMake(0,0,screenWidth-32,4))
        view.backgroundColor = UIColor.whiteColor()
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
