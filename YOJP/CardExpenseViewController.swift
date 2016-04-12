//
//  CardExpenseViewController.swift
//  YOJP
//
//  Created by PayBay on 16/1/13.
//  Copyright © 2016年 PayBay. All rights reserved.
//

import UIKit

class CardExpenseViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var tableView : UITableView!
    var customNavigationBar : UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = yojpTableViewColor
        
        self.creatCustomNavigationBar()
        self.creatTableView()
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
        backBtn.addTarget(self, action: #selector(CardExpenseViewController.backClicked), forControlEvents: UIControlEvents.TouchUpInside)
        backBtn.opaque = true
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
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return indexPath.row == 0 ? 450 : 100
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            let storeNameLabel : UILabel = UILabel(frame: CGRectMake(8,20,200,30))
            storeNameLabel.text = "某某品牌"
            storeNameLabel.textColor = yojpText
            storeNameLabel.opaque = true
            
            let cardBackView : UIView = UIView(frame: CGRectMake(16,storeNameLabel.frame.origin.y+storeNameLabel.frame.size.height + 8,screenWidth-32,380))
            cardBackView.backgroundColor = UIColor(red: 200.0/255.0, green: 200.0/255.0, blue: 200.0/255.0, alpha: 1)
            
            
            let ticketTypeLabel : UILabel = UILabel(frame: CGRectMake(20,20,150,30))
            ticketTypeLabel.text = "打折券"
            ticketTypeLabel.textColor = yojpText
            ticketTypeLabel.font = font15
            ticketTypeLabel.opaque = true
            cardBackView.addSubview(ticketTypeLabel)
            
            
            
            let validityLabel : UILabel = UILabel(frame: CGRectMake(screenWidth-16-200,20,200,50))
            validityLabel.text = "有效期:\n2015.11.11-2015.12.11"
            validityLabel.font = font14
            validityLabel.textColor = yojpText
            validityLabel.numberOfLines = 2
            validityLabel.sizeToFit()
            validityLabel.opaque = true
            validityLabel.frame = CGRectMake(cardBackView.frame.size.width-16-validityLabel.frame.size.width, 70-validityLabel.frame.size.height-8, validityLabel.frame.size.width, validityLabel.frame.size.height)
            cardBackView.addSubview(validityLabel)
            
            
            let barcodeBackView : UIView = UIView(frame: CGRectMake(0,70,cardBackView.frame.size.width,310))
            barcodeBackView.backgroundColor = UIColor.whiteColor()
            cardBackView.addSubview(barcodeBackView)
            
            let barcodeBackImageView : UIImageView = UIImageView(image: UIImage(named: "2DBarcode"))
            barcodeBackImageView.center = CGPointMake(barcodeBackView.frame.size.width/2, barcodeBackView.center.y)
            barcodeBackImageView.bounds = CGRectMake(0, 0, 150, 150)
            barcodeBackImageView.opaque = true
            cardBackView.addSubview(barcodeBackImageView)
            
            
            let barcodeLabel : UILabel = UILabel()
            barcodeLabel.text = "JP1C2015N11Y26R17"
            barcodeLabel.textAlignment = .Center
            barcodeLabel.textColor = yojpText
            barcodeLabel.font = font15
            barcodeLabel.center = CGPointMake(barcodeBackImageView.center.x, barcodeBackImageView.center.y + barcodeBackImageView.frame.size.height/2+15)
            barcodeLabel.bounds = CGRectMake(0, 0, 200, 30)
            barcodeLabel.opaque = true
            cardBackView.addSubview(barcodeLabel)
            
            let warmPrompt : UILabel = UILabel()
            warmPrompt.text = "请在店铺收银员的指导下使用"
            warmPrompt.textAlignment = .Center
            warmPrompt.textColor = yojpText
            warmPrompt.font = font15
            warmPrompt.center = CGPointMake(barcodeLabel.center.x, barcodeLabel.center.y + barcodeLabel.frame.size.height/2+10)
            warmPrompt.bounds = CGRectMake(0, 0, screenWidth, 30)
            warmPrompt.opaque = true
            cardBackView.addSubview(warmPrompt)
            
            
            cell.backgroundColor = yojpTableViewColor
            cell.contentView.addSubview(storeNameLabel)
            cell.contentView.addSubview(cardBackView)
            
            return cell
            
        }
        else {
            tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            
            cell.backgroundColor = yojpTableViewColor
            
            let lineImageView1 = UIImageView(frame: CGRectMake(0, 0, screenWidth-32, 1))
            lineImageView1.image = UIImage(named: "dashedLine")
            cell.addSubview(lineImageView1)
            
            cell.textLabel?.numberOfLines = 2
            cell.textLabel?.text = "消费时间：2016-01-08  10:59\n商家地址：某某某某某某某某某某某某某"
            cell.textLabel?.font = font15
            cell.textLabel?.textColor = yojpText
            cell.textLabel?.sizeToFit()
            cell.textLabel?.opaque = true
            
            let lineImageView2 = UIImageView(frame: CGRectMake(0, 99, screenWidth-32, 1))
            lineImageView2.image = UIImage(named: "dashedLine")
            cell.addSubview(lineImageView2)
            lineImageView2.opaque = true
            
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
