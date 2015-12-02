//
//  CardDetailsViewController.swift
//  YOJP
//
//  Created by PayBay on 15/12/1.
//  Copyright © 2015年 PayBay. All rights reserved.
//

import UIKit

class CardDetailsViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var tableView : UITableView!
    var customNavigationBar : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.creatCustomNavigationBar()
        self.creatTableView()
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
    
    func creatTableView() {
        self.tableView = UITableView(frame: CGRectMake(0, 20, screenWidth, screenHeight-64), style: .Plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        self.view.addSubview(self.tableView)
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return indexPath.row == 0 ? 450 : 44

    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cellId")
            let cell = tableView.dequeueReusableCellWithIdentifier("cellId", forIndexPath: indexPath) as UITableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            let storeNameLabel : UILabel = UILabel(frame: CGRectMake(8,20,200,30))
            storeNameLabel.text = "某某品牌"
            storeNameLabel.textColor = yojpText
            
            let cardBackView : UIView = UIView(frame: CGRectMake(16,storeNameLabel.frame.origin.y+storeNameLabel.frame.size.height + 8,screenWidth-32,380))
            cardBackView.backgroundColor = UIColor(red: 200.0/255.0, green: 200.0/255.0, blue: 200.0/255.0, alpha: 1)
            
            
            let ticketTypeLabel : UILabel = UILabel(frame: CGRectMake(20,20,150,30))
            ticketTypeLabel.text = "打折券"
            ticketTypeLabel.textColor = yojpText
            ticketTypeLabel.font = font15
            cardBackView.addSubview(ticketTypeLabel)
            
            
            
            let validityLabel : UILabel = UILabel(frame: CGRectMake(screenWidth-16-200,30,200,30))
            validityLabel.text = "有效期:2015.11.11-2015.12.11"
            validityLabel.font = font14
            validityLabel.textColor = yojpText
            cardBackView.addSubview(validityLabel)
            
            
            let barcodeBackView : UIView = UIView(frame: CGRectMake(0,70,cardBackView.frame.size.width,310))
            barcodeBackView.backgroundColor = UIColor.whiteColor()
            cardBackView.addSubview(barcodeBackView)
            
            let barcodeBackImageView : UIImageView = UIImageView(image: UIImage(named: "2DBarcode"))
            barcodeBackImageView.center = CGPointMake(barcodeBackView.frame.size.width/2, barcodeBackView.center.y)
            barcodeBackImageView.bounds = CGRectMake(0, 0, 150, 150)
            cardBackView.addSubview(barcodeBackImageView)
            
            
            let barcodeLabel : UILabel = UILabel()
            barcodeLabel.text = "JP1C2015N11Y26R17"
            barcodeLabel.textAlignment = .Center
            barcodeLabel.textColor = yojpText
            barcodeLabel.center = CGPointMake(barcodeBackImageView.center.x, barcodeBackImageView.center.y + barcodeBackImageView.frame.size.height/2+15)
            barcodeLabel.bounds = CGRectMake(0, 0, 200, 30)
            cardBackView.addSubview(barcodeLabel)
            
            let warmPrompt : UILabel = UILabel()
            warmPrompt.text = "请在店铺收银员的指导下使用"
            warmPrompt.textAlignment = .Center
            warmPrompt.textColor = yojpText
            warmPrompt.center = CGPointMake(barcodeLabel.center.x, barcodeLabel.center.y + barcodeLabel.frame.size.height/2+10)
            warmPrompt.bounds = CGRectMake(0, 0, screenWidth, 30)
            cardBackView.addSubview(warmPrompt)
            
            
            cell.backgroundColor = yojpTableViewColor
            cell.contentView.addSubview(storeNameLabel)
            cell.contentView.addSubview(cardBackView)
            
            return cell
            
        }
        else {
            tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cellId")
            let cell = tableView.dequeueReusableCellWithIdentifier("cellId", forIndexPath: indexPath) as UITableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.accessoryType = .DisclosureIndicator
            
            cell.backgroundColor = yojpTableViewColor
            
            cell.textLabel?.text = indexPath.row == 1 ? "打折券详情" : "立即使用"
            
            cell.textLabel?.text = "打折券详情"
            cell.textLabel?.textColor = yojpText
            cell.textLabel?.font = font16
            return cell
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
