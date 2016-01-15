//
//  TextViewController.swift
//  YOJP
//
//  Created by PayBay on 15/11/26.
//  Copyright © 2015年 PayBay. All rights reserved.
//

import UIKit


protocol StoreDetailViewControllerDelegate : NSObjectProtocol {
    
    func modalViewControllerDidClickedDismissButton(viewController : StoreDetailViewController, height : CGFloat)
}


class StoreDetailViewController: UIViewController,UIScrollViewDelegate {
    var delegate : StoreDetailViewControllerDelegate!
    
    
    var customNavigationBar : UIView!
    
    var scrollView : UIScrollView!
    
    var storeNameSrting : String!
    
    var storeName : UILabel!
    var imageView : UIImageView!
    var label1 : UILabel!
    var updateTime : UILabel!
    
    var horScrollView : UIScrollView!
    var label2 : UILabel!
    var freeTicket : UIButton!
    
    var collectionBtn : MCFireworksButton!
    
    var dataArray : NSMutableArray = ["     在这个冬天的早晨，静静的看看柏林老宅里的暖心咖啡馆。最闹心的烦躁是你根本不知道自己究竟在烦什么，无缘无故就全身负能量爆棚 。巴拉拉巴拉拉巴拉拉巴。所谓的贵人：就是开拓你的眼界，带你进入新的世界。","    曾经再美，不过一回空谈。脚下艰难，却是直指明天。","    学会了适应，就会让你的环境变得明亮；学会了宽容，就会让你的生活没有烦恼。","    当你能飞的时候，就不要放弃飞;当你能梦的时候，就不要放弃梦。世界没有尽头，只要心中还有追求。人生真正的终点是希望的终结。苍鹰的骄傲是飞翔的双翼，人生的意义是不断的追求。","    最闹心的烦躁是你根本不知道自己究竟在烦什么，无缘无故就全身负能量爆棚 。巴拉拉巴拉拉巴拉拉巴","    所谓的贵人：就是开拓你的眼界，带你进入新的世界。 明天是否辉煌，取决于你今天的选择和行动！","    男人穷不要紧，就怕又穷又有脾气。女人丑也不要紧，就怕又丑又懒惰。","    无论你此刻是否迷茫，在阳光升起的时候，请相信，努力的人最终都有回报 。"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.creatCustomNavigationBar()
       // self.creatNavigationView()
        self.creatScrollView()
        
        
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

    
    func creatNavigationView() {
        let view : UIView = UIView(frame: CGRectMake(0,0,screenWidth,64))
        view.backgroundColor = yojpBlue
        self.view.addSubview(view)
        
        let storeBtn = UIButton(type: .Custom)
        storeBtn.frame = CGRectMake(screenWidth-42,20 + 7, 26, 26)
        storeBtn.setBackgroundImage(UIImage(named: "商家入口"), forState: UIControlState.Normal)
        storeBtn.addTarget(self, action: Selector("storeBtnClicked"), forControlEvents: UIControlEvents.TouchUpInside)
        storeBtn.setBackgroundImage(UIImage(named: "商家入口"), forState: UIControlState.Selected)
        view.addSubview(storeBtn)

        
        //购物车
        let shopCarBtn = UIButton(type: .Custom)
        shopCarBtn.frame = CGRectMake(screenWidth-42-26-16,20 + 7, 26, 26)
        shopCarBtn.setBackgroundImage(UIImage(named: "购物车"), forState: UIControlState.Normal)
        shopCarBtn.setBackgroundImage(UIImage(named: "购物车"), forState: UIControlState.Selected)
        shopCarBtn.addTarget(self, action: Selector("shopCarBtnClicked"), forControlEvents: UIControlEvents.TouchUpInside)
        view.addSubview(shopCarBtn)
        
    }
    
    
    func creatScrollView() {
        
      //  self.view.backgroundColor = UIColor.orangeColor()
        
        self.scrollView = UIScrollView(frame: CGRectMake(0,20,screenWidth,screenHeight-44-20))
        self.scrollView.contentSize = CGSizeMake(0, screenHeight+300)
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.delegate = self
        self.view.addSubview(self.scrollView)
        
        
        self.storeName = UILabel(frame: CGRectMake(16,0,200,25))
        self.storeName.text = storeNameSrting
        self.storeName.textColor = yojpText
        self.scrollView.addSubview(self.storeName)
        
        self.updateTime = UILabel(frame: CGRectMake(screenWidth-150,30,140,30))
        self.updateTime.text = "4小时前"
        self.updateTime.font = font14
        self.updateTime.textAlignment = .Right
        self.updateTime.textColor = yojpText
        self.scrollView.addSubview(self.updateTime)
        
        
        self.imageView = UIImageView(frame: CGRectMake(screenWidth/4, self.updateTime.frame.origin.y + self.updateTime.frame.size.height+8, screenWidth/2-2, (screenWidth-10)/8*3))
        self.imageView.image = UIImage(named: "image2")
        self.scrollView.addSubview(self.imageView)
        
        let tap = UITapGestureRecognizer(target: self, action: Selector("backClicked"))
        self.imageView.userInteractionEnabled = true
        self.imageView.addGestureRecognizer(tap)
        
        
        self.label1 = UILabel(frame: CGRectMake(16,self.imageView.frame.origin.y + self.imageView.frame.size.height + 16,screenWidth-32,20))
        self.label1.text = self.dataArray[0] as? String
        self.label1.textColor = yojpText
        self.label1.font = font16
        self.label1.numberOfLines = 0
        self.label1.sizeToFit()
        self.scrollView.addSubview(self.label1)
        
        
        self.horScrollView = UIScrollView(frame: CGRectMake(0,self.label1.frame.origin.y + self.label1.frame.size.height + 8,screenWidth,150))
        self.horScrollView.contentSize = CGSizeMake(670, 0)
        self.horScrollView.showsHorizontalScrollIndicator = false
        self.horScrollView.showsVerticalScrollIndicator = false
        self.horScrollView.delegate = self
        self.scrollView.addSubview(self.horScrollView)
        
        for i in 0...5 {
            let imageView : UIImageView = UIImageView(frame: CGRectMake(CGFloat(i+1)*10 + 100 * CGFloat(i), 10, 100, 150))
            imageView.image = UIImage(named: String(format: "image%d", i))
            let tap = UITapGestureRecognizer(target: self, action: Selector("changeText"))
            imageView.userInteractionEnabled = true
            imageView.addGestureRecognizer(tap)
            
            self.horScrollView.addSubview(imageView)
        }
        
        self.label2 = UILabel(frame: CGRectMake(16,self.horScrollView.frame.origin.y + self.horScrollView.frame.size.height + 8,screenWidth-32,20))
        self.label2.text = self.dataArray[Int(arc4random()%7)+1] as? String
        self.label2.textColor = yojpText
        self.label2.font = font16
        self.label2.numberOfLines = 0
        self.label2.sizeToFit()
        self.scrollView.addSubview(self.label2)
        
        
        self.freeTicket = UIButton(type: .Custom)
        self.freeTicket.frame = CGRectMake(screenWidth/2-60, self.label2.frame.origin.y + self.label2.frame.size.height + 8, 120, 35)
        self.freeTicket.setTitle("免费券领取", forState: .Normal)
        self.freeTicket.setTitleColor(yojpBlue, forState: .Normal)
        self.freeTicket.backgroundColor = UIColor.whiteColor()
        self.freeTicket.layer.cornerRadius = 4
        self.freeTicket.layer.borderColor = yojpBlue.CGColor
        self.freeTicket.layer.borderWidth = 1
        self.freeTicket.addTarget(self, action: Selector("getFreeTicket"), forControlEvents: .TouchUpInside)
        self.scrollView.addSubview(self.freeTicket)
        
        
        self.view.addSubview(self.customNavigationBar)
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
        
        
    }

    
    func backClicked() {
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func changeText() {
        self.label2.text = self.dataArray[Int(arc4random()%7)+1] as? String
        self.label2.sizeToFit()
        self.freeTicket.frame = CGRectMake(screenWidth/2-60, self.label2.frame.origin.y + self.label2.frame.size.height + 8, 120, 35)
        
    
        
        self.navigationController?.pushViewController(ProductListViewController(), animated: true)
    }
    
    func getFreeTicket() {
        SVProgressShow.showSuccessWithStatus("免费券领取成功!,免费券已在您的卡券之中")
    }
    
    func collectionClicked(sender : UIButton) {
        sender.selected = !sender.selected
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
    
    func storeBtnClicked() {
        self.navigationController?.pushViewController(ProductListViewController(), animated: true)
    }
    
    func shopCarBtnClicked() {
        self.navigationController?.pushViewController(ShopCarListViewController(), animated: true)
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
