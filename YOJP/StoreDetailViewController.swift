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
    var imageView : UIImageView!
    var label1 : UILabel!
    
    var horScrollView : UIScrollView!
    var label2 : UILabel!
    
    
    var dataArray : NSMutableArray = ["     在这个冬天的早晨，静静的看看柏林老宅里的暖心咖啡馆。最闹心的烦躁是你根本不知道自己究竟在烦什么，无缘无故就全身负能量爆棚 。巴拉拉巴拉拉巴拉拉巴。所谓的贵人：就是开拓你的眼界，带你进入新的世界。","    曾经再美，不过一回空谈。脚下艰难，却是直指明天。","    学会了适应，就会让你的环境变得明亮；学会了宽容，就会让你的生活没有烦恼。","    当你能飞的时候，就不要放弃飞;当你能梦的时候，就不要放弃梦。世界没有尽头，只要心中还有追求。人生真正的终点是希望的终结。苍鹰的骄傲是飞翔的双翼，人生的意义是不断的追求。","    最闹心的烦躁是你根本不知道自己究竟在烦什么，无缘无故就全身负能量爆棚 。巴拉拉巴拉拉巴拉拉巴","    所谓的贵人：就是开拓你的眼界，带你进入新的世界。 明天是否辉煌，取决于你今天的选择和行动！","    男人穷不要紧，就怕又穷又有脾气。女人丑也不要紧，就怕又丑又懒惰。","    无论你此刻是否迷茫，在阳光升起的时候，请相信，努力的人最终都有回报 。"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.creatCustomNavigationBar()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.sharedApplication().statusBarStyle = .Default
    }
    
    
    func initView() {
        
      //  self.view.backgroundColor = UIColor.orangeColor()
        
        self.scrollView = UIScrollView(frame: CGRectMake(0,0,screenWidth,screenHeight-44))
        self.scrollView.contentSize = CGSizeMake(0, screenHeight+300)
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.delegate = self
        self.view.addSubview(self.scrollView)
        
        self.imageView = UIImageView(frame: CGRectMake(screenWidth/4, 40, screenWidth/2-2, (screenWidth-10)/8*3))
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
        
        
        
        self.view.addSubview(self.customNavigationBar)
    }

    
    func creatCustomNavigationBar() {
        self.customNavigationBar = UIView(frame: CGRectMake(0,screenHeight-44,screenWidth,44))
        self.customNavigationBar.backgroundColor = yojpBlue
        
        
        let backBtn = UIButton(type: .Custom)
        backBtn.frame = CGRectMake(20, 7, 30, 30)
        backBtn.setBackgroundImage(UIImage(named: "箭头"), forState: UIControlState.Normal)
        backBtn.addTarget(self, action: Selector("backClicked"), forControlEvents: UIControlEvents.TouchUpInside)
        self.customNavigationBar.addSubview(backBtn)
        
        
        let collectionBtn = UIButton(type: .Custom)
        collectionBtn.frame = CGRectMake(screenWidth-100, 7, 25, 25)
        collectionBtn.setBackgroundImage(UIImage(named: "collectionWhite"), forState: UIControlState.Normal)
        collectionBtn.setBackgroundImage(UIImage(named: "collectionGolden"), forState: UIControlState.Selected)
        collectionBtn.addTarget(self, action: Selector("collectionClicked:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.customNavigationBar.addSubview(collectionBtn)
        
        
        let shareBtn = UIButton(type: .Custom)
        shareBtn.frame = CGRectMake(screenWidth-55, 7, 25, 25)
        shareBtn.setBackgroundImage(UIImage(named: "share"), forState: UIControlState.Normal)
        shareBtn.addTarget(self, action: Selector("shareClicked"), forControlEvents: UIControlEvents.TouchUpInside)
        self.customNavigationBar.addSubview(shareBtn)
        
        
    }

    
    func backClicked() {
        
        
        print(self.scrollView.contentOffset)
        
        
        self.delegate.modalViewControllerDidClickedDismissButton(self, height: self.scrollView.contentOffset.y)
        
//        if self.delegate != nil && self.delegate.respondsToSelector(Selector("modalViewControllerDidClickedDismissButton:")) {
//            self.delegate.modalViewControllerDidClickedDismissButton(self, height: self.scrollView.contentOffset.y)
//        }
    }
    
    func changeText() {
        self.label2.text = self.dataArray[Int(arc4random()%7)+1] as? String
        self.label2.sizeToFit()
    }
    
    func collectionClicked(sender : UIButton) {
        sender.selected = !sender.selected
        if sender.selected {
            SVProgressShow.showSuccessWithStatus("收藏成功!")
        }
    }
    
    func shareClicked() {
        let action1 : DOPAction = DOPAction(name: "微信", iconName: "weixin") { () -> Void in
            SVProgressShow.showWithStatus("分享中...")
            let delayInSeconds : Int64 = 1
            let popTime : dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds)
            dispatch_after(popTime, dispatch_get_main_queue()) { () -> Void in
                SVProgressShow.showSuccessWithStatus("微信分享成功!")
            }
        }
        
        let action2 : DOPAction = DOPAction(name: "QQ", iconName: "qq") { () -> Void in
            SVProgressShow.showWithStatus("分享中...")
            let delayInSeconds : Int64 = 1
            let popTime : dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds)
            dispatch_after(popTime, dispatch_get_main_queue()) { () -> Void in
                SVProgressShow.showSuccessWithStatus("QQ分享成功!")
            }
        }
        
        let action3 : DOPAction = DOPAction(name: "微信朋友圈", iconName: "wxFriends") { () -> Void in
            SVProgressShow.showWithStatus("分享中...")
            let delayInSeconds : Int64 = 1
            let popTime : dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds)
            dispatch_after(popTime, dispatch_get_main_queue()) { () -> Void in
                SVProgressShow.showSuccessWithStatus("微信朋友圈分享成功!")
            }
        }
        
        let action4 : DOPAction = DOPAction(name: "QQ空间", iconName: "qzone") { () -> Void in
            SVProgressShow.showWithStatus("分享中...")
            let delayInSeconds : Int64 = 1
            let popTime : dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds)
            dispatch_after(popTime, dispatch_get_main_queue()) { () -> Void in
                SVProgressShow.showSuccessWithStatus("QQ空间分享成功!")
            }
        }
        
        let action5 : DOPAction = DOPAction(name: "微博", iconName: "weibo") { () -> Void in
            SVProgressShow.showWithStatus("分享中...")
            let delayInSeconds : Int64 = 1
            let popTime : dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds)
            dispatch_after(popTime, dispatch_get_main_queue()) { () -> Void in
                SVProgressShow.showSuccessWithStatus("新浪微博分享成功!")
            }
        }
        
        let action6 : DOPAction = DOPAction(name: "短信", iconName: "sms") { () -> Void in
            SVProgressShow.showWithStatus("短信发送中...")
            let delayInSeconds : Int64 = 1
            let popTime : dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds)
            dispatch_after(popTime, dispatch_get_main_queue()) { () -> Void in
                SVProgressShow.showSuccessWithStatus("短信发送成功!")
            }
        }
        
        let action7 : DOPAction = DOPAction(name: "邮件", iconName: "email") { () -> Void in
            SVProgressShow.showWithStatus("邮件发送中...")
            let delayInSeconds : Int64 = 1
            let popTime : dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds)
            dispatch_after(popTime, dispatch_get_main_queue()) { () -> Void in
                SVProgressShow.showSuccessWithStatus("邮件发送成功!")
            }
        }
        
        let actions : NSArray = ["",[action1,action2,action3,action4],"",[action5,action6,action7]]
        let myAs : DOPScrollableActionSheet = DOPScrollableActionSheet(actionArray: actions as [AnyObject])
        myAs.show()
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
