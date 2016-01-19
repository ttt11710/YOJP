//
//  ShopOrderViewController.swift
//  YOJP
//
//  Created by PayBay on 16/1/19.
//  Copyright © 2016年 PayBay. All rights reserved.
//

import UIKit

class ShopOrderViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
    var customNavigationBar : UIView!
    
    var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        self.creatTableView()
        self.creatCustomNavigationBar()
        
        // Do any additional setup after loading the view.
    }
    
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
        self.tableView = UITableView(frame: CGRectMake(0, 0, screenWidth, screenHeight-44), style: .Plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = yojpTableViewColor
        self.tableView.tableFooterView = UIView()
        self.tableView.separatorStyle = .None
        self.view.addSubview(self.tableView)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 11
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 || indexPath.row == 10 {
            return 150
        }
        else if indexPath.row == 7 {
            return 70
        }
        else if indexPath.row == 8 || indexPath.row == 9 {
            return 60
        }
        else {
            return 44
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            let storeName : UILabel = UILabel()
            storeName.center = CGPointMake(screenWidth/2, 30)
            storeName.bounds = CGRectMake(0, 0, 200, 30)
            storeName.text = "商家名称"
            storeName.textColor = yojpText
            storeName.font = font20
            storeName.textAlignment = .Center
            storeName.opaque = true
            cell.addSubview(storeName)
            
            let contentLabel : UILabel = UILabel(frame: CGRectMake(32,70,screenWidth-32,30))
            contentLabel.text = "订单编号：JP2000000000000\n付款时间：2016-01-08  10:59\n商家地址：某某街某某路某某号 东京店"
            contentLabel.numberOfLines = 3
            contentLabel.textColor = yojpText
            contentLabel.font = font14
            contentLabel.sizeToFit()
            contentLabel.opaque = true
            cell.addSubview(contentLabel)
            
            return cell
        }
        else if indexPath.row == 1 {
            tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            
            let lineImageView1 = UIImageView(frame: CGRectMake(0, 0, screenWidth-32, 1))
            lineImageView1.image = UIImage(named: "dashedLine")
            cell.addSubview(lineImageView1)
            
            let label1 : UILabel = UILabel(frame: CGRectMake(0,10,screenWidth/4,25))
            label1.text = "编码/品名"
            label1.textAlignment = .Center
            label1.textColor = yojpText
            label1.font = font15
            label1.opaque = true
            cell.addSubview(label1)
            
            let label2 : UILabel = UILabel(frame: CGRectMake(screenWidth/4,10,screenWidth/4,25))
            label2.text = "数量"
            label2.textAlignment = .Center
            label2.textColor = yojpText
            label2.font = font15
            label2.opaque = true
            cell.addSubview(label2)
            
            let label3 : UILabel = UILabel(frame: CGRectMake(screenWidth/2,10,screenWidth/4,25))
            label3.text = "单价"
            label3.textAlignment = .Center
            label3.textColor = yojpText
            label3.font = font15
            label3.opaque = true
            cell.addSubview(label3)
            
            let label4 : UILabel = UILabel(frame: CGRectMake(screenWidth/4*3,10,screenWidth/4,25))
            label4.text = "金额"
            label4.textAlignment = .Center
            label4.textColor = yojpText
            label4.font = font15
            label4.opaque = true
            cell.addSubview(label4)
            
            let lineImageView2 = UIImageView(frame: CGRectMake(0, 43, screenWidth-32, 1))
            lineImageView2.image = UIImage(named: "dashedLine")
            lineImageView2.opaque = true
            cell.addSubview(lineImageView2)
            
            return cell
        }
        else if indexPath.row >= 2  && indexPath.row <= 6 {
            tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            let label1 : UILabel = UILabel(frame: CGRectMake(0,10,screenWidth/4,25))
            label1.text = "某某某某"
            label1.textAlignment = .Center
            label1.textColor = yojpText
            label1.font = font15
            label1.opaque = true
            cell.addSubview(label1)
            
            let label2 : UILabel = UILabel(frame: CGRectMake(screenWidth/4,10,screenWidth/4,25))
            label2.text = "1"
            label2.textAlignment = .Center
            label2.textColor = yojpText
            label2.font = font15
            label2.opaque = true
            cell.addSubview(label2)
            
            let label3 : UILabel = UILabel(frame: CGRectMake(screenWidth/2,10,screenWidth/4,25))
            label3.text = "单价"
            label3.textAlignment = .Center
            label3.textColor = yojpText
            label3.font = font15
            label3.opaque = true
            cell.addSubview(label3)
            
            let label4 : UILabel = UILabel(frame: CGRectMake(screenWidth/4*3,10,screenWidth/4,25))
            label4.text = "金额"
            label4.textAlignment = .Center
            label4.textColor = yojpText
            label4.font = font15
            label4.opaque = true
            cell.addSubview(label4)
            
            if indexPath.row == 6 {
                let lineImageView = UIImageView(frame: CGRectMake(0, 43, screenWidth-32, 1))
                lineImageView.image = UIImage(named: "dashedLine")
                lineImageView.opaque = true
                cell.addSubview(lineImageView)
            }
            return cell
        }
        else if indexPath.row == 7 {
            
            tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            cell.textLabel?.text = "订单金额:￥900(1800日元)"
            cell.textLabel?.textColor = yojpText
            cell.textLabel?.font = font16
            cell.textLabel?.opaque = true
            
            let tipLabel : UILabel = UILabel(frame: CGRectMake(screenWidth-250,45,234,25))
            tipLabel.text = "(在线支付参考金额)"
            tipLabel.textColor = yojpText
            tipLabel.font = font14
            tipLabel.textAlignment = .Right
            cell.addSubview(tipLabel)
            
            return cell
        }
        else if indexPath.row == 8 {
            tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.backgroundColor = yojpLightCell
            
            let creditCardLabel : UILabel = UILabel(frame: CGRectMake(32,5,screenWidth-32,25))
            creditCardLabel.text = "信用卡支付参考金额：¥950（1800日元）"
            creditCardLabel.textColor = yojpText
            creditCardLabel.font = font14
            creditCardLabel.opaque = true
            cell.addSubview(creditCardLabel)
            
            let depositCardLabel : UILabel = UILabel(frame: CGRectMake(32,30,screenWidth-32,25))
            depositCardLabel.text = "储蓄卡支付参考金额：¥940（1800日元）"
            depositCardLabel.textColor = yojpText
            depositCardLabel.font = font14
            depositCardLabel.opaque = true
            cell.addSubview(depositCardLabel)
            
            return cell
        }
        else if indexPath.row == 9 {
            tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.backgroundColor = UIColor.whiteColor()
            
            let creditCardLabel : UILabel = UILabel(frame: CGRectMake(16,5,234,25))
            creditCardLabel.text = "温馨提示:"
            creditCardLabel.textColor = yojpText
            creditCardLabel.font = font14
            creditCardLabel.opaque = true
            cell.addSubview(creditCardLabel)
            
            let depositCardLabel : UILabel = UILabel(frame: CGRectMake(16,30,screenWidth-32,25))
            depositCardLabel.text = "请记得到指定 “商家地址” 领取您的商品哦!"
            depositCardLabel.textColor = yojpText
            depositCardLabel.font = font14
            depositCardLabel.opaque = true
            cell.addSubview(depositCardLabel)
            
            return cell
        }

        else {
            tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.backgroundColor = yojpLightCell
            
            let sureBtn : CallBackButton = CallBackButton(frame: CGRectMake(16,30,screenWidth-32,44))
            sureBtn.setTitle("确定", forState: .Normal)
            sureBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            sureBtn.backgroundColor = yojpBlue
            sureBtn.layer.cornerRadius = 4
            sureBtn.titleLabel?.opaque = true
            sureBtn.setupBlock()
            sureBtn.callBack = { tag in
                
                self.navigationController?.pushViewController(ShopOrderPayViewController(), animated: true)
            }
            cell.addSubview(sureBtn)
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
