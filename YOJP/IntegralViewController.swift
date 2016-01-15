//
//  IntegralViewController.swift
//  YOJP
//
//  Created by PayBay on 15/12/8.
//  Copyright © 2015年 PayBay. All rights reserved.
//

import UIKit

class IntegralViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    var customNavigationBar : UIView!
    var tableView : UITableView!
    
    let dataArray1 : NSMutableArray = ["分享有礼获得积分","订单消费:5236987452"]
    let dataArray2 : NSMutableArray = ["2015.11.27 09:38","2015.12.08 13:30"]
    
    
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
        self.tableView = UITableView(frame: CGRectMake(0, 20, screenWidth, screenHeight-44-20))
        self.tableView.backgroundColor = yojpTableViewColor
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorStyle = .None
        self.view.addSubview(self.tableView)
        
    }

    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 30
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view : UIView = UIView(frame: CGRectMake(0, 0, screenWidth, 30))
        view.backgroundColor = UIColor(red: 250.0/255.0, green: 250.0/255.0, blue: 250.0/255.0, alpha: 1)
        
        let titleLabel : UILabel = UILabel(frame: CGRectMake(16,4,200,22))
        titleLabel.text = "积分变动明细:"
        titleLabel.textColor = yojpText
        titleLabel.font = font15
        titleLabel.opaque = true
        view.addSubview(titleLabel)
    
        return view
    }
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view : UIView = UIView(frame: CGRectMake(0, 0, screenWidth, 8))
        view.backgroundColor = yojpTableViewColor
        return view
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return section == 0 ? 1:self.dataArray1.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.section
        {
        case 0:
            tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
            
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.backgroundColor = yojpTableViewColor
            
            let countLabel : UILabel = UILabel(frame: CGRectMake(20,8,100,25))
            countLabel.text = "我的积分"
            countLabel.textColor = yojpText
            countLabel.font = font15
            countLabel.opaque = true
            cell.contentView.addSubview(countLabel)
            
            let integralLabel : UILabel = UILabel(frame: CGRectMake(20,70,100,30))
            integralLabel.text = "36"
            integralLabel.textColor = yojpText
            integralLabel.font = UIFont.systemFontOfSize(30)
            integralLabel.opaque = true
            cell.contentView.addSubview(integralLabel)
            
            return cell
        default :
            tableView.registerNib(UINib(nibName: "IntegralTableViewCell", bundle: nil), forCellReuseIdentifier: "IntegralTableViewCellId")
            let cell = tableView.dequeueReusableCellWithIdentifier("IntegralTableViewCellId", forIndexPath: indexPath) as! IntegralTableViewCell
            
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            cell.leftLabel.text = self.dataArray1[indexPath.row] as? String
            cell.leftSubLabel.text = self.dataArray2[indexPath.row] as? String
            
            cell.rightLabel.text = "+10积分"
            
            cell.leftLabel.opaque = true
            cell.leftSubLabel.opaque = true
            cell.rightLabel.opaque = true
            
            return cell
            
        }
        
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return indexPath.section == 0 ? 120 : 68
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
