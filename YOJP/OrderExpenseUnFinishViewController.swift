//
//  OrderExpenseUnFinishViewController.swift
//  YOJP
//
//  Created by PayBay on 16/1/19.
//  Copyright © 2016年 PayBay. All rights reserved.
//

import UIKit

class OrderExpenseUnFinishViewController: UIViewController {
    
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
        backBtn.addTarget(self, action: #selector(OrderExpenseUnFinishViewController.backClicked), forControlEvents: UIControlEvents.TouchUpInside)
        backBtn.opaque = true
        self.customNavigationBar.addSubview(backBtn)
        self.view.addSubview(self.customNavigationBar)
        
    }
    
    func creatScrollView() {
        self.scrollView = UIScrollView(frame: CGRectMake(0,0,screenWidth,screenHeight-44))
        self.scrollView.contentSize = CGSizeMake(0, screenHeight+300)
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false
        self.view.addSubview(self.scrollView)
        
        let storeLabel : UILabel = UILabel()
        storeLabel.text = "商家名称"
        storeLabel.textColor = yojpText
        storeLabel.font = font20
        storeLabel.textAlignment = .Center
        storeLabel.bounds = CGRectMake(0, 0, 200, 25)
        storeLabel.center = CGPointMake(screenWidth/2, 60)
        self.scrollView.addSubview(storeLabel)
        
        let barcodeBackImageView : UIImageView = UIImageView(image: UIImage(named: "2DBarcode"))
        barcodeBackImageView.center = CGPointMake(screenWidth/2, 100+100)
        barcodeBackImageView.bounds = CGRectMake(0, 0, 200, 200)
        self.scrollView.addSubview(barcodeBackImageView)
        
        let codeLabel : UILabel = UILabel(frame: CGRectMake(barcodeBackImageView.frame.origin.x,barcodeBackImageView.frame.origin.y+barcodeBackImageView.frame.size.height + 10,200,35))
        codeLabel.text = "JP1C2015N11Y26R17"
        codeLabel.textAlignment = .Center
        codeLabel.textColor = yojpText
        codeLabel.font = font15
        self.scrollView.addSubview(codeLabel)
        
        let tipLabel1 : UILabel = UILabel(frame: CGRectMake(barcodeBackImageView.frame.origin.x,codeLabel.frame.origin.y+codeLabel.frame.size.height ,200,35))
        tipLabel1.text = "商家扫码验证后取货"
        tipLabel1.textAlignment = .Center
        tipLabel1.textColor = yojpText
        tipLabel1.font = font15
        self.scrollView.addSubview(tipLabel1)
        
        
        let payMoneyLabel : UILabel = UILabel(frame: CGRectMake(16,tipLabel1.frame.origin.y+tipLabel1.frame.size.height + 20,200,20))
        payMoneyLabel.text = "订单金额：¥900(1800日元)"
        payMoneyLabel.textColor = yojpText
        payMoneyLabel.font = font14
        self.scrollView.addSubview(payMoneyLabel)
        
        
        let orderNumLabel : UILabel = UILabel(frame: CGRectMake(16,payMoneyLabel.frame.origin.y+payMoneyLabel.frame.size.height + 4,200,20))
        orderNumLabel.text = "订单号码：JP2000000000000"
        orderNumLabel.textColor = yojpText
        orderNumLabel.font = font14
        self.scrollView.addSubview(orderNumLabel)
        
        let payTimeLabel : UILabel =  UILabel(frame: CGRectMake(16,orderNumLabel.frame.origin.y+orderNumLabel.frame.size.height + 8,200,20))
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
        
        let lineImageView1 = UIImageView(frame: CGRectMake(0, view.frame.origin.y + view.frame.size.height + 10, screenWidth-32, 1))
        lineImageView1.image = UIImage(named: "dashedLine")
        self.scrollView.addSubview(lineImageView1)
        
        let label1 : UILabel = UILabel(frame: CGRectMake(0,lineImageView1.frame.origin.y + 10,screenWidth/4,25))
        label1.text = "编码/品名"
        label1.textAlignment = .Center
        label1.textColor = yojpText
        label1.font = font15
        label1.opaque = true
        self.scrollView.addSubview(label1)
        
        let label2 : UILabel = UILabel(frame: CGRectMake(screenWidth/4,lineImageView1.frame.origin.y + 10,screenWidth/4,25))
        label2.text = "数量"
        label2.textAlignment = .Center
        label2.textColor = yojpText
        label2.font = font15
        label2.opaque = true
        self.scrollView.addSubview(label2)
        
        let label3 : UILabel = UILabel(frame: CGRectMake(screenWidth/2,lineImageView1.frame.origin.y + 10,screenWidth/4,25))
        label3.text = "单价"
        label3.textAlignment = .Center
        label3.textColor = yojpText
        label3.font = font15
        label3.opaque = true
        self.scrollView.addSubview(label3)
        
        let label4 : UILabel = UILabel(frame: CGRectMake(screenWidth/4*3,lineImageView1.frame.origin.y + 10,screenWidth/4,25))
        label4.text = "金额"
        label4.textAlignment = .Center
        label4.textColor = yojpText
        label4.font = font15
        label4.opaque = true
        self.scrollView.addSubview(label4)
        
        let lineImageView2 = UIImageView(frame: CGRectMake(0, label4.frame.origin.y + label4.frame.size.height + 10, screenWidth-32, 1))
        lineImageView2.image = UIImage(named: "dashedLine")
        lineImageView2.opaque = true
        self.scrollView.addSubview(lineImageView2)
        
        
        for i in 0...4 {
            let label1 : UILabel = UILabel(frame: CGRectMake(0,lineImageView2.frame.origin.y + lineImageView2.frame.size.height+10 + CGFloat(35*i),screenWidth/4,25))
            label1.text = "某某某某"
            label1.textAlignment = .Center
            label1.textColor = yojpText
            label1.font = font15
            label1.opaque = true
            self.scrollView.addSubview(label1)
            
            let label2 : UILabel = UILabel(frame: CGRectMake(screenWidth/4,lineImageView2.frame.origin.y + lineImageView2.frame.size.height+10 + CGFloat(35*i),screenWidth/4,25))
            label2.text = "1"
            label2.textAlignment = .Center
            label2.textColor = yojpText
            label2.font = font15
            label2.opaque = true
            self.scrollView.addSubview(label2)
            
            let label3 : UILabel = UILabel(frame: CGRectMake(screenWidth/2,lineImageView2.frame.origin.y + lineImageView2.frame.size.height+10 + CGFloat(35*i),screenWidth/4,25))
            label3.text = "单价"
            label3.textAlignment = .Center
            label3.textColor = yojpText
            label3.font = font15
            label3.opaque = true
            self.scrollView.addSubview(label3)
            
            let label4 : UILabel = UILabel(frame: CGRectMake(screenWidth*3/4,lineImageView2.frame.origin.y + lineImageView2.frame.size.height+10 + CGFloat(35*i),screenWidth/4,25))
            label4.text = "金额"
            label4.textAlignment = .Center
            label4.textColor = yojpText
            label4.font = font15
            label4.opaque = true
            self.scrollView.addSubview(label4)
        }
        
        let lineImageView3 = UIImageView(frame: CGRectMake(0, lineImageView2.frame.origin.y + lineImageView2.frame.size.height+10+45*4+10, screenWidth-32, 1))
        lineImageView3.image = UIImage(named: "dashedLine")
        lineImageView3.opaque = true
        self.scrollView.addSubview(lineImageView3)
        
        let moneyLabel : UILabel = UILabel(frame: CGRectMake(32,lineImageView3.frame.origin.y + lineImageView3.frame.size.height + 10 , 300,25))
        moneyLabel.text = "订单金额:￥900(1800日元)"
        moneyLabel.textColor = yojpText
        moneyLabel.font = font16
        moneyLabel.opaque = true
        self.scrollView.addSubview(moneyLabel)
        
        let tipLabel2 : UILabel = UILabel(frame: CGRectMake(screenWidth-250,moneyLabel.frame.origin.y + moneyLabel.frame.size.height,234,25))
        tipLabel2.text = "(在线支付参考金额)"
        tipLabel2.textColor = yojpText
        tipLabel2.font = font14
        tipLabel2.textAlignment = .Right
        self.scrollView.addSubview(tipLabel2)
        
        let view1 : UIView = UIView(frame: CGRectMake(0,tipLabel1.frame.origin.y + tipLabel1.frame.size.height + 5,screenWidth,60))
        view1.backgroundColor = yojpTableViewColor
        self.scrollView.addSubview(view1)
        
        let creditCardLabel : UILabel = UILabel(frame: CGRectMake(32, 5,screenWidth-32,25))
        creditCardLabel.text = "信用卡支付参考金额：¥950（1800日元）"
        creditCardLabel.textColor = yojpText
        creditCardLabel.font = font14
        creditCardLabel.opaque = true
        view1.addSubview(creditCardLabel)
        
        let depositCardLabel : UILabel = UILabel(frame: CGRectMake(32,35,screenWidth-32,25))
        depositCardLabel.text = "储蓄卡支付参考金额：¥940（1800日元）"
        depositCardLabel.textColor = yojpText
        depositCardLabel.font = font14
        depositCardLabel.opaque = true
        view1.addSubview(depositCardLabel)
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
