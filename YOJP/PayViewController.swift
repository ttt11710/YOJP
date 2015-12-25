//
//  PayViewController.swift
//  YOJP
//
//  Created by PayBay on 15/12/24.
//  Copyright © 2015年 PayBay. All rights reserved.
//

import UIKit

class PayViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,popPayDelegate {

    
    var customNavigationBar : UIView!
    
    var tableView : UITableView!
    
    var payTypeArray : NSMutableArray = [["payTypeLogo":"支付宝支付","payTypeName":"支付宝支付","payRuleLabel":"推荐安装支付宝的用户使用"],["payTypeLogo":"weixinpay","payTypeName":"微信支付","payRuleLabel":"推荐安装微信5.0及以上版本的使用"],["payTypeLogo":"yinhangpay","payTypeName":"银行卡支付","payRuleLabel":"支持储蓄卡信用卡，无需开通网银"]]
    
    var payView : UIView!
    
    var popPayView: popPayPwdView?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.creatTableView()
        self.creatCustomNavigationBar()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.navigationBarHidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBarHidden = false
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
        self.customNavigationBar.addSubview(backBtn)
        
        self.view.addSubview(self.customNavigationBar)
    }
    
    
    func creatPayView() {
        
        self.payView = UIView(frame: CGRectMake(0,screenHeight,screenWidth,screenHeight/2))
        self.payView.backgroundColor = yojpTableViewColor
        self.view.addSubview(self.payView)
        
        let backBtn = UIButton(type: .Custom)
        backBtn.frame = CGRectMake(20, 7, 30, 30)
        backBtn.setBackgroundImage(UIImage(named: "箭头"), forState: UIControlState.Normal)
        backBtn.addTarget(self, action: Selector("backClicked"), forControlEvents: UIControlEvents.TouchUpInside)
        self.payView.addSubview(backBtn)
        
        let countLabel : UILabel = UILabel()
        countLabel.text = "请输入支付密码"
        countLabel.textAlignment = .Center
        countLabel.textColor = yojpText
        countLabel.center = CGPointMake(screenWidth/2, 20)
        countLabel.bounds = CGRectMake(0, 0, 200, 30)
        countLabel.font = font17
        self.payView.addSubview(countLabel)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 8
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 {
            return 100
        }
        else if indexPath.row == 1 {
            return 68
        }
        else if indexPath.row == 2 {
            return 78
        }
        else if indexPath.row == 3 {
            return 25
        }
        else if indexPath.row <= 6 && indexPath.row >= 4 {
            return 44
        }
        else {
            return 200
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cellId")
            let cell = tableView.dequeueReusableCellWithIdentifier("cellId", forIndexPath: indexPath) as UITableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            let payCountLabel : UILabel = UILabel()
            payCountLabel.text = "支付金额"
            payCountLabel.textColor = yojpText
            payCountLabel.font = font15
            payCountLabel.textAlignment = .Center
            payCountLabel.center = CGPointMake(screenWidth/2, 35)
            payCountLabel.bounds = CGRectMake(0, 0, 200, 25)
            cell.addSubview(payCountLabel)
            
            let payLabel : UILabel = UILabel()
            payLabel.text = "￥1002"
            payLabel.textColor = yojpText
            payLabel.font = UIFont.boldSystemFontOfSize(28)
            payLabel.textAlignment = .Center
            payLabel.center = CGPointMake(screenWidth/2, 65)
            payLabel.bounds = CGRectMake(0, 0, 200, 40)
            cell.addSubview(payLabel)
            
            return cell
        }
        else if indexPath.row == 1 {
            
            tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cellId")
            let cell = tableView.dequeueReusableCellWithIdentifier("cellId", forIndexPath: indexPath) as UITableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            cell.backgroundColor = UIColor(white: 246.0/255.0, alpha: 1)
            
            let orderNumLabel : UILabel = UILabel(frame: CGRectMake(16,8,screenWidth,20))
            orderNumLabel.text = "订单号码：JP2000000000000"
            orderNumLabel.textColor = yojpText
            orderNumLabel.font = font14
            cell.addSubview(orderNumLabel)
            
            let addressLabel : UILabel = UILabel(frame: CGRectMake(16,orderNumLabel.frame.origin.y+orderNumLabel.frame.size.height + 8,300,20))
            addressLabel.text = "取货地址：某某街某某路某某号 东京店"
            addressLabel.textColor = yojpText
            addressLabel.font = font14
            cell.addSubview(addressLabel)
            
            return cell
        }
        else if indexPath.row == 2 {
            tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cellId")
            let cell = tableView.dequeueReusableCellWithIdentifier("cellId", forIndexPath: indexPath) as UITableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            cell.backgroundColor = yojpTableViewColor
            
            let tipLabel : UILabel = UILabel(frame: CGRectMake(16,10,100,20))
            tipLabel.text = "温馨提示:"
            tipLabel.font = font14
            tipLabel.textColor = yojpText
            cell.addSubview(tipLabel)
            
            let tipSubLabel : UILabel = UILabel(frame: CGRectMake(16,tipLabel.frame.origin.y+tipLabel.frame.size.height,screenWidth-16,100))
            tipSubLabel.text = "订单支付后，1小时内请到指定商家取货，否则订单失效，支付金额将会退回至您的账户。"
            tipSubLabel.textColor = yojpText
            tipSubLabel.font = font13
            tipSubLabel.numberOfLines = 0
            tipSubLabel.sizeToFit()
            cell.addSubview(tipSubLabel)
            
            return cell
        }
        else if indexPath.row == 3 {
            tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cellId")
            let cell = tableView.dequeueReusableCellWithIdentifier("cellId", forIndexPath: indexPath) as UITableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.backgroundColor = yojpTableViewColor
            
            let payTypeLabel : UILabel = UILabel(frame: CGRectMake(16,2,screenWidth,20))
            payTypeLabel.text = "支付方式:"
            payTypeLabel.textColor = yojpText
            payTypeLabel.font = font15
            cell.addSubview(payTypeLabel)
            
            return cell
        }
        else if indexPath.row >= 4 && indexPath.row <= 6 {
            tableView.registerNib(UINib(nibName: "OrderChoosePayTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderChoosePayTableViewCellId")
            let cell = tableView.dequeueReusableCellWithIdentifier("OrderChoosePayTableViewCellId", forIndexPath: indexPath) as! OrderChoosePayTableViewCell
            
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            let i : Int = indexPath.row - 4
            cell.payTypeLogo.image = UIImage(named: self.payTypeArray.objectAtIndex(i)["payTypeLogo"] as! String)
            cell.payTypeName.text = self.payTypeArray.objectAtIndex(i)["payTypeName"] as? String
            cell.payRuleLabel.text = self.payTypeArray.objectAtIndex(i)["payRuleLabel"] as? String
            if i != 0 {
                cell.payTypeChooseBtn.setImage(UIImage(named: "payUncheck"), forState: UIControlState.Normal)
            }

            return cell
        }
        else {
            tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cellId")
            let cell = tableView.dequeueReusableCellWithIdentifier("cellId", forIndexPath: indexPath) as UITableViewCell
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
            cell.addSubview(sureBtn)
            
            sureBtn.callBack = { tag in
                
                self.popPayView = popPayPwdView()
                self.popPayView!.delegate = self
                self.popPayView!.pop()

            }
            
            return cell
        }
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        for indexPath in self.tableView.indexPathsForVisibleRows! {
            if indexPath.row >= 4 && indexPath.row <=  6 {
                let cell : OrderChoosePayTableViewCell = self.tableView.cellForRowAtIndexPath(indexPath) as! OrderChoosePayTableViewCell
                cell.payTypeChooseBtn.setImage(UIImage(named: "payUncheck"), forState: UIControlState.Normal)
            }
        }
        
        if indexPath.row >= 4 && indexPath.row <=  6 {
            let cell : OrderChoosePayTableViewCell = self.tableView.cellForRowAtIndexPath(indexPath) as! OrderChoosePayTableViewCell
            
            if cell.payTypeChooseBtn.currentImage!.isEqual(UIImage(named: "payUncheck")) {
                cell.payTypeChooseBtn.setImage(UIImage(named: "paycheck"), forState: UIControlState.Normal)
            }
            else {
                cell.payTypeChooseBtn.setImage(UIImage(named: "payUncheck"), forState: UIControlState.Normal)
            }
            
        }
    }

    
    func compareCode(payCode: String) {
       
        print(payCode)
        
        let nav : UINavigationController = self.navigationController!
        
        self.navigationController?.popViewControllerAnimated(false)
        nav.pushViewController(ShopPayViewController(), animated: true)
        
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