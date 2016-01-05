//
//  TakeTicketViewController.swift
//  YOJP
//
//  Created by PayBay on 16/1/4.
//  Copyright © 2016年 PayBay. All rights reserved.
//

import UIKit

class TakeTicketViewController: UIViewController {

    
    var ticketType : String!
    
    var customNavigationBar : UIView!
    var scrollView : UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        
        self.creatCustomNavigationBar()
        self.creatScrollView()
        self.creatDetailView()
        
        
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
        
        let ticketBtn : UIButton = UIButton(frame: CGRectMake(16,30,screenWidth-32,44))
        ticketBtn.setTitle(ticketType, forState: .Normal)
        ticketBtn.setTitle(ticketType, forState: .Highlighted)
        ticketBtn.backgroundColor = UIColor.whiteColor()
        ticketBtn.setTitleColor(yojpBlue, forState: .Normal)
        self.scrollView.addSubview(ticketBtn)
        
        let getTicket : UIButton = UIButton(frame: CGRectMake(screenWidth-90,ticketBtn.frame.origin.y + ticketBtn.frame.size.height + 8,70,30))
        if self.ticketType == "免费券" {
            
            getTicket.setTitle("领取", forState: .Normal)
            getTicket.setTitle("领取", forState: .Highlighted)
            getTicket.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            getTicket.backgroundColor = yojpBlue
            getTicket.addTarget(self, action: Selector("getTicketBtnPressed"), forControlEvents: .TouchUpInside)
            getTicket.layer.cornerRadius = 4
            self.scrollView.addSubview(getTicket)
        }
        else {
            getTicket.setTitle("购买", forState: .Normal)
            getTicket.setTitle("购买", forState: .Highlighted)
            getTicket.setTitleColor(UIColor.whiteColor(), forState: .Normal)
            getTicket.backgroundColor = yojpBlue
            getTicket.addTarget(self, action: Selector("buyTicketBtnPressed"), forControlEvents: .TouchUpInside)
            getTicket.layer.cornerRadius = 4
            self.scrollView.addSubview(getTicket)
            
            let picketImageView : UIImageView = UIImageView(frame: CGRectMake(16, getTicket.frame.origin.y+2, 36, 25))
            picketImageView.image = UIImage(named: "card")
            self.scrollView.addSubview(picketImageView)
            
            let moneyLabel : UILabel = UILabel(frame: CGRectMake(picketImageView.frame.origin.x+picketImageView.frame.size.width + 4,picketImageView.frame.origin.y,100,25))
            moneyLabel.text = "￥30.00"
            moneyLabel.font = font15
            moneyLabel.textColor = yojpText
            self.scrollView.addSubview(moneyLabel)
            
        }
        
        
        let countUseRuleLabel : UILabel = UILabel(frame: CGRectMake(16,getTicket.frame.origin.y + getTicket.frame.size.height + 16,100,30))
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
    
    func getTicketBtnPressed() {
       SVProgressShow.showSuccessWithStatus(String(format: "%@领取成功!%@已在您的卡包之中", self.ticketType,self.ticketType))
    }
    
    func buyTicketBtnPressed() {
        self.navigationController?.pushViewController(PayViewController(), animated: true)
        
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
