//
//  ScanProductDetailViewController.swift
//  YOJP
//
//  Created by PayBay on 16/1/4.
//  Copyright © 2016年 PayBay. All rights reserved.
//

import UIKit

class ScanProductDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    var customNavigationBar : UIView!
    var tableView : UITableView!
    
    var collectionBtn : MCFireworksButton!
    var collectionSelect : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        
        self.creatCustomNavigationBar()
        self.creatTableView()
        
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
        backBtn.opaque = true
        self.customNavigationBar.addSubview(backBtn)
        
        
        let translateBtn : UIButton = UIButton(frame: CGRectMake(screenWidth-80,7,80,30))
        translateBtn.setTitle("翻译", forState: .Normal)
        translateBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        translateBtn.setTitleColor(UIColor.whiteColor(), forState: .Highlighted)
        translateBtn.backgroundColor = yojpBlue
        translateBtn.addTarget(self, action: Selector("translateBtnPressed"), forControlEvents: .TouchUpInside)
        self.customNavigationBar.addSubview(translateBtn)
        
        self.view.addSubview(self.customNavigationBar)
        
    }

    
    func backClicked() {
        
        self.navigationController?.popViewControllerAnimated(true)
    }
    

    func creatTableView() {
        tableView = UITableView(frame: CGRectMake(0, 20, screenWidth, screenHeight-20-44))
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = yojpTableViewColor
        tableView.tableFooterView = UIView(frame: CGRectMake(0,0,screenWidth,100))
        
        self.view.addSubview(tableView)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 3 : 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return 200
        }
        else if indexPath.section == 1 {
            let label : UILabel = UILabel(frame: CGRectMake(0,0,screenWidth-32,30))
            label.font = font16
            label.textColor = yojpText
            label.text = "产品简介:\n    当你能飞的时候，就不要放弃飞;当你能梦的时候，就不要放弃梦。世界没有尽头，只要心中还有追求。人生真正的终点是希望的终结。苍鹰的骄傲是飞翔的双翼，人生的意义是不断的追求。"
            label.numberOfLines = 0
            label.sizeToFit()
            return 16+label.frame.size.height + 16
        }
        else {
            return 44
        }
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            if indexPath.row == 0 {
                tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
                let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
                cell.selectionStyle = UITableViewCellSelectionStyle.None
                
                let imageView : UIImageView = UIImageView(frame: CGRectMake(0,0,screenWidth,200))
                imageView.image = UIImage(named: "image5")
                cell.addSubview(imageView)
                
                let label : UILabel = UILabel(frame: CGRectMake(16,170,184,30))
                label.font = font16
                label.textColor = yojpText
                label.text = "库存量:50件"
                cell.addSubview(label)
            
                self.collectionBtn = MCFireworksButton(frame: CGRectMake(screenWidth-41, 170, 25, 25))
                self.collectionBtn.particleImage = UIImage(named: "spark")
                self.collectionBtn.particleScale = 0.05
                self.collectionBtn.particleScaleRange = 0.02
                self.collectionBtn.selected = self.collectionSelect
                
                self.collectionBtn.setImage(UIImage(named: "collectionWhite"), forState: .Normal)
                self.collectionBtn.setImage(UIImage(named: "collectionWhite"), forState: .Highlighted)
                
                if self.collectionBtn.selected {
                    self.collectionBtn.popOutsideWithDuration(0.5)
                    self.collectionBtn.setImage(UIImage(named: "collectionGolden"), forState: .Normal)
                    self.collectionBtn.animate()
                    self.collectionBtn.setImage(UIImage(named: "collectionGolden"), forState: .Highlighted)
                }
                else {
                    self.collectionBtn.popInsideWithDuration(0.4)
                    self.collectionBtn.setImage(UIImage(named: "collectionWhite"), forState: .Normal)
                    self.collectionBtn.setImage(UIImage(named: "collectionWhite"), forState: .Highlighted)
                }
                
                self.collectionBtn.addTarget(self, action: Selector("collectionClicked:"), forControlEvents: UIControlEvents.TouchUpInside)
                cell.addSubview(self.collectionBtn)
                
                return cell
                
            }
            else if indexPath.row == 1 {
                
                tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
                let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
                cell.selectionStyle = UITableViewCellSelectionStyle.None
                
                cell.textLabel?.text = "产品名称"
                cell.textLabel?.textColor = yojpText
                cell.textLabel?.font = font16
                
                return cell
            }
            else {
                tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
                let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
                cell.selectionStyle = UITableViewCellSelectionStyle.None
                
                cell.textLabel?.text = "产品单价"
                cell.textLabel?.textColor = yojpText
                cell.textLabel?.font = font16
                
                return cell
            }
        }
        else {
            
            tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            let label : UILabel = UILabel(frame: CGRectMake(16,16,screenWidth-32,30))
            label.font = font16
            label.textColor = yojpText
            label.text = "产品简介:\n    当你能飞的时候，就不要放弃飞;当你能梦的时候，就不要放弃梦。世界没有尽头，只要心中还有追求。人生真正的终点是希望的终结。苍鹰的骄傲是飞翔的双翼，人生的意义是不断的追求。"
            label.numberOfLines = 0
            label.sizeToFit()
            cell.addSubview(label)
            
            return cell
        }
    }
    
    func translateBtnPressed() {
        SVProgressShow.showInfoWithStatus("一键翻译等后台数据出来后实现")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    func collectionClicked(sender : UIButton) {
        sender.selected = !sender.selected
        self.collectionSelect = sender.selected
        if sender.selected {
            self.collectionBtn.popOutsideWithDuration(0.5)
            self.collectionBtn.setImage(UIImage(named: "collectionGolden"), forState: .Normal)
            self.collectionBtn.animate()
            self.collectionBtn.setImage(UIImage(named: "collectionGolden"), forState: .Highlighted)
            
            SVProgressShow.showSuccessWithStatus("收藏成功!")
        }
        else {
            self.collectionBtn.popInsideWithDuration(0.4)
            self.collectionBtn.setImage(UIImage(named: "collectionWhite"), forState: .Normal)
            self.collectionBtn.setImage(UIImage(named: "collectionWhite"), forState: .Highlighted)
        }
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
