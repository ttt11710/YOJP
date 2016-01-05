//
//  OrderViewController.swift
//  YOJP
//
//  Created by PayBay on 15/12/18.
//  Copyright © 2015年 PayBay. All rights reserved.
//

import UIKit

class OrderViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    var customNavigationBar : UIView!
    
    var tableView : UITableView!
    
    var tableViewArray : NSMutableArray = [
        ["支付金额":"1000","订单号码":"JP20000000000","取货地址":"某某街某某路某某号 南路店"],
        ["支付金额":"7000","订单号码":"JP30000000000","取货地址":"某某街某某路某某号 南路店"],
        ["支付金额":"5000","订单号码":"JP50000000000","取货地址":"某某街某某路某某号 南路店"],
        ["支付金额":"6000","订单号码":"JP40000000000","取货地址":"某某街某某路某某号 南路店"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = yojpTableViewColor
        
        
        self.creatCustomNavigationBar()
        self.creatTableView()

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
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .None
        self.tableView.backgroundColor = yojpTableViewColor
        self.view.addSubview(self.tableView)
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.tableViewArray.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 120
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let view : UIView = UIView(frame: CGRectMake(0,0,screenWidth,8))
        view.backgroundColor = yojpTableViewColor
        return view
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        tableView.registerNib(UINib(nibName: "OrderTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderTableViewCellId")
        let cell = tableView.dequeueReusableCellWithIdentifier("OrderTableViewCellId", forIndexPath: indexPath) as! OrderTableViewCell
        
        cell.selectionStyle = .None
        cell.backgroundColor = UIColor.whiteColor()
        
        cell.payMoneyLabel.text = String(format: "支付金额￥%@", self.tableViewArray[indexPath.section]["支付金额"] as! String)
        cell.orderNumberLabel.text =  String(format: "订单号码:￥%@", self.tableViewArray[indexPath.section]["订单号码"] as! String)
        cell.addressLabel.text = String(format: "取货地址:%@", self.tableViewArray[indexPath.section]["取货地址"] as! String)
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.navigationController?.pushViewController(OrderDetailViewController(), animated: true)
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
