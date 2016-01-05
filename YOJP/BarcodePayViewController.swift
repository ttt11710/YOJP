//
//  BarcodePayViewController.swift
//  YOJP
//
//  Created by PayBay on 16/1/5.
//  Copyright © 2016年 PayBay. All rights reserved.
//

import UIKit

class BarcodePayViewController: UIViewController {

    
    var customNavigationBar : UIView!
    var barcodeView : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = yojpTableViewColor

        self.creatCustomNavigationBar()
        self.creatBarcodeView()
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
    
    func creatBarcodeView() {
        
        self.barcodeView = UIView(frame: CGRectMake(20,20+16,screenWidth-40,screenHeight-20-16-44-100))
        self.barcodeView.backgroundColor = yojpSectionColor
        self.view.addSubview(self.barcodeView)
        
        let customLabel : UILabel = UILabel()
        customLabel.text = "YO! Japan付款码"
        customLabel.textColor = yojpText
        customLabel.textAlignment = .Center
        customLabel.font = font15
        customLabel.bounds = CGRectMake(0, 0, 200, 25)
        customLabel.sizeToFit()
        customLabel.center = CGPointMake(screenWidth/2, 40)
        self.barcodeView.addSubview(customLabel)
        
        let view : UIView = UIView(frame: CGRectMake(0,80,self.barcodeView.frame.size.width,self.barcodeView.frame.size.height-80))
        view.backgroundColor = UIColor.whiteColor()
        self.barcodeView.addSubview(view)
        
        let barcodeImageView : UIImageView = UIImageView(image: UIImage(named: "条形码"))
        barcodeImageView.center = CGPointMake(view.center.x, 90)
        barcodeImageView.bounds = CGRectMake(0, 0, 250, 100)
        view.addSubview(barcodeImageView)
        
        
        let barcode2DImageView : UIImageView = UIImageView(image: UIImage(named: "2DBarcode"))
        barcode2DImageView.center = CGPointMake(view.frame.size.width/2, barcodeImageView.frame.origin.y + barcodeImageView.frame.size.height + 120)
        barcode2DImageView.bounds = CGRectMake(0, 0, 150, 150)
        view.addSubview(barcode2DImageView)
        barcode2DImageView.userInteractionEnabled = true
        let tap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("gotoPayView"))
        barcode2DImageView.addGestureRecognizer(tap)
        
        
        let tipLabel : UILabel = UILabel()
        tipLabel.text = "每分钟自动更新"
        tipLabel.textAlignment = .Center
        tipLabel.textColor = yojpText
        tipLabel.font = font14
        tipLabel.center = CGPointMake(view.frame.size.width/2, barcode2DImageView.frame.origin.y + barcode2DImageView.frame.size.height + 30)
        tipLabel.bounds = CGRectMake(0, 0, 200, 25)
        view.addSubview(tipLabel)
    }
    
    func gotoPayView() {
        self.navigationController?.pushViewController(CardScanPayViewController(), animated: true)
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
