//
//  UserHistoryViewController.swift
//  YOJP
//
//  Created by PayBay on 16/1/5.
//  Copyright © 2016年 PayBay. All rights reserved.
//

import UIKit

class UserHistoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    var tableViewDataArray1 : NSMutableArray = ["免费券","八五折-打折券","100元-抵扣券","888元-福袋","九折-打折券","500元-抵扣券","免费券","八五折-打折券","100元-抵扣券","888元-福袋","九折-打折券","500元-抵扣券"]
    
    var customNavigationBar : UIView!
    var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
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
        backBtn.opaque = true
        self.customNavigationBar.addSubview(backBtn)
        self.view.addSubview(self.customNavigationBar)
        
    }

    
    func creatTableView() {
        self.tableView = UITableView(frame: CGRectMake(0, 20, screenWidth, screenHeight-20-44), style: .Plain)
        self.tableView.backgroundColor = yojpTableViewColor
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .None
        self.view.addSubview(self.tableView)
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 5
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 90
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row < 3 {
            
            tableView.registerNib(UINib(nibName: "CardListTableViewCell", bundle: nil), forCellReuseIdentifier: "CardListTableViewCellId")
            let cell = tableView.dequeueReusableCellWithIdentifier("CardListTableViewCellId", forIndexPath: indexPath) as! CardListTableViewCell
            
            cell.selectionStyle = .None
            cell.backgroundColor = yojpTableViewColor
            
            cell.barcodeImagwView.image = UIImage(named: "2DBarcode")
            cell.ticketTypeLabel.text = self.tableViewDataArray1[indexPath.row] as? String
            cell.validityLabel.text = "2015.11.21 13:23"
            
            return cell
        }
        else {
            tableView.registerNib(UINib(nibName: "CardListTableViewWithOnlyMoneyCell", bundle: nil), forCellReuseIdentifier: "CardListTableViewWithOnlyMoneyCellId")
            let cell = tableView.dequeueReusableCellWithIdentifier("CardListTableViewWithOnlyMoneyCellId", forIndexPath: indexPath) as! CardListTableViewWithOnlyMoneyCell
            
            cell.selectionStyle = .None
            cell.backgroundColor = yojpTableViewColor
            
            cell.payMoneyLabel.text = "消费金额 ￥888"
            cell.userTimeLabel.text = "2015.12.27 11:20"
            
             return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
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
