//
//  FreeDetailViewController.swift
//  YOJP
//
//  Created by PayBay on 16/1/4.
//  Copyright © 2016年 PayBay. All rights reserved.
//

import UIKit
import MapKit

class FreeDetailViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,CLLocationManagerDelegate,MKMapViewDelegate {
    
    
    var ticketType : String!
    var customNavigationBar : UIView!
    
    var tableView : UITableView!
    
    var collectionBtn : MCFireworksButton!
    var collectionSelect : Bool = false
    
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
//        UIApplication.sharedApplication().statusBarStyle = .Default
//        self.navigationController?.navigationBarHidden = true
//    }
//    
//    override func viewWillDisappear(animated: Bool) {
//        super.viewWillDisappear(animated)
//        
//        
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
        
        
        self.collectionBtn = MCFireworksButton(frame: CGRectMake(screenWidth-100, 7, 25, 25))
        self.collectionBtn.particleImage = UIImage(named: "spark")
        self.collectionBtn.particleScale = 0.05
        self.collectionBtn.particleScaleRange = 0.02
        
        self.collectionBtn.setImage(UIImage(named: "collectionWhite"), forState: .Normal)
        self.collectionBtn.setImage(UIImage(named: "collectionWhite"), forState: .Highlighted)
        
        self.collectionBtn.addTarget(self, action: Selector("collectionClicked:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.customNavigationBar.addSubview(self.collectionBtn)
        
        
        let shareBtn = UIButton(type: .Custom)
        shareBtn.frame = CGRectMake(screenWidth-55, 7, 25, 25)
        shareBtn.setBackgroundImage(UIImage(named: "share"), forState: UIControlState.Normal)
        shareBtn.addTarget(self, action: Selector("shareClicked"), forControlEvents: UIControlEvents.TouchUpInside)
        self.customNavigationBar.addSubview(shareBtn)
        self.view.addSubview(self.customNavigationBar)
    }
    
    
    func creatTableView() {
        self.tableView = UITableView(frame: CGRectMake(0, 0, screenWidth, screenHeight-44+8), style: .Plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .None
        self.tableView.backgroundColor = yojpTableViewColor
        self.view.addSubview(self.tableView)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 {
            
            let label : UILabel = UILabel(frame: CGRectMake(0,0,screenWidth-48,30))
            label.font = font16
            label.textColor = yojpText
            label.text = "    在这个冬天的早晨，静静的看看柏林老宅里的暖心咖啡馆"
            label.numberOfLines = 0
            label.sizeToFit()
            
            return 35 + label.frame.size.height + 4 + screenWidth/5*3 + 8 + 16
        }
//        else if indexPath.section == 1 && indexPath.row == 0 {
//            return 44
//        }
        else {
            return 350 + 30*3
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            tableView.registerNib(UINib(nibName: "CollectTableViewCell", bundle: nil), forCellReuseIdentifier: "CollectTableViewCellId")
            let cell = tableView.dequeueReusableCellWithIdentifier("CollectTableViewCellId", forIndexPath: indexPath) as! CollectTableViewCell
            
            cell.selectionStyle = .None
            
            cell.productNameLabel.text = "商品名称"
            cell.productDicLabel.text = "    在这个冬天的早晨，静静的看看柏林老宅里的暖心咖啡馆"
            cell.moneyLabel.text = "￥300"
            cell.productImageView.hidden = true
            
            cell.moneyImageView.hidden = true
            cell.moneyLabel.hidden = true
            cell.collectionBtn.hidden = true
            let label : UILabel = UILabel(frame: CGRectMake(0,0,screenWidth-48,30))
            label.font = font16
            label.textColor = yojpText
            label.text = "    在这个冬天的早晨，静静的看看柏林老宅里的暖心咖啡馆"
            label.numberOfLines = 0
            label.sizeToFit()
            
            
            let scrollView : UIScrollView = UIScrollView(frame: CGRectMake(0,35 + label.frame.size.height+4+8,screenWidth,screenWidth/5*3))
            scrollView.contentSize = CGSizeMake(screenWidth*2, 0)
            scrollView.pagingEnabled = true
            cell.contentView.addSubview(scrollView)
            
            for i in 0...1 {
                let imageView : UIImageView = UIImageView(frame: CGRectMake(CGFloat(i)*screenWidth ,0 , screenWidth,screenWidth/5*3))
                imageView.image = UIImage(named: String(format: "image%d", i))
                scrollView.addSubview(imageView)
            }
            
            
            self.collectionBtn = MCFireworksButton(frame: CGRectMake(16, 35 + label.frame.size.height+4+8+screenWidth/5*3-35, 25, 25))
            
            
            self.collectionBtn.particleImage = UIImage(named: "spark")
            self.collectionBtn.particleScale = 0.05
            self.collectionBtn.particleScaleRange = 0.02
            self.collectionBtn.selected = self.collectionSelect
            
            self.collectionBtn.setImage(UIImage(named: "collectionWhite"), forState: .Normal)
            self.collectionBtn.setImage(UIImage(named: "collectionWhite"), forState: .Highlighted)
            
            if self.collectionBtn.selected {
                self.collectionBtn.popOutsideWithDuration(0.5)
                self.collectionBtn.setImage(UIImage(named: "collectionGolden"), forState: .Normal)
                self.collectionBtn.animate()
                self.collectionBtn.setImage(UIImage(named: "collectionGolden"), forState: .Highlighted)
            }
            else {
                self.collectionBtn.popInsideWithDuration(0.4)
                self.collectionBtn.setImage(UIImage(named: "collectionWhite"), forState: .Normal)
                self.collectionBtn.setImage(UIImage(named: "collectionWhite"), forState: .Highlighted)
            }
            
            self.collectionBtn.addTarget(self, action: Selector("collectionClicked:"), forControlEvents: UIControlEvents.TouchUpInside)
            cell.contentView.addSubview(self.collectionBtn)
            
            return cell
        }
//        else if indexPath.section == 1 && indexPath.row == 0 {
//            tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cellId")
//            let cell : UITableViewCell = UITableViewCell(style: .Value1, reuseIdentifier: "cellId")
//            cell.selectionStyle = UITableViewCellSelectionStyle.None
//            cell.accessoryType = .DisclosureIndicator
//            
//            cell.textLabel?.text = self.ticketType
//            cell.detailTextLabel?.text = "已有200人领取"
//            cell.textLabel?.textColor = yojpText
//            cell.detailTextLabel?.textColor = yojpLightText
//            cell.detailTextLabel?.font = font14
//            
//            return cell
//        }
        else {
            tableView.registerNib(UINib(nibName: "StoreInfoTableViewCell", bundle: nil), forCellReuseIdentifier: "StoreInfoTableViewCellId")
            let cell = tableView.dequeueReusableCellWithIdentifier("StoreInfoTableViewCellId", forIndexPath: indexPath) as! StoreInfoTableViewCell
            
            cell.selectionStyle = .None
            
            cell.gotoStoreCallBtn.setBackgroundImage(UIImage(named: "YOJPLogo"), forState: .Normal)
            cell.gotoStoreCallBtn.setBackgroundImage(UIImage(named: "YOJPLogo"), forState: .Highlighted)
            cell.gotoStoreCallBtn.tag = indexPath.row
            cell.gotoStoreCallBtn.callBack = { tag in
                
                let productListViewController = ProductListViewController()
                productListViewController.ticketType = self.ticketType
                self.navigationController?.pushViewController(productListViewController, animated: true)
            }
            
            cell.moreCallBackBtn.callBack = { tag in
                
                self.navigationController?.pushViewController(MoreStoresViewController(), animated: true)
            }
            
            return cell
        }
    }

    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
//        if indexPath.section == 1 && indexPath.row == 0 {
//            
//            let takeTicketViewController = TakeTicketViewController()
//            takeTicketViewController.ticketType = self.ticketType
//            self.navigationController?.pushViewController(takeTicketViewController, animated: true)
//        }
    }
    
    func collectionClicked(sender : UIButton) {
        sender.selected = !sender.selected
        self.collectionSelect = sender.selected
        if sender.selected {
            self.collectionBtn.popOutsideWithDuration(0.5)
            self.collectionBtn.setImage(UIImage(named: "collectionGolden"), forState: .Normal)
            self.collectionBtn.animate()
            self.collectionBtn.setImage(UIImage(named: "collectionGolden"), forState: .Highlighted)
            
            SVProgressShow.showSuccessWithStatus("收藏成功!")
        }
        else {
            self.collectionBtn.popInsideWithDuration(0.4)
            self.collectionBtn.setImage(UIImage(named: "collectionWhite"), forState: .Normal)
            self.collectionBtn.setImage(UIImage(named: "collectionWhite"), forState: .Highlighted)
        }
    }
    
    func shareClicked() {
        let action1 : DOPAction = DOPAction(name: "微信", iconName: "weixin") { () -> Void in
            SVProgressShow.showWithStatus("分享中...")
            let delayInSeconds : Double = 1
            let popTime : dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds * Double(NSEC_PER_SEC)))
            dispatch_after(popTime, dispatch_get_main_queue(), { () -> Void in
                SVProgressShow.showSuccessWithStatus("微信分享成功!分享有礼获得10积分已存入到你的积分账户之中")
            })
        }
        
        let action2 : DOPAction = DOPAction(name: "QQ", iconName: "qq") { () -> Void in
            SVProgressShow.showWithStatus("分享中...")
            let delayInSeconds : Double = 1
            let popTime : dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds * Double(NSEC_PER_SEC)))
            dispatch_after(popTime, dispatch_get_main_queue(), { () -> Void in                SVProgressShow.showSuccessWithStatus("QQ分享成功!分享有礼获得10积分已存入到你的积分账户之中")
            })
        }
        
        let action3 : DOPAction = DOPAction(name: "微信朋友圈", iconName: "wxFriends") { () -> Void in
            SVProgressShow.showWithStatus("分享中...")
            let delayInSeconds : Double = 1
            let popTime : dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds * Double(NSEC_PER_SEC)))
            dispatch_after(popTime, dispatch_get_main_queue(), { () -> Void in
                SVProgressShow.showSuccessWithStatus("微信朋友圈分享成功!分享有礼获得10积分已存入到你的积分账户之中")
            })
        }
        
        let action4 : DOPAction = DOPAction(name: "QQ空间", iconName: "qzone") { () -> Void in
            SVProgressShow.showWithStatus("分享中...")
            let delayInSeconds : Double = 1
            let popTime : dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds * Double(NSEC_PER_SEC)))
            dispatch_after(popTime, dispatch_get_main_queue(), { () -> Void in                SVProgressShow.showSuccessWithStatus("QQ空间分享成功!分享有礼获得10积分已存入到你的积分账户之中")
            })
        }
        
        let action5 : DOPAction = DOPAction(name: "微博", iconName: "weibo") { () -> Void in
            SVProgressShow.showWithStatus("分享中...")
            let delayInSeconds : Double = 1
            let popTime : dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds * Double(NSEC_PER_SEC)))
            dispatch_after(popTime, dispatch_get_main_queue(), { () -> Void in
                SVProgressShow.showSuccessWithStatus("新浪微博分享成功!分享有礼获得10积分已存入到你的积分账户之中")
            })
        }
        
        let action6 : DOPAction = DOPAction(name: "短信", iconName: "sms") { () -> Void in
            SVProgressShow.showWithStatus("短信发送中...")
            let delayInSeconds : Double = 1
            let popTime : dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds * Double(NSEC_PER_SEC)))
            dispatch_after(popTime, dispatch_get_main_queue(), { () -> Void in                SVProgressShow.showSuccessWithStatus("短信发送成功!分享有礼获得10积分已存入到你的积分账户之中")
            })
        }
        
        let action7 : DOPAction = DOPAction(name: "邮件", iconName: "email") { () -> Void in
            SVProgressShow.showWithStatus("邮件发送中...")
            let delayInSeconds : Double = 1
            let popTime : dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds * Double(NSEC_PER_SEC)))
            dispatch_after(popTime, dispatch_get_main_queue(), { () -> Void in
                SVProgressShow.showSuccessWithStatus("邮件发送成功!分享有礼获得10积分已存入到你的积分账户之中")
            })
        }
        
        let actions : NSArray = ["",[action1,action2,action3,action4],"",[action5,action6,action7]]
        let myAs : DOPScrollableActionSheet = DOPScrollableActionSheet(actionArray: actions as [AnyObject])
        myAs.show()
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
