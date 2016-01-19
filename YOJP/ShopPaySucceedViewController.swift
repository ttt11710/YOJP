//
//  ShopPaySucceedViewController.swift
//  YOJP
//
//  Created by PayBay on 16/1/19.
//  Copyright © 2016年 PayBay. All rights reserved.
//

import UIKit

class ShopPaySucceedViewController: UIViewController {
    
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
        self.view.addSubview(self.customNavigationBar)
        
    }
    
    func creatScrollView() {
        self.scrollView = UIScrollView(frame: CGRectMake(0,0,screenWidth,screenHeight-44))
        self.scrollView.contentSize = CGSizeMake(0, screenHeight+20)
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(self.scrollView)
        
        let succeedLabel : UILabel = UILabel()
        succeedLabel.text = "支付成功"
        succeedLabel.textColor = yojpText
        succeedLabel.textAlignment = .Center
        succeedLabel.bounds = CGRectMake(0, 0, 200, 25)
        succeedLabel.center = CGPointMake(screenWidth/2, 60)
        self.scrollView.addSubview(succeedLabel)
        
        let barcodeBackImageView : UIImageView = UIImageView(image: UIImage(named: "2DBarcode"))
        barcodeBackImageView.center = CGPointMake(screenWidth/2, 100+100)
        barcodeBackImageView.bounds = CGRectMake(0, 0, 200, 200)
        self.scrollView.addSubview(barcodeBackImageView)
        
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("showSucceedView"))
        barcodeBackImageView.userInteractionEnabled = true
        barcodeBackImageView.addGestureRecognizer(tap)
        
        let codeLabel : UILabel = UILabel(frame: CGRectMake(barcodeBackImageView.frame.origin.x,barcodeBackImageView.frame.origin.y+barcodeBackImageView.frame.size.height + 10,200,35))
        codeLabel.text = "JP1C2015N11Y26R17"
        codeLabel.textAlignment = .Center
        codeLabel.textColor = yojpText
        codeLabel.font = font15
        self.scrollView.addSubview(codeLabel)
        
        let sureBtn : UIButton = UIButton(frame: CGRectMake(32,codeLabel.frame.origin.y+codeLabel.frame.size.height + 20,screenWidth-64,44))
        sureBtn.setTitle("确定", forState: .Normal)
        sureBtn.backgroundColor = yojpBlue
        sureBtn.addTarget(self, action: Selector("sureBtnPressed"), forControlEvents: .TouchUpInside)
        sureBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        self.scrollView.addSubview(sureBtn)
        
        
        let payMoneyLabel : UILabel = UILabel(frame: CGRectMake(16,sureBtn.frame.origin.y+sureBtn.frame.size.height + 20,200,20))
        payMoneyLabel.text = "订单金额：¥900(1800日元)"
        payMoneyLabel.textColor = yojpText
        payMoneyLabel.font = font14
        self.scrollView.addSubview(payMoneyLabel)
        
        
        let orderNumLabel : UILabel = UILabel(frame: CGRectMake(16,payMoneyLabel.frame.origin.y+payMoneyLabel.frame.size.height + 4,200,20))
        orderNumLabel.text = "订单号码：JP2000000000000"
        orderNumLabel.textColor = yojpText
        orderNumLabel.font = font14
        self.scrollView.addSubview(orderNumLabel)
        
        let payTimeLabel : UILabel =  UILabel(frame: CGRectMake(16,orderNumLabel.frame.origin.y+orderNumLabel.frame.size.height + 4,200,20))
        payTimeLabel.text = "付款时间：2015.12.28 11:29"
        payTimeLabel.textColor = yojpText
        payTimeLabel.font = font14
        self.scrollView.addSubview(payTimeLabel)
        
        let addressLabel : UILabel = UILabel(frame: CGRectMake(16,payTimeLabel.frame.origin.y+payTimeLabel.frame.size.height + 4,300,20))
        addressLabel.text = "商家地址：某某街某某路某某号 东京店"
        addressLabel.textColor = yojpText
        addressLabel.font = font14
        self.scrollView.addSubview(addressLabel)
        
        let view : UIView = UIView(frame: CGRectMake(0,addressLabel.frame.origin.y+addressLabel.frame.size.height + 20,screenWidth,100))
        view.backgroundColor = yojpLightCell
        self.scrollView.addSubview(view)
        
        let tipLabel : UILabel = UILabel(frame: CGRectMake(16,10,100,20))
        tipLabel.text = "温馨提示:"
        tipLabel.font = font14
        tipLabel.textColor = yojpText
        view.addSubview(tipLabel)
        
        let tipSubLabel : UILabel = UILabel(frame: CGRectMake(16,tipLabel.frame.origin.y+tipLabel.frame.size.height,screenWidth-16,100))
        tipSubLabel.text = "请记得到指定 “商家地址” 领取您的商品哦！"
        tipSubLabel.textColor = yojpText
        tipSubLabel.font = font13
        tipSubLabel.numberOfLines = 0
        tipSubLabel.sizeToFit()
        view.addSubview(tipSubLabel)
        
        view.frame = CGRectMake(0,addressLabel.frame.origin.y+addressLabel.frame.size.height + 20,screenWidth,tipSubLabel.frame.origin.y+tipSubLabel.frame.size.height+16)
    }
    
    func showSucceedView() {
        self.navigationController?.pushViewController(OrderSucceedViewController(), animated: false)
    }
    
    func sureBtnPressed() {
        self.navigationController?.popToViewController(self.navigationController!.viewControllers[1], animated: true)
        ShopCarListViewController.shareShopCarListViewController().removeAllShopCarList()
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
