//
//  SchedulingViewController.swift
//  YOJP
//
//  Created by PayBay on 15/12/8.
//  Copyright © 2015年 PayBay. All rights reserved.
//

import UIKit

class SchedulingViewController: UIViewController,IQActionSheetPickerViewDelegate {

    
    var customNavigationBar : UIView!
    
    var chooseScheduingView : UIView!
    
    var cityBtn : UIButton!
    var picker : IQActionSheetPickerView!
    var cityArray : NSMutableArray = ["山中湖村","前桥","美瑛","冰库","富士山","大分","川本","枥木","德岛","鸟取","青森","千叶","广岛","鹿儿岛","金泽","北九州","神户","熊本","京都","松山","长崎","名古屋","那霸","奈良","新潟","冲绳","埼玉","大阪","札幌","长野","静冈","福冈","仙台"]
    
    
    var beginDateBtn : UIButton!
    var endDateBtn : UIButton!
    
    var backView : UIView!
    var datePicker : UIDatePicker!
    var changeTypeDate : Int = 0
    
    
    var scrollView : UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = yojpTableViewColor
        self.creatCustomNavigationBar()
        self.creatChooseScheduingView()
        self.creatDatePickerView()
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
    }

    
    func showOrHiddenDatePickerView() {
        self.backView.hidden = true
         print(self.datePicker.date)
        let dateFormat : NSDateFormatter = NSDateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        let string : String = dateFormat.stringFromDate(self.datePicker.date)
        print(string)
        switch self.changeTypeDate {
        case 1:
            self.beginDateBtn.setTitle(string, forState: .Normal)
            self.datePicker.minimumDate = self.datePicker.date
            self.datePicker.maximumDate = nil
        default:
            self.endDateBtn.setTitle(string, forState: .Normal)
            self.datePicker.minimumDate = NSDate()
            self.datePicker.maximumDate = self.datePicker.date
        }
        
    }
    
    func sureBtnPressed() {
        
        
        self.scrollView = UIScrollView(frame: CGRectMake(0,screenHeight/3,screenWidth,screenHeight/2))
        self.scrollView.contentSize = CGSizeMake(screenWidth*3, 0)
        self.scrollView.contentOffset = CGPointMake(0, 0)
        self.scrollView.pagingEnabled = true
        self.view.addSubview(self.scrollView)
        
        
        UIView.animateWithDuration(0.5, animations: { () -> Void in
                self.chooseScheduingView.alpha = 0
            }) { (finished : Bool) -> Void in
             
        }
    }
    
    func backClicked() {
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    func dismissPickerView() {
      //  self.picker.dismiss()
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
