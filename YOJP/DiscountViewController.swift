//
//  DiscountViewController.swift
//  YOJP
//
//  Created by PayBay on 16/1/13.
//  Copyright © 2016年 PayBay. All rights reserved.
//

import UIKit

class DiscountViewController: UIViewController, UITableViewDelegate,UITableViewDataSource {
    
    
    
    var tableView : UITableView!
    
    var showChoose : Bool = false
    var showSubChoose : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.creatTableView()
        // Do any additional setup after loading the view.
    }
    
    func creatTableView() {
        
        self.tableView = UITableView(frame: CGRectMake(0, 0, screenWidth, screenHeight), style: .Plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = yojpTableViewColor
        self.view.addSubview(self.tableView)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 2 : 10
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view : UIView = UIView(frame: CGRectMake(0,0,screenWidth,25))
        view.backgroundColor = yojpTableViewColor
        
        let viewWidth = (screenWidth-48-20)/4
        for i in 0..<4{
            let chooseTypeBtn : CallBackButton = CallBackButton(frame: CGRectMake(4*CGFloat(i%4+1)+CGFloat(i%4)*viewWidth,0,viewWidth,30))
            chooseTypeBtn.setTitle(String(format: "商品分类%d", i), forState: .Normal)
            chooseTypeBtn.setTitleColor(yojpText, forState: .Normal)
            chooseTypeBtn.setTitleColor(yojpLightText, forState: .Selected)
            chooseTypeBtn.setupBlock()
            chooseTypeBtn.titleLabel?.font = font14
            chooseTypeBtn.tag = i
            chooseTypeBtn.callBack = { tag in
                print(tag)
                
                for view1 in view.subviews {
                    if view1.isKindOfClass(CallBackButton.classForCoder()) {
                        let chooseTypeBtn : CallBackButton = view1 as! CallBackButton
                        chooseTypeBtn.selected = false
                    }
                }
                chooseTypeBtn.selected = true
            }
            view.addSubview(chooseTypeBtn)
        }
        
        
        let callBtn : CallBackButton = CallBackButton(frame: CGRectMake(screenWidth-48,0,48,30))
        callBtn.setImage(UIImage(named: "下拉箭头"), forState: .Normal)
        callBtn.setupBlock()
        callBtn.backgroundColor = UIColor.whiteColor()
        callBtn.callBack = { tag in
            self.showChoose = !self.showChoose
            self.tableView.reloadData()
        }
        view.addSubview(callBtn)
        
        if self.showChoose && !self.showSubChoose {
            
            let label : UILabel = UILabel(frame: CGRectMake(0,0,screenWidth-48,30))
            label.text = "切换选项"
            label.backgroundColor = yojpTableViewColor
            label.textColor = yojpLightText
            view.addSubview(label)
            
            let typeView : UIView = UIView(frame: CGRectMake(0,30,screenWidth,3+3*30))
            view.addSubview(typeView)
            
            let viewWidth = (screenWidth-5)/4
            
            for i in 0..<12{
                let chooseTypeBtn : CallBackButton = CallBackButton(frame: CGRectMake(1*CGFloat(i%4+1)+CGFloat(i%4)*viewWidth,1*CGFloat(i/4+1)+CGFloat(i/4)*30,viewWidth,30))
                chooseTypeBtn.setTitle(String(format: "商品分类%d", i), forState: .Normal)
                chooseTypeBtn.setTitleColor(yojpLightText, forState: .Normal)
                chooseTypeBtn.backgroundColor = UIColor.whiteColor()
                chooseTypeBtn.setupBlock()
                chooseTypeBtn.titleLabel?.font = font15
                chooseTypeBtn.tag = i
                chooseTypeBtn.callBack = { tag in
                    print(tag)
                    self.showSubChoose = true
                    self.tableView.reloadData()
                }
                typeView.addSubview(chooseTypeBtn)
            }
        }
        
        if self.showChoose && self.showSubChoose {
            
            let label : UILabel = UILabel(frame: CGRectMake(0,0,screenWidth,30))
            label.text = "切换选项"
            label.backgroundColor = yojpTableViewColor
            label.textColor = yojpLightText
            view.addSubview(label)
            
            let typeView : UIView = UIView(frame: CGRectMake(0,30,screenWidth,3+2*30))
            view.addSubview(typeView)
            
            let viewWidth = (screenWidth-4)/3
            
            for i in 0..<6{
                let chooseTypeBtn : CallBackButton = CallBackButton(frame: CGRectMake(1*CGFloat(i%3+1)+CGFloat(i%3)*viewWidth,1*CGFloat(i/3+1)+CGFloat(i/3)*30,viewWidth,30))
                chooseTypeBtn.setTitle(String(format: "子分类%d", i), forState: .Normal)
                chooseTypeBtn.setTitleColor(yojpLightText, forState: .Normal)
                chooseTypeBtn.backgroundColor = UIColor.whiteColor()
                chooseTypeBtn.setupBlock()
                chooseTypeBtn.titleLabel?.font = font15
                chooseTypeBtn.tag = i
                chooseTypeBtn.callBack = { tag in
                    print(tag)
                    self.showChoose = false
                    self.showSubChoose = false
                    self.tableView.reloadData()
                }
                typeView.addSubview(chooseTypeBtn)
            }
        }
        return view
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return indexPath.row == 0 ? 100 : 30
        }
        else {
            return 140
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 {
            return 0
        }
        else {
            return self.showChoose == false ? 30 : self.showSubChoose == false ? 125 : 95
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
                
                for view in cell.contentView.subviews {
                    view.removeFromSuperview()
                }
                
                let imageView : UIImageView = UIImageView(frame: CGRectMake(0,0,screenWidth,100))
                imageView.image = UIImage(named: "打折券banner")
                cell.contentView.addSubview(imageView)
                return cell
            }
            else {
                tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
                let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
                cell.selectionStyle = UITableViewCellSelectionStyle.None
                cell.accessoryType = .DisclosureIndicator
                for view in cell.contentView.subviews {
                    view.removeFromSuperview()
                }
                
                let label : UILabel = UILabel(frame: CGRectMake(0,0,100,30))
                label.text = "头条信息"
                label.textColor = yojpText
                label.font = font15
                cell.contentView.addSubview(label)
                
                let messageLabel : UILabel = UILabel(frame: CGRectMake(label.frame.size.width,0,screenWidth-label.frame.size.width-50,30))
                messageLabel.text = "好吃、好玩头条推荐"
                messageLabel.textColor = yojpText
                messageLabel.font = font15
                cell.contentView.addSubview(messageLabel)
                
                return cell
            }
        }
        else {
            tableView.registerNib(UINib(nibName: "TwoImageViewTableViewCell", bundle: nil), forCellReuseIdentifier: "TwoImageViewTableViewCellId")
            let cell = tableView.dequeueReusableCellWithIdentifier("TwoImageViewTableViewCellId", forIndexPath: indexPath) as! TwoImageViewTableViewCell
            
            cell.selectionStyle = .None
            cell.imageView1.image = UIImage(named: "打折券图片设计")
            cell.imageView2.image = UIImage(named: "打折券图片设计")
            cell.label1.text = "消费越多，省的越多，不信吗！那就睁大眼睛喽"
            cell.label2.text = "消费越多，省的越多，不信吗！那就睁大眼睛喽"
            
            return cell
        }
        
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
