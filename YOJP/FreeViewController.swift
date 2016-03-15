//
//  FreeViewController.swift
//  YOJP
//
//  Created by PayBay on 16/1/13.
//  Copyright © 2016年 PayBay. All rights reserved.
//

import UIKit

class FreeViewController: UIViewController,UICollectionViewDelegateFlowLayout, UITableViewDelegate,UITableViewDataSource {
    
    
    
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
        
        
        let callBtn : CallBackButton = CallBackButton(frame: CGRectMake(screenWidth-80,0,68,30))
        callBtn.setTitle("打开", forState: .Normal)
        callBtn.setTitleColor(yojpBlue, forState: .Normal)
        callBtn.setupBlock()
        callBtn.callBack = { tag in
            self.showChoose = !self.showChoose
            self.tableView.reloadData()
        }
        view.addSubview(callBtn)
        
        if self.showChoose && !self.showSubChoose {
            
            let label : UILabel = UILabel(frame: CGRectMake(0,0,screenWidth,30))
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
        return 50
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        if section == 0 {
            return 0
        }
        else {
            return self.showChoose == false ? 30 : self.showSubChoose == false ? 125 : 95
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        cell.accessoryType = .DisclosureIndicator
        cell.textLabel?.text = "设置备注"
        cell.textLabel?.textColor = yojpText
        cell.textLabel?.font = font15
        return cell
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

