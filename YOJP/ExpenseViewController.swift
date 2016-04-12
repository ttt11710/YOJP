//
//  ExpenseViewController.swift
//  YOJP
//
//  Created by PayBay on 16/1/12.
//  Copyright © 2016年 PayBay. All rights reserved.
//

import UIKit

class ExpenseViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    
    var customNavigationBar : UIView!
    
    var previousBtn : NTButton!
    var tabBarView : UIView!
    var tabBarScrollView : UIView!
    
    var scrollView : UIScrollView!
    var finishTableView : UITableView!
    var unFinishTableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        self.creatCustomNavigationBar()
        self.creatScrollView()
        self.creatFinishTableView()
        self.creatUnFinishTableView()
        self.creatTabBarView()
        
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
        backBtn.addTarget(self, action: #selector(ExpenseViewController.backClicked), forControlEvents: UIControlEvents.TouchUpInside)
        backBtn.opaque = true
        self.customNavigationBar.addSubview(backBtn)
    
        self.view.addSubview(self.customNavigationBar)
    }
    
    
    func creatTabBarView() {
        
        self.tabBarView = UIView(frame: CGRectMake(0,0,screenWidth,64))
        self.tabBarView.userInteractionEnabled = true
        self.tabBarView.backgroundColor = yojpBlue
        self.view.addSubview(self.tabBarView)
        
        self.tabBarScrollView = UIView(frame: CGRectMake(50,self.tabBarView.frame.size.height-3,self.tabBarView.frame.size.width/2-100,4))
        self.tabBarScrollView.backgroundColor = UIColor.whiteColor()
        self.tabBarView.addSubview(self.tabBarScrollView)
        
        
        self.creatButtonWithNormalName("已完成", SelectName: "未评价高亮", Index: 0)
        self.creatButtonWithNormalName("待取货", SelectName: "已评价高亮", Index: 1)
        
        self.previousBtn = NTButton()
        let button : NTButton = self.tabBarView.subviews[1] as! NTButton
        self.changeViewController(button)
    }
    
    func creatScrollView() {
        self.scrollView = UIScrollView(frame: CGRectMake(0,64,screenWidth,screenHeight-64-44))
        self.scrollView.contentSize = CGSizeMake(screenWidth*2, 0)
        self.scrollView.contentOffset = CGPointMake(0, 0)
        self.scrollView.backgroundColor = yojpTableViewColor
        self.scrollView.pagingEnabled = true
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.delegate = self
        self.scrollView.bounces = false
        self.view.addSubview(self.scrollView)
    }
    
    func creatFinishTableView() {
        self.finishTableView = UITableView(frame: CGRectMake(0, 0, screenWidth, self.scrollView.frame.size.height), style: .Plain)
        self.finishTableView.backgroundColor = yojpTableViewColor
        self.finishTableView.delegate = self
        self.finishTableView.dataSource = self
        self.finishTableView.separatorStyle = .None
        self.scrollView.addSubview(self.finishTableView)
    }
    
    func creatUnFinishTableView() {
        self.unFinishTableView = UITableView(frame: CGRectMake(screenWidth, 0, screenWidth, self.scrollView.frame.size.height), style: .Plain)
        self.unFinishTableView.backgroundColor = yojpTableViewColor
        self.unFinishTableView.delegate = self
        self.unFinishTableView.dataSource = self
        self.unFinishTableView.separatorStyle = .None
        self.scrollView.addSubview(self.unFinishTableView)
    }
    
    
    func creatButtonWithNormalName(normal : String, SelectName : String, Index : Int) {
        
        let customButton = NTButton(type: .Custom)
        customButton.tag = Index
        let buttonW = self.tabBarView.frame.size.width/2
        let buttonH = self.tabBarView.frame.size.height-20
        
        customButton.frame = CGRectMake(buttonW * CGFloat(Index), 20, buttonW, buttonH)
        
        customButton.setBackgroundImage(UIImage(named: "未评价选中选中高亮"), forState: UIControlState.Disabled)
        customButton.setTitle(normal, forState: UIControlState.Normal)
        customButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Disabled)
        customButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        customButton.titleLabel?.font = font18
        customButton.addTarget(self, action: #selector(ExpenseViewController.changeViewController(_:)), forControlEvents: UIControlEvents.TouchDown)
        customButton.imageView?.contentMode = .Center
        self.tabBarView.addSubview(customButton)
        
        let imageView : UIImageView = UIImageView(frame: CGRectMake(self.tabBarView.frame.size.width/2-3, 0, 6, self.tabBarView.frame.size.height-2.5))
        imageView.backgroundColor = UIColor.whiteColor()
        
    }
    
    func changeViewController(sender : NTButton) {
        
        if self.previousBtn != sender {
            
            // self.navigationItem.titleView?.userInteractionEnabled = false
            
            self.previousBtn.enabled = true
            self.previousBtn = sender
            
            
            sender.enabled = false
            
            UIView.animateWithDuration(0.8, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
                
                if sender.tag == 1 {
                    
                    
                    self.scrollView.contentOffset = CGPointMake(screenWidth, 0)
                    
                    self.tabBarScrollView.layer.transform = CATransform3DMakeTranslation(self.tabBarView.frame.size.width/2, 0, 0)
                    
                }
                else {
                    
                    
                    self.scrollView.contentOffset = CGPointMake(0, 0)
                    self.tabBarScrollView.layer.transform = CATransform3DIdentity
                }
                
                }, completion: { (finished : Bool) -> Void in
                    
            })
        }
        else {
            sender.enabled = false
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if tableView == self.finishTableView {
            return 3
        }
        else {
            return 1
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.row == 1 {
            return 150
        }
        return 130
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        if indexPath.row == 0 {
            
            if tableView == self.finishTableView {
                tableView.registerNib(UINib(nibName: "ExpenseTableViewCell", bundle: nil), forCellReuseIdentifier: "ExpenseTableViewCellId")
                let cell = tableView.dequeueReusableCellWithIdentifier("ExpenseTableViewCellId", forIndexPath: indexPath) as! ExpenseTableViewCell
                
                cell.selectionStyle = UITableViewCellSelectionStyle.None
                
                cell.titleLabel.text = "付款时间:2016-01-08 10:59"
                cell.label1.text = "订单金额￥900（1800日元）"
                cell.label2.text = "订单编号:JP300000000000"
                cell.label3.text = "订单状态:已完成"
                cell.barcodeImageView.hidden = true
                return cell
            }
            else {
                tableView.registerNib(UINib(nibName: "OrderExpenseUnFinishTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderExpenseUnFinishTableViewCellId")
                let cell = tableView.dequeueReusableCellWithIdentifier("OrderExpenseUnFinishTableViewCellId", forIndexPath: indexPath) as! OrderExpenseUnFinishTableViewCell
                
                cell.selectionStyle = UITableViewCellSelectionStyle.None
                
                cell.titleLabel.text = "取货地址：某某街某某路某某号 东京店"
                cell.label1.text = "订单金额￥900（1800日元）"
                cell.label2.text = "订单号码:JP300000000000"
                cell.label3.text = "付款时间:2016-01-18 10：26"
                return cell
            }
        }
        else if indexPath.row == 1 {
            tableView.registerNib(UINib(nibName: "OrderExpenseFinishTableViewCell", bundle: nil), forCellReuseIdentifier: "OrderExpenseFinishTableViewCellId")
            let cell = tableView.dequeueReusableCellWithIdentifier("OrderExpenseFinishTableViewCellId", forIndexPath: indexPath) as! OrderExpenseFinishTableViewCell
            
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            cell.titleLabel.text = "取货地址：某某街某某路某某号 东京店"
            cell.label1.text = "订单金额￥900（1800日元）"
            cell.label2.text = "订单号码:JP300000000000"
            cell.label3.text = "付款时间:2016-01-18 10：26"
            cell.label4.text = "取货时间:2016-01-18 10：26"
            return cell
        }
        else {
            tableView.registerNib(UINib(nibName: "ExpenseTableViewCell", bundle: nil), forCellReuseIdentifier: "ExpenseTableViewCellId")
            let cell = tableView.dequeueReusableCellWithIdentifier("ExpenseTableViewCellId", forIndexPath: indexPath) as! ExpenseTableViewCell
            
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.titleLabel.text = "消费时间:2016-01-08  10:59"
            cell.label1.text = "订单编号:JP300000000000"
            cell.label2.text = "订单类型：100云抵扣券"
            cell.label3.text = "订单状态:已完成"
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.row == 0 {
            if tableView == self.finishTableView {
                self.navigationController?.pushViewController(OrderExpenseViewController(), animated: true)
            }
            else {
                self.navigationController?.pushViewController(OrderExpenseUnFinishViewController(), animated: true)
            }
            
        }
        else if indexPath.row == 1 {
            self.navigationController?.pushViewController(OrderExpenseFinishViewController(), animated: true)
        }
        else {
            self.navigationController?.pushViewController(CardExpenseViewController(), animated: true)
        }
        
    }

    func backClicked() {
        self.navigationController?.popViewControllerAnimated(true)
    }

    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        if scrollView == self.scrollView {
            let page = Int(scrollView.contentOffset.x / screenWidth)
            let button : NTButton = self.tabBarView.subviews[page+1] as! NTButton
            self.changeViewController(button)
        }
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
