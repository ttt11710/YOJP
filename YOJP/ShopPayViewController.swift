//
//  ShopPayViewController.swift
//  YOJP
//
//  Created by PayBay on 15/12/24.
//  Copyright © 2015年 PayBay. All rights reserved.
//

import UIKit

class ShopPayViewController: UIViewController {

    var customNavigationBar : UIView!
    var scrollView : UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.creatCustomNavigationBar()
        self.creatScrollView()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.sharedApplication().statusBarStyle = .Default
        self.navigationController?.navigationBarHidden = true
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBarHidden = false
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
        self.scrollView = UIScrollView(frame: CGRectMake(0,0,screenWidth,screenHeight-44))
        self.scrollView.contentSize = CGSizeMake(0, screenHeight+20)
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(self.scrollView)
        
        let barcodeBackImageView : UIImageView = UIImageView(image: UIImage(named: "2DBarcode"))
        barcodeBackImageView.center = CGPointMake(screenWidth/2, 100+100)
        barcodeBackImageView.bounds = CGRectMake(0, 0, 200, 200)
        self.scrollView.addSubview(barcodeBackImageView)
        
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("showSucceedView"))
        barcodeBackImageView.userInteractionEnabled = true
        //barcodeBackImageView.addGestureRecognizer(tap)
        
        let timeLabel : UILabel = UILabel(frame: CGRectMake(barcodeBackImageView.frame.origin.x,barcodeBackImageView.frame.origin.y+barcodeBackImageView.frame.size.height + 30,200,35))
        timeLabel.text = "计时    00:30:00"
        timeLabel.textAlignment = .Center
        timeLabel.backgroundColor = yojpLightCell
        timeLabel.textColor = yojpText
        timeLabel.font = font16
        self.scrollView.addSubview(timeLabel)
        
        let dateLabel : UILabel = UILabel(frame: CGRectMake(timeLabel.frame.origin.x,timeLabel.frame.origin.y+timeLabel.frame.size.height + 2,200,20))
        dateLabel.text = "09:10   2015.12.16"
        dateLabel.textAlignment = .Right
        dateLabel.textColor = yojpText
        dateLabel.font = font10
        self.scrollView.addSubview(dateLabel)
        
        
        let sureBtn : UIButton = UIButton(type: .Custom)
        sureBtn.setTitle("确定", forState: .Normal)
        sureBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        sureBtn.backgroundColor = yojpBlue
        sureBtn.center = CGPointMake(screenWidth/2, dateLabel.frame.origin.y+dateLabel.frame.size.height+40)
        sureBtn.bounds = CGRectMake(0, 0, screenWidth-32, 44)
        self.scrollView.addSubview(sureBtn)
        sureBtn.addTarget(self, action: Selector("sureBtnPressed"), forControlEvents: .TouchUpInside)
        
    
        let view : UIView = UIView(frame: CGRectMake(0,sureBtn.frame.origin.y+sureBtn.frame.size.height + 22,screenWidth,100))
        view.backgroundColor = yojpLightCell
        self.scrollView.addSubview(view)
        
        let tipLabel : UILabel = UILabel(frame: CGRectMake(8,10,100,20))
        tipLabel.text = "温馨提示:"
        tipLabel.font = font14
        tipLabel.textColor = yojpText
        view.addSubview(tipLabel)
        
        let tipSubLabel : UILabel = UILabel(frame: CGRectMake(16,tipLabel.frame.origin.y+tipLabel.frame.size.height,screenWidth-16,100))
        tipSubLabel.text = "订单支付后，1小时内请到指定商家取货，否则订单失效，支付金额将会退回至您的账户。"
        tipSubLabel.textColor = yojpText
        tipSubLabel.font = font13
        tipSubLabel.numberOfLines = 0
        tipSubLabel.sizeToFit()
        view.addSubview(tipSubLabel)
        
        view.frame = CGRectMake(0,sureBtn.frame.origin.y+sureBtn.frame.size.height + 22,screenWidth,tipSubLabel.frame.origin.y+tipSubLabel.frame.size.height+16)
    }
    
    
    func sureBtnPressed() {
        
        SVProgressShow.showSuccessWithStatus("已保存到订单中")
        self.navigationController?.popToViewController(self.navigationController!.viewControllers[1], animated: true)
        ShopCarListViewController.shareShopCarListViewController().removeAllShopCarList()
    }
    
    
//    func showSucceedView() {
//        self.navigationController?.pushViewController(OrderSucceedViewController(), animated: false)
//    }
    
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
