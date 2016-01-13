//
//  CardUseRuleViewController.swift
//  YOJP
//
//  Created by PayBay on 15/12/4.
//  Copyright © 2015年 PayBay. All rights reserved.
//

import UIKit

class CardUseRuleViewController: UIViewController,UIAlertViewDelegate {

    
    var customNavigationBar : UIView!
    var scrollView : UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.creatCustomNavigationBar()
        self.creatScrollView()
        self.creatDetailView()
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
    
    func creatScrollView() {
        
        self.scrollView = UIScrollView(frame: CGRectMake(0 ,0,screenWidth,screenHeight-44))
        self.scrollView.contentSize = CGSizeMake(0,100)
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.backgroundColor = UIColor(white: 0.9, alpha: 1)
        self.view.addSubview(self.scrollView)
        
    }
    
    func creatDetailView() {
        
        let countCardName : UILabel = UILabel(frame: CGRectMake(16,40,40,30))
        countCardName.font = font15
        countCardName.text = "卡券名称:"
        countCardName.textColor = yojpText
        countCardName.sizeToFit()
        self.scrollView.addSubview(countCardName)
        
        let cardName : UILabel = UILabel(frame: CGRectMake(countCardName.frame.origin.x + countCardName.frame.size.width + 5,40,screenWidth-countCardName.frame.origin.x - countCardName.frame.size.width - 5 - 16,30))
        cardName.text = "某某卡券"
        cardName.font = font15
        cardName.textColor = yojpLightText
        cardName.backgroundColor = UIColor.whiteColor()
        cardName.layer.borderColor = yojpText.CGColor
        cardName.layer.borderWidth = 1
        cardName.center.y = countCardName.center.y
        self.scrollView.addSubview(cardName)
        
        let useBtn : UIButton = UIButton(frame: CGRectMake(16,cardName.frame.origin.y + cardName.frame.size.height + 16,screenWidth-32,40))
        useBtn.setTitle("确认使用", forState: .Normal)
        useBtn.setTitleColor(yojpBlue, forState: .Normal)
        useBtn.titleLabel?.font = font15
        useBtn.backgroundColor = UIColor.whiteColor()
        useBtn.addTarget(self, action: Selector("userBtnPressed"), forControlEvents: .TouchUpInside)
        self.scrollView.addSubview(useBtn)
        
        let countUseRuleLabel : UILabel = UILabel(frame: CGRectMake(16,useBtn.frame.origin.y + useBtn.frame.size.height + 16,100,30))
        countUseRuleLabel.text = "使用说明:"
        countUseRuleLabel.textColor = yojpText
        countUseRuleLabel.font = font15
        countUseRuleLabel.sizeToFit()
        self.scrollView.addSubview(countUseRuleLabel)
        
        let useRuleLabelBackView : UIView = UIView(frame: CGRectMake(16,countUseRuleLabel.frame.origin.y + countUseRuleLabel.frame.size.height + 8,screenWidth-32,screenWidth-32))
        useRuleLabelBackView.backgroundColor = UIColor.whiteColor()
        self.scrollView.addSubview(useRuleLabelBackView)
        
        let useRuleLabel : UILabel = UILabel(frame: CGRectMake(0,16,screenWidth-32,100))
        useRuleLabel.text = "有效期:2015-11.11-2016.11.11\n1.\n2.\n3.\n4.\n5.\n6."
        useRuleLabel.textColor = yojpText
        useRuleLabel.font = font15
        useRuleLabel.numberOfLines = 0
        useRuleLabel.sizeToFit()
        useRuleLabelBackView.addSubview(useRuleLabel)
        
    }

    
    func userBtnPressed() {
        
        let alertView : UIAlertView = UIAlertView(title: "警告", message: "注意!确认使用后,本券将失效", delegate: self, cancelButtonTitle: "取消操作", otherButtonTitles: "确认使用")
        alertView.show()
    
    }
    
    func alertView(alertView: UIAlertView, clickedButtonAtIndex buttonIndex: Int) {
        switch buttonIndex {
        case 0:
            print("取消操作")
        case 1:
            SVProgressShow.showSuccessWithStatus("兑换成功!")
            self.navigationController?.popToViewController(self.navigationController!.viewControllers[1], animated: true)
        default:
            break
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
