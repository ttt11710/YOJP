//
//  PaySuccessViewController.swift
//  YOJP
//
//  Created by PayBay on 16/1/4.
//  Copyright © 2016年 PayBay. All rights reserved.
//

import UIKit

class PaySuccessViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var customNavigationBar : UIView!
    
    var tableView : UITableView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        
        self.creatTableView()
        self.creatCustomNavigationBar()

        
        // Do any additional setup after loading the view.
    }

//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(animated)
//        
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

    
    func creatTableView() {
        self.tableView = UITableView(frame: CGRectMake(0, 0, screenWidth, screenHeight-44+8), style: .Plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = yojpTableViewColor
        self.view.addSubview(self.tableView)
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
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 100
    }
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            for view in cell.subviews {
                
                view.removeFromSuperview()
            }
            
            let payTypeLabel : UILabel = UILabel()
            payTypeLabel.text = "支付成功"
            payTypeLabel.textColor = yojpText
            payTypeLabel.font = font15
            payTypeLabel.textAlignment = .Center
            payTypeLabel.center = CGPointMake(screenWidth/2, 35)
            payTypeLabel.bounds = CGRectMake(0, 0, 200, 25)
            payTypeLabel.opaque = true
            cell.addSubview(payTypeLabel)
            
            return cell

        }
        else if indexPath.section == 1 {
            tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            for view in cell.subviews {
                
                view.removeFromSuperview()
            }
            
            let payCountLabel : UILabel = UILabel()
            payCountLabel.text = "消费金额"
            payCountLabel.textColor = yojpText
            payCountLabel.font = font15
            payCountLabel.textAlignment = .Center
            payCountLabel.center = CGPointMake(screenWidth/2, 35)
            payCountLabel.bounds = CGRectMake(0, 0, 200, 25)
            payCountLabel.opaque = true
            cell.addSubview(payCountLabel)
            
            let payLabel : UILabel = UILabel()
            payLabel.text = "￥30"
            payLabel.textColor = yojpText
            payLabel.font = UIFont.boldSystemFontOfSize(28)
            payLabel.textAlignment = .Center
            payLabel.center = CGPointMake(screenWidth/2, 65)
            payLabel.bounds = CGRectMake(0, 0, 200, 40)
            payLabel.opaque = true
            cell.addSubview(payLabel)
            
            return cell

        }
        else if indexPath.section == 2 {
            tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            cell.backgroundColor = UIColor(white: 246.0/255.0, alpha: 1)
            
            for view in cell.subviews {
                
                view.removeFromSuperview()
            }
            let orderNumLabel : UILabel = UILabel(frame: CGRectMake(16,8,screenWidth,20))
            orderNumLabel.text = "订单号码：JP2000000000000"
            orderNumLabel.textColor = yojpText
            orderNumLabel.font = font14
            orderNumLabel.opaque = true
            cell.addSubview(orderNumLabel)
            
            let payTimeLabel : UILabel = UILabel(frame: CGRectMake(16,orderNumLabel.frame.origin.y+orderNumLabel.frame.size.height + 8,300,20))
            payTimeLabel.text = "2015.12.28 11:29"
            payTimeLabel.textColor = yojpText
            payTimeLabel.font = font14
            payTimeLabel.opaque = true
            cell.addSubview(payTimeLabel)
            
            let addressLabel : UILabel = UILabel(frame: CGRectMake(16,payTimeLabel.frame.origin.y+payTimeLabel.frame.size.height + 8,300,20))
            addressLabel.text = "商家地址：某某街某某路某某号 东京店"
            addressLabel.textColor = yojpText
            addressLabel.font = font14
            addressLabel.opaque = true
            cell.addSubview(addressLabel)
            
            return cell

        }
        else  {
            tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            cell.backgroundColor = yojpTableViewColor
            tableView.separatorStyle = .None
            
            let sureBtn : CallBackButton = CallBackButton(type: .Custom)
            sureBtn.setupBlock()
            sureBtn.setTitle("确定", forState: .Normal)
            sureBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            sureBtn.backgroundColor = yojpBlue
            sureBtn.bounds = CGRectMake(0, 0, screenWidth-32, 44)
            sureBtn.center = CGPointMake(screenWidth/2, 80)
            sureBtn.layer.cornerRadius = 4
            sureBtn.titleLabel!.opaque = true
            cell.addSubview(sureBtn)
            
            sureBtn.callBack = { tag in
                
                self.navigationController?.popToViewController(self.navigationController!.viewControllers[1], animated: true)
                
            }
            
            return cell

        }
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
