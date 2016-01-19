//
//  CardListViewController.swift
//  YOJP
//
//  Created by PayBay on 15/12/1.
//  Copyright © 2015年 PayBay. All rights reserved.
//

import UIKit

class CardListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var customNavigationBar : UIView!
    
    var tableView : UITableView!
    var tableViewDataArray1 : NSMutableArray = ["免费券","八五折-打折券","100元-抵扣券","888元-福袋","九折-打折券","500元-抵扣券","免费券","八五折-打折券","100元-抵扣券","888元-福袋","九折-打折券","500元-抵扣券"]
    
    
    var scanView : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = yojpTableViewColor
        
        
        self.creatCustomNavigationBar()
        self.creatScanView()
        self.creatTableView()
        
        
        // Do any additional setup after loading the view.
    }
    
//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        UIApplication.sharedApplication().statusBarStyle = .LightContent
//        self.navigationController?.navigationBarHidden = true
//    }
//    
//    override func viewWillDisappear(animated: Bool) {
//        super.viewWillDisappear(animated)
//        self.navigationController?.navigationBarHidden = false
//    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.sharedApplication().statusBarStyle = .LightContent
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
    
    func creatScanView() {
        self.scanView = UIView(frame: CGRectMake(0,0,screenWidth,140))
        self.scanView.backgroundColor = yojpBlue
        self.view.addSubview(self.scanView)
        
        
        let barcodeBtn : UIButton = UIButton(type: .Custom)
        barcodeBtn.bounds = CGRectMake(0, 0, 60, 60)
        barcodeBtn.center = CGPointMake(screenWidth/2-80, 70)
        barcodeBtn.setBackgroundImage(UIImage(named: "2DBarcodeWhite"), forState: .Normal)
        barcodeBtn.setBackgroundImage(UIImage(named: "2DBarcodeWhite"), forState: .Highlighted)
        barcodeBtn.addTarget(self, action: Selector("barcodeBtnPressed"), forControlEvents: .TouchUpInside)
        barcodeBtn.opaque = true
        self.scanView.addSubview(barcodeBtn)
        
        let barcodeLabel : UILabel = UILabel()
        barcodeLabel.text = "条码付款"
        barcodeLabel.textAlignment = .Center
        barcodeLabel.textColor = UIColor.whiteColor()
        barcodeLabel.opaque = true
        barcodeLabel.sizeToFit()
        barcodeLabel.center = CGPointMake(screenWidth/2-80, 120)
        self.scanView.addSubview(barcodeLabel)

        
        let shopCarBtn : UIButton = UIButton(type: .Custom)
        shopCarBtn.bounds = CGRectMake(0, 0, 60, 60)
        shopCarBtn.center = CGPointMake(screenWidth/2+80, 70)
        shopCarBtn.setBackgroundImage(UIImage(named: "shopCar"), forState: .Normal)
        shopCarBtn.setBackgroundImage(UIImage(named: "shopCar"), forState: .Highlighted)
        shopCarBtn.backgroundColor = yojpBlue
        shopCarBtn.opaque = true
        shopCarBtn.addTarget(self, action: Selector("shopCarBtnPressed"), forControlEvents: .TouchUpInside)
        self.scanView.addSubview(shopCarBtn)
        
        
        let shopCarLabel : UILabel = UILabel()
        shopCarLabel.text = "购物车"
        shopCarLabel.textAlignment = .Center
        shopCarLabel.textColor = UIColor.whiteColor()
        shopCarLabel.sizeToFit()
        shopCarLabel.center = CGPointMake(screenWidth/2+80, 120)
        shopCarLabel.backgroundColor = yojpBlue
        shopCarLabel.opaque = true
        self.scanView.addSubview(shopCarLabel)
        
    }

    func creatTableView() {
        self.tableView = UITableView(frame: CGRectMake(0, 140, screenWidth, screenHeight-44-140), style: .Plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .None
        self.view.addSubview(self.tableView)
        
    }

    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 12
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 90
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        tableView.registerNib(UINib(nibName: "CardListTableViewCell", bundle: nil), forCellReuseIdentifier: "CardListTableViewCellId")
        let cell = tableView.dequeueReusableCellWithIdentifier("CardListTableViewCellId", forIndexPath: indexPath) as! CardListTableViewCell
        
        cell.selectionStyle = .None
        cell.backgroundColor = yojpTableViewColor
        
        cell.barcodeImagwView.image = UIImage(named: "2DBarcode")
        cell.ticketTypeLabel.text = self.tableViewDataArray1[indexPath.row] as? String
        cell.validityLabel.text = "2015.11.11-2016.11.10"
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.navigationController?.pushViewController(CardDetailsViewController(), animated: true)
    }

    
    func shopCarBtnPressed() {
        self.navigationController?.pushViewController(ShopCarListViewController(), animated: true)
    }
    
    func barcodeBtnPressed() {
        self.navigationController?.pushViewController(BarcodePayViewController(), animated: true)
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
