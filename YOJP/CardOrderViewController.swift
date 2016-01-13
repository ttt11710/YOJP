//
//  CardOrderViewController.swift
//  YOJP
//
//  Created by PayBay on 16/1/13.
//  Copyright © 2016年 PayBay. All rights reserved.
//

import UIKit

class CardOrderViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    
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
        return 10
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 0 || indexPath.row == 9 {
            return 150
        }
        else {
            return 44
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cellId")
            let cell = tableView.dequeueReusableCellWithIdentifier("cellId", forIndexPath: indexPath) as UITableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            let storeName : UILabel = UILabel()
            storeName.center = CGPointMake(screenWidth/2, 30)
            storeName.bounds = CGRectMake(0, 0, 200, 30)
            storeName.text = "商家名称"
            storeName.textColor = yojpText
            storeName.font = font20
            storeName.textAlignment = .Center
            cell.addSubview(storeName)
            
            let contentLabel : UILabel = UILabel(frame: CGRectMake(16,70,screenWidth-32,30))
            contentLabel.text = "单据类型：零售出库单\n订单编号：JP2000000000000\n打印时间：2016-01-08  10:59\n收银人员：员工3"
            contentLabel.numberOfLines = 4
            contentLabel.textColor = yojpText
            contentLabel.font = font14
            contentLabel.sizeToFit()
            cell.addSubview(contentLabel)
            
            return cell
        }
        else if indexPath.row == 1 {
            tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cellId")
            let cell = tableView.dequeueReusableCellWithIdentifier("cellId", forIndexPath: indexPath) as UITableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            
            let lineImageView1 = UIImageView(frame: CGRectMake(0, 0, screenWidth-32, 1))
            lineImageView1.image = UIImage(named: "dashedLine")
            cell.addSubview(lineImageView1)
            
            let label1 : UILabel = UILabel(frame: CGRectMake(0,10,screenWidth/4,25))
            label1.text = "编码/品名"
            label1.textAlignment = .Center
            label1.textColor = yojpText
            label1.font = font15
            cell.addSubview(label1)
            
            let label2 : UILabel = UILabel(frame: CGRectMake(screenWidth/4,10,screenWidth/4,25))
            label2.text = "数量"
            label2.textAlignment = .Center
            label2.textColor = yojpText
            label2.font = font15
            cell.addSubview(label2)
            
            let label3 : UILabel = UILabel(frame: CGRectMake(screenWidth/2,10,screenWidth/4,25))
            label3.text = "单价"
            label3.textAlignment = .Center
            label3.textColor = yojpText
            label3.font = font15
            cell.addSubview(label3)
            
            let label4 : UILabel = UILabel(frame: CGRectMake(screenWidth/4*3,10,screenWidth/4,25))
            label4.text = "金额"
            label4.textAlignment = .Center
            label4.textColor = yojpText
            label4.font = font15
            cell.addSubview(label4)
            
            let lineImageView2 = UIImageView(frame: CGRectMake(0, 43, screenWidth-32, 1))
            lineImageView2.image = UIImage(named: "dashedLine")
            cell.addSubview(lineImageView2)
            
            return cell
        }
        else if indexPath.row >= 2  && indexPath.row <= 6 {
            tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cellId")
            let cell = tableView.dequeueReusableCellWithIdentifier("cellId", forIndexPath: indexPath) as UITableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            let label1 : UILabel = UILabel(frame: CGRectMake(0,10,screenWidth/4,25))
            label1.text = "某某某某"
            label1.textAlignment = .Center
            label1.textColor = yojpText
            label1.font = font15
            cell.addSubview(label1)
            
            let label2 : UILabel = UILabel(frame: CGRectMake(screenWidth/4,10,screenWidth/4,25))
            label2.text = "1"
            label2.textAlignment = .Center
            label2.textColor = yojpText
            label2.font = font15
            cell.addSubview(label2)
            
            let label3 : UILabel = UILabel(frame: CGRectMake(screenWidth/2,10,screenWidth/4,25))
            label3.text = "单价"
            label3.textAlignment = .Center
            label3.textColor = yojpText
            label3.font = font15
            cell.addSubview(label3)
            
            let label4 : UILabel = UILabel(frame: CGRectMake(screenWidth/4*3,10,screenWidth/4,25))
            label4.text = "金额"
            label4.textAlignment = .Center
            label4.textColor = yojpText
            label4.font = font15
            cell.addSubview(label4)
            
            if indexPath.row == 6 {
                let lineImageView = UIImageView(frame: CGRectMake(0, 43, screenWidth-32, 1))
                lineImageView.image = UIImage(named: "dashedLine")
                cell.addSubview(lineImageView)
            }
            return cell
        }
        else if indexPath.row == 7 {
            
            tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cellId")
            let cell = tableView.dequeueReusableCellWithIdentifier("cellId", forIndexPath: indexPath) as UITableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            cell.textLabel?.text = "合计:9999日元"
            cell.textLabel?.textColor = yojpText
            cell.textLabel?.font = font16
            return cell
        }
        else if indexPath.row == 8 {
            tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cellId")
            let cell = tableView.dequeueReusableCellWithIdentifier("cellId", forIndexPath: indexPath) as UITableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.backgroundColor = yojpLightCell
            
            cell.textLabel?.text = "商家地址：某某街某某路某某号 东京店"
            cell.textLabel?.textColor = yojpText
            cell.textLabel?.font = font15
            return cell
        }
        else {
            tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cellId")
            let cell = tableView.dequeueReusableCellWithIdentifier("cellId", forIndexPath: indexPath) as UITableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.backgroundColor = yojpLightCell
            
            let sureBtn : CallBackButton = CallBackButton(frame: CGRectMake(16,20,screenWidth-32,44))
            sureBtn.setTitle("确定", forState: .Normal)
            sureBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            sureBtn.backgroundColor = yojpBlue
            sureBtn.layer.cornerRadius = 4
            sureBtn.setupBlock()
            sureBtn.callBack = { tag in
                
                self.navigationController?.pushViewController(CardScanPayViewController(), animated: true)
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
