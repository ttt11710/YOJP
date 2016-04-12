//
//  MoreStoresViewController.swift
//  YOJP
//
//  Created by PayBay on 16/1/8.
//  Copyright © 2016年 PayBay. All rights reserved.
//

import UIKit

class MoreStoresViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    
    var customNavigationBar : UIView!
    
    var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.creatTableView()
        self.creatCustomNavigationBar()
        
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
        backBtn.addTarget(self, action: #selector(MoreStoresViewController.backClicked), forControlEvents: UIControlEvents.TouchUpInside)
        backBtn.opaque = true
        self.customNavigationBar.addSubview(backBtn)
        self.view.addSubview(self.customNavigationBar)
    }


    func creatTableView() {
        self.tableView = UITableView(frame: CGRectMake(0, 0, screenWidth, screenHeight-44+8), style: .Plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = yojpTableViewColor
        self.tableView.tableFooterView = UIView()
        self.view.addSubview(self.tableView)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  10
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let label : UILabel = UILabel(frame: CGRectMake(0,0,screenWidth-48,30))
        label.font = font16
        label.textColor = yojpText
        label.text = "日本最大的药妆品牌连锁店，店铺面积多少，拥有药妆品牌店铺优惠活动、优惠券"
        label.numberOfLines = 0
        label.sizeToFit()
        
        return indexPath.row % 2 == 0 ? 31 : 8 + label.frame.size.height + 8 + 4
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        for view in cell.subviews {
            view.removeFromSuperview()
        }
        
        if indexPath.row % 2 == 0 {
            let label : UILabel = UILabel(frame: CGRectMake(8,5,screenWidth,20))
            label.center.y = 15
            label.text = String(format: "商家%d:某某街某某路某某号 东京店   %d00米", (indexPath.row+1)/2+1,(indexPath.row+1)/2+1)
            label.font = font14
            label.textColor = yojpText
            label.opaque = true
            cell.addSubview(label)
            
            let imageView : UIImageView = UIImageView(frame: CGRectMake(0, 30, screenWidth, 1))
            imageView.image = UIImage(named: "dashedLine")
            imageView.opaque = true
            cell.addSubview(imageView)
            
        }
        else if indexPath.row % 2 == 1 {
            let label : UILabel = UILabel(frame: CGRectMake(16,8,screenWidth-32,30))
            label.font = font15
            label.textColor = yojpText
            label.text = "     日本最大的药妆品牌连锁店，店铺面积多少，拥有药妆品牌店铺优惠活动、优惠券"
            label.numberOfLines = 0
            label.sizeToFit()
            label.opaque = true
            cell.addSubview(label)
            
            let view : UIView = UIView(frame: CGRectMake(0,label.frame.origin.y + label.frame.size.height + 8,screenWidth,8))
            view.backgroundColor = yojpTableViewColor
            cell.addSubview(view)
        }
        
        
        return cell
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
