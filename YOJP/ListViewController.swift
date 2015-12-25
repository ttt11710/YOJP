//
//  ListViewController.swift
//  YOJP
//
//  Created by PayBay on 15/12/18.
//  Copyright © 2015年 PayBay. All rights reserved.
//

import UIKit

class ListViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    var customNavigationBar : UIView!
    var tableView : UITableView!
    
    var tableViewArray : NSMutableArray = [""]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let imageView : UIImageView = UIImageView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
        imageView.image = UIImage(named: "JapanBack")
        self.view.addSubview(imageView)
        
        self.creatTableView()
        self.creatCustomNavigationBar()
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
        self.tableView = UITableView(frame: CGRectMake((screenHeight-screenWidth)/2, (screenHeight-screenWidth)/2, screenHeight,screenWidth), style: .Plain)
        self.tableView.tableFooterView = UIView()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .None
        self.tableView.backgroundColor = UIColor.clearColor()
        self.view.addSubview(self.tableView)
        
        self.tableView.center = CGPointMake(screenWidth/2, screenHeight/2)
        self.tableView.transform = CGAffineTransformMakeRotation(-CGFloat(M_PI/2.000000))
        self.tableView.showsVerticalScrollIndicator = false
        }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableViewArray.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return screenWidth
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        tableView.registerNib(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "ListTableViewCellId")
        let cell = tableView.dequeueReusableCellWithIdentifier("ListTableViewCellId", forIndexPath: indexPath) as! ListTableViewCell
        
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        cell.backgroundColor = UIColor.clearColor()
        cell.contentView.backgroundColor = UIColor.clearColor()
    
        cell.backView.userInteractionEnabled = true
        cell.deleteBtn.tag = indexPath.row
        cell.deleteBtn.callBack = { tag in
            
            
            if self.tableViewArray.count == 1 {
                SVProgressShow.showInfoWithStatus("清单全部删除")
                return
            }
            self.tableViewArray.removeObjectAtIndex(tag)
            let deleteIndexPath : NSIndexPath = NSIndexPath(forRow: tag, inSection: 0)
            self.tableView.deleteRowsAtIndexPaths([deleteIndexPath], withRowAnimation: UITableViewRowAnimation.Top)
            
            
        }
        
        cell.newBtn.tag = indexPath.row
        cell.newBtn.callBack = { tag in
            self.tableViewArray.addObject("")
            let addIndexPath : NSIndexPath = NSIndexPath(forRow: tag+1, inSection: 0)
            self.tableView.insertRowsAtIndexPaths([addIndexPath], withRowAnimation: UITableViewRowAnimation.Middle)
            
            self.tableView.scrollToRowAtIndexPath(addIndexPath, atScrollPosition: UITableViewScrollPosition.Top, animated: true)
            
        }
        
        cell.transform = CGAffineTransformMakeRotation(CGFloat(M_PI/2.000000))
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.navigationController?.pushViewController(ListDetailViewController(), animated: true)
        
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
