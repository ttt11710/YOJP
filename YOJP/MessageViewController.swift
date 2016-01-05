//
//  MessageViewController.swift
//  YOJP
//
//  Created by PayBay on 15/12/7.
//  Copyright © 2015年 PayBay. All rights reserved.
//

import UIKit

class MessageViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    var customNavigationBar : UIView!
    
    var tableView : UITableView!
    var tableViewDataArray1 : NSMutableArray = ["收音机","信息","信息","收音机","收音机"]
    var tableViewDataArray2 : NSMutableArray = ["今日13:14,日本北海道发生4.2级地震","您有一张免费券3天后即将失效","您消费了一张抵扣券","今日13:14,日本北海道发生4.2级地震","今日13:14,日本北海道发生4.2级地震"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       // self.view.backgroundColor = yojpTableViewColor

        self.view.backgroundColor = UIColor.whiteColor()
        
        self.creatCustomNavigationBar()
        self.creatTableView()
        
        // Do any additional setup after loading the view.
    }

//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        UIApplication.sharedApplication().statusBarStyle = .Default
//        self.navigationController?.navigationBarHidden = true
//    }
//    
//    override func viewWillDisappear(animated: Bool) {
//        super.viewWillDisappear(animated)
//        self.navigationController?.navigationBarHidden = false
//    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.sharedApplication().statusBarStyle = .Default
        self.navigationController?.navigationBar.alpha = 0
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        self.navigationController?.navigationBar.alpha = 1
    }


    func creatCustomNavigationBar() {
        self.customNavigationBar = UIView(frame: CGRectMake(0,screenHeight-44,screenWidth,44))
        self.customNavigationBar.backgroundColor = yojpBlue
        
        
        let backBtn = UIButton(type: .Custom)
        backBtn.frame = CGRectMake(20, 7, 30, 30)
        backBtn.setBackgroundImage(UIImage(named: "箭头"), forState: UIControlState.Normal)
        backBtn.addTarget(self, action: Selector("backClicked"), forControlEvents: UIControlEvents.TouchUpInside)
        self.customNavigationBar.addSubview(backBtn)
        self.view.addSubview(self.customNavigationBar)
        
    }
    
    func creatTableView() {
        self.tableView = UITableView(frame: CGRectMake(0, 20, screenWidth, screenHeight-64), style: .Plain)
        self.tableView.tableFooterView = UIView()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = yojpTableViewColor
        self.view.addSubview(self.tableView)
        
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableViewDataArray1.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 48
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        let cell : UITableViewCell = UITableViewCell(style: .Subtitle, reuseIdentifier: "cellId")
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        cell.imageView?.image = UIImage(named: self.tableViewDataArray1[indexPath.row] as! String)
        cell.textLabel?.text = self.tableViewDataArray2[indexPath.row] as? String
        cell.detailTextLabel?.text = "2015.10.01"
        
        cell.textLabel?.font = font14
        cell.textLabel?.textColor = yojpText
        cell.detailTextLabel?.textColor = yojpLightText
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.navigationController?.pushViewController(MessageDetailViewController(), animated: true)
    }
    
    func backClicked() {
        
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
