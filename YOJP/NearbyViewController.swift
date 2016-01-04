//
//  NearbyViewController.swift
//  YOJP
//
//  Created by PayBay on 15/12/24.
//  Copyright © 2015年 PayBay. All rights reserved.
//

import UIKit

class NearbyViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    var customNavigationBar : UIView!
    
    var tableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = yojpTableViewColor
        
        self.creatCustomNavigationBar()
        self.creatTableView()
        
        // Do any additional setup after loading the view.
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
        self.tableView.backgroundColor = yojpTableViewColor
        self.tableView.tableFooterView = UIView()
        self.view.addSubview(self.tableView)
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 8
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 150
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 8
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cellId")
        let cell = tableView.dequeueReusableCellWithIdentifier("cellId", forIndexPath: indexPath) as UITableViewCell
        
        cell.selectionStyle = .None
        
        cell.textLabel?.text = String(format: "商家%d", indexPath.section)
        cell.textLabel?.textColor = yojpText
        
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
