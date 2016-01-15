//
//  UserCentreViewController.swift
//  YOJP
//
//  Created by PayBay on 15/12/7.
//  Copyright © 2015年 PayBay. All rights reserved.
//

import UIKit

class UserCentreViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var customNavigationBar : UIView!
    
    var tableView : UITableView!
    var tableViewDataArray1 : NSMutableArray = ["积分","资料完善","帮助中心","常用设置"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        self.creatCustomNavigationBar()
        self.creatTableView()
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.sharedApplication().statusBarStyle = .Default
        self.navigationController?.navigationBarHidden = true
        
        self.tableView.reloadData()
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
        backBtn.opaque = true
        self.customNavigationBar.addSubview(backBtn)
        self.view.addSubview(self.customNavigationBar)
        
    }
    
    func creatTableView() {
        self.tableView = UITableView(frame: CGRectMake(0, 0, screenWidth, screenHeight-44), style: .Plain)
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = yojpTableViewColor
        self.tableView.tableFooterView = UIView()
        //self.tableView.separatorStyle = .None
        
        self.view.addSubview(self.tableView)
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1+self.tableViewDataArray1.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return indexPath.section == 0 ? 200 : 44
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return section == 4 || section == 0 ? 0 : section == 2 || section == 3 ? 2 : 8
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
            
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            for view in cell.subviews {
                view.removeFromSuperview()
            }
            
            
            let imageView : UIImageView = UIImageView(frame: CGRectMake(0, 0, screenWidth, 200))
            imageView.image = UIImage(named: "userCenterBack")
            imageView.opaque = true
            cell.addSubview(imageView)
            
            if CurrentUser.user == nil {
                
                let label : UILabel = UILabel()
                label.bounds = CGRectMake(0, 0, 200, 25)
                label.center = CGPointMake(screenWidth/2, 90)
                label.textAlignment = .Center
                label.text = "还没有登录哦"
                label.textColor = yojpText
                label.font = font15
                label.opaque = true
                cell.addSubview(label)
                
                let loginBtn : UIButton = UIButton()
                loginBtn.center = CGPointMake(screenWidth/3, 170)
                loginBtn.bounds = CGRectMake(0, 0, 100, 30)
                loginBtn.setTitle("登录", forState: .Normal)
                loginBtn.setTitleColor(yojpText, forState: .Normal)
                loginBtn.titleLabel?.font = font15
                loginBtn.addTarget(self, action: Selector("loginBtnPressed"), forControlEvents: .TouchUpInside)
                loginBtn.opaque = true
                cell.addSubview(loginBtn)
                
                let registerBtn : UIButton = UIButton()
                registerBtn.center = CGPointMake(screenWidth/3*2, 170)
                registerBtn.bounds = CGRectMake(0, 0, 100, 30)
                registerBtn.setTitle("注册", forState: .Normal)
                registerBtn.setTitleColor(yojpText, forState: .Normal)
                registerBtn.titleLabel?.font = font15
                registerBtn.addTarget(self, action: Selector("registerBtnPressed"), forControlEvents: .TouchUpInside)
                registerBtn.opaque = true
                cell.addSubview(registerBtn)

            }
            
            else {
                
                let label : UILabel = UILabel()
                label.bounds = CGRectMake(0, 0, 200, 25)
                label.center = CGPointMake(screenWidth/2, 120)
                label.textAlignment = .Center
                label.text = String(format: "用户账号:%@", (CurrentUser.user?.userId)!)
                label.textColor = yojpText
                label.font = font15
                label.opaque = true
                cell.addSubview(label)
            }
            
            return cell

        }
        else {
            tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
            
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            cell.textLabel?.text = self.tableViewDataArray1[indexPath.section-1] as? String
            cell.textLabel?.font = font15
            cell.textLabel?.textColor = yojpText
            cell.textLabel?.opaque = true
            cell.layoutSubviews()
            
            return cell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.section == 1 {
            self.navigationController?.pushViewController(IntegralViewController(), animated: true)
        }
        else if indexPath.section == 2 {
            self.navigationController?.pushViewController(InformationViewController(), animated: true)
        }
        else if indexPath.section == 3 {
            self.navigationController?.pushViewController(HelpCenterViewController(), animated: true)
        }
        else if indexPath.section == 4 {
            self.navigationController?.pushViewController(SettingViewController(), animated: true)
        }
    }
    
    func backClicked() {
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    func loginBtnPressed() {
        self.presentViewController(LoginViewController(), animated: true) { () -> Void in
            
        }
    }
    func registerBtnPressed() {
        self.presentViewController(RegisterViewController(), animated: true) { () -> Void in
            
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
