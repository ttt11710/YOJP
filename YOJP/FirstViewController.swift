//
//  FirstViewController.swift
//  YOJP
//
//  Created by PayBay on 16/1/11.
//  Copyright © 2016年 PayBay. All rights reserved.
//

import UIKit


var defaultFirstViewController : FirstViewController!

class FirstViewController: UIViewController {

    
    var tabBarView : UIImageView!
    var previousBtn : NTButton!
    var tabBarScrollView : UIView!
    var tabBarViewWithOneTitle : UILabel!
    
    var myView : UIView!
    var firstRootViewController : FirstRootViewController!
    var secondRootViewController : SecondRootViewController!
    
    var escapeBtn : UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        
        defaultFirstViewController = self
        
        self.myView = UIView(frame: CGRectMake(0,0,screenWidth,screenHeight-64))
        self.view.addSubview(self.myView)
        
        let leftButtonItem : UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "menu"), style: .Done, target: self, action: Selector("leftButtonPressed"))
        self.navigationItem.setLeftBarButtonItem(leftButtonItem, animated: true)
        
        
        let rightButtonItem1 : UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "shopCarBar"), style: .Done, target: self, action: Selector("rightButton1Press"))
        
        let rightButtonItem2 : UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "扫一扫bar"), style: .Done, target: self, action: Selector("rightButton2Press"))
        
        self.navigationItem.setRightBarButtonItems([rightButtonItem2,rightButtonItem1], animated: true)
        
        self.firstRootViewController = FirstRootViewController()
        self.secondRootViewController = SecondRootViewController()
        addChildViewController(self.firstRootViewController)
        addChildViewController(self.secondRootViewController)
        self.myView.addSubview(self.firstRootViewController.view)
        self.myView.addSubview(self.secondRootViewController.view)
        
        self.secondRootViewController.view.hidden = true
        
        self.creatNavTitleView()
        
        let view : UIView = UIView(frame: CGRectMake(0,0,10,screenHeight))
        view.backgroundColor = UIColor.clearColor()
        self.view.addSubview(view)
        
        self.creatEscapeBtn()
        
        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        let tempAppDelegatea : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        tempAppDelegatea.leftSlideVC.setPanEnabled(true)
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        let tempAppDelegatea : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        tempAppDelegatea.leftSlideVC.setPanEnabled(false)
    }

    
    class func shareFirstViewController() -> FirstViewController {
        return defaultFirstViewController
    }
    
    func creatEscapeBtn() {
        
        self.escapeBtn = UIButton(type: .Custom)
        self.escapeBtn.frame = CGRectMake(10, screenHeight-60-64-118, 120, 108)
        self.escapeBtn.setBackgroundImage(UIImage(named: "escape"), forState: .Normal)
        self.escapeBtn.addTarget(self, action: Selector("showEscapeView"), forControlEvents: .TouchUpInside)
        self.escapeBtn.setBackgroundImage(UIImage(named: "escape"), forState: .Highlighted)
        self.escapeBtn.opaque = true
        
        self.view.insertSubview(self.escapeBtn, aboveSubview: self.view)
    }
    
    func showEscapeView() {
        
        SVProgressShow.showInfoWithStatus("此操作会进入逃生页面!")
    }

    func leftButtonPressed() {
        
        let tempAppDelegatea : AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        if tempAppDelegatea.leftSlideVC.closed {
            tempAppDelegatea.leftSlideVC.openLeftView()
        }
        else {
            tempAppDelegatea.leftSlideVC.closeLeftView()
        }
    }
    
    func rightButton1Press() {
//        self.navigationController?.presentViewController(SearchViewController(), animated: true, completion: { () -> Void in
//            
//        })
        self.navigationController?.pushViewController(ShopCarListViewController(), animated: true)

    }
    
    func rightButton2Press() {
        
        self.navigationController?.pushViewController(ScanViewController(), animated: true)
    }
    
    
    func creatNavTitleView() {
        
        self.tabBarView = UIImageView(frame: CGRectMake(0, 50, screenWidth-16-150, 44))
        self.tabBarView.backgroundColor = yojpBlue
        self.tabBarView.userInteractionEnabled = true
        self.navigationItem.titleView = self.tabBarView
        
        self.tabBarViewWithOneTitle = UILabel(frame: CGRectMake(0,0,screenWidth-16,44))
        self.tabBarViewWithOneTitle.textColor = UIColor.whiteColor()
        self.tabBarViewWithOneTitle.textAlignment = .Center
        
        
        self.tabBarScrollView = UIView(frame: CGRectMake(0,self.tabBarView.frame.size.height-3,self.tabBarView.frame.size.width/2,4))
        self.tabBarScrollView.backgroundColor = UIColor.whiteColor()
        self.tabBarView.addSubview(self.tabBarScrollView)
        
        self.navigationController?.navigationBar.translucent = false
        
        self.creatButtonWithNormalName("好物", SelectName: "未评价高亮", Index: 0)
        self.creatButtonWithNormalName("优店", SelectName: "已评价高亮", Index: 1)
        
        self.previousBtn = NTButton()
        let button : NTButton = self.tabBarView.subviews[1] as! NTButton
        self.changeViewController(button)
    }
    
    
    func creatButtonWithNormalName(normal : String, SelectName : String, Index : Int) {
        
        let customButton = NTButton(type: .Custom)
        customButton.tag = Index
        let buttonW = self.tabBarView.frame.size.width/2
        let buttonH = self.tabBarView.frame.size.height
        
        customButton.frame = CGRectMake(buttonW * CGFloat(Index), 0, buttonW, buttonH)
        customButton.opaque = true
        customButton.setBackgroundImage(UIImage(named: "未评价选中选中高亮"), forState: UIControlState.Disabled)
        customButton.setTitle(normal, forState: UIControlState.Normal)
        customButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Disabled)
        customButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        customButton.tag = Index
        customButton.titleLabel?.font = UIFont.systemFontOfSize(18.0)
        customButton.addTarget(self, action: Selector("changeViewController:"), forControlEvents: UIControlEvents.TouchDown)
        customButton.imageView?.contentMode = .Center
        self.tabBarView.addSubview(customButton)
        
        let imageView : UIImageView = UIImageView(frame: CGRectMake(self.tabBarView.frame.size.width/2-3, 0, 6, self.tabBarView.frame.size.height-2.5))
        imageView.backgroundColor = UIColor.whiteColor()
        
    }
    
    func changeViewController(sender : NTButton) {
        
        
        if self.previousBtn != sender {
            self.previousBtn.enabled = true
            self.previousBtn = sender
            sender.enabled = false
            
            
            UIView.animateWithDuration(0.8, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
                
                if sender.tag == 0 {
                    self.firstRootViewController.view.hidden = false
                    self.secondRootViewController.view.hidden = true
                    
                    self.tabBarScrollView.layer.transform = CATransform3DIdentity
                }
                else {
                    self.firstRootViewController.view.hidden = true
                    self.secondRootViewController.view.hidden = false
                    
                    self.tabBarScrollView.layer.transform = CATransform3DMakeTranslation(self.tabBarView.frame.size.width/2, 0, 0)
                }
                
                
                }, completion: { (finished : Bool) -> Void in
                    
            })
 
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
