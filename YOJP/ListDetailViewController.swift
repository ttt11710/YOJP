//
//  ListDetailViewController.swift
//  YOJP
//
//  Created by PayBay on 15/12/28.
//  Copyright © 2015年 PayBay. All rights reserved.
//

import UIKit

class ListDetailViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UITextViewDelegate {

    
    var customNavigationBar : UIView!
    
    var tableView : UITableView!
    
    var tableViewArray : NSMutableArray = ["资生堂","花王","多芬","艾文莉","    在这个冬天的早晨，静静的看看柏林老宅里的暖心咖啡馆学会了适应，就会让你的环境变得明亮","    曾经再美，不过一回空谈。脚下艰难，却是直指明天。","    学会了适应，就会让你的环境变得明亮；学会了宽容，就会让你的生活没有烦恼。学会了适应，就会让你的环境变得明亮；学会了宽容，就会让你的生活没有烦恼。学会了宽容，就会让你。"]
    
    
    var keyboardRectHeight : CGFloat!
    var cellHeight : CGFloat = 0.0
    
    var textViewIsFirstResponderTag : Int = -1
    var changeTableViewContentOffset : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = yojpTableViewColor
        
//        self.mm_drawerController.removeGestureRecognizers()
        
        self.creatCustomNavigationBar()
        self.creatTableView()
        
        
        // Do any additional setup after loading the view.
    }

//    override func viewWillAppear(animated: Bool) {
//        super.viewWillAppear(animated)
//        
//        UIApplication.sharedApplication().statusBarStyle = .Default
//        self.navigationController?.navigationBarHidden = true
//        
//        self.registerForKeyboardNottifications()
//        
//    }
//    
//    override func viewWillDisappear(animated: Bool) {
//        super.viewWillDisappear(animated)
//        self.navigationController?.navigationBarHidden = false
//        self.mm_drawerController.setupGestureRecognizers()
//        
//        NSNotificationCenter.defaultCenter().removeObserver(self)
//    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        UIApplication.sharedApplication().statusBarStyle = .Default
        self.navigationController?.navigationBar.alpha = 0
        
        self.registerForKeyboardNottifications()
        
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.navigationController?.navigationBar.alpha = 1
        
       // self.mm_drawerController.setupGestureRecognizers()
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    
    
    func registerForKeyboardNottifications() {
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWasShown:"), name: UIKeyboardDidShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
        
    }
    
    func keyboardWasShown(notification : NSNotification) {
        
        
        let userInfo : NSDictionary = notification.userInfo!
    
        let aValue : NSValue = userInfo.objectForKey(UIKeyboardFrameEndUserInfoKey)! as! NSValue
        let keyboardRect : CGRect = aValue.CGRectValue()
        
        self.keyboardRectHeight = keyboardRect.height
        
        
        if self.cellHeight + 20 > screenHeight - self.keyboardRectHeight {
            self.changeTableViewContentOffset = true
            
            self.tableView.setContentOffset(CGPointMake(0, self.cellHeight + 20 - screenHeight + self.keyboardRectHeight), animated: true)
        }
    
    }
    
    func keyboardWillHide(notification : NSNotification) {
    
        self.changeTableViewContentOffset = false
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
        self.tableView = UITableView(frame: CGRectMake(0, 20, screenWidth, screenHeight-64), style: .Plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = yojpTableViewColor
        self.tableView.tableFooterView = UIView()
        self.view.addSubview(self.tableView)
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.tableViewArray.count + 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if indexPath.section < self.tableViewArray.count {
            return self.heightForString(self.tableViewArray[indexPath.section] as! String, fontSize: 16.0, width: screenWidth-16)+20
        }
        else {
            return 44
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section < self.tableViewArray.count {
            tableView.registerNib(UINib(nibName: "ListDetailTableViewCell", bundle: nil), forCellReuseIdentifier: "ListDetailTableViewCellId")
            let cell = tableView.dequeueReusableCellWithIdentifier("ListDetailTableViewCellId", forIndexPath: indexPath) as! ListDetailTableViewCell
            
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.textView.text = self.tableViewArray[indexPath.section] as! String
            cell.textView.tag = indexPath.section
            cell.textView.delegate = self
            return cell
            
        }
        else {
            tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            cell.textLabel?.text = "增加一个内容"
            cell.textLabel?.textColor = yojpText
            cell.textLabel?.opaque = true
            
            return cell
        }
        
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            
            self.tableViewArray.removeObjectAtIndex(indexPath.section)
            tableView.deleteSections(NSIndexSet(index: indexPath.section), withRowAnimation: UITableViewRowAnimation.Top)
        }
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        if indexPath.section < self.tableViewArray.count {
           return UITableViewCellEditingStyle.Delete
        }
        else {
            return UITableViewCellEditingStyle.None
        }
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    
        if indexPath.section == self.tableViewArray.count {
            self.tableViewArray.addObject("加了我")
            self.tableView.insertSections(NSIndexSet(index: indexPath.section), withRowAnimation: UITableViewRowAnimation.Top)
            self.tableView.reloadData()
            
            let scrollIndexPath : NSIndexPath = NSIndexPath(forRow: 0, inSection: self.tableViewArray.count)
            self.tableView.scrollToRowAtIndexPath(scrollIndexPath, atScrollPosition: UITableViewScrollPosition.Bottom, animated: true)
            
        }
        
    }

    func backClicked() {
        
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    
    func heightForString(textView : String, fontSize : CGFloat, width : CGFloat) -> CGFloat{
        
        let detailTextView : UITextView = UITextView(frame: CGRectMake(0, 0, width, 0))
        detailTextView.font = UIFont.systemFontOfSize(fontSize)
        detailTextView.text = textView
        let deSize : CGSize = detailTextView.sizeThatFits(CGSizeMake(width, CGFloat.max))
        
        return deSize.height
    }
    
    func textViewDidChange(textView: UITextView) {
        self.tableViewArray[textView.tag] = textView.text
    }
    
    func textViewShouldBeginEditing(textView: UITextView) -> Bool {
        
        self.textViewIsFirstResponderTag = textView.tag
        let scrollIndexPath : NSIndexPath = NSIndexPath(forRow: 0, inSection: 0)
        self.tableView.scrollToRowAtIndexPath(scrollIndexPath, atScrollPosition: UITableViewScrollPosition.Top, animated: false)
        self.cellHeight = 0.0
        for i in 0...textView.tag {
           self.cellHeight = self.cellHeight + self.heightForString(self.tableViewArray[i] as! String, fontSize: 16.0, width: screenWidth-16)+20
        }
        return true
    }
    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        if text == "\n" {
            textView.resignFirstResponder()
            self.tableView.reloadData()
           return true
        }
        return true
    }
    
    func textViewShouldEndEditing(textView: UITextView) -> Bool {
        
        return true
    }
    
    func textViewDidEndEditing(textView: UITextView) {
        let scrollIndexPath : NSIndexPath = NSIndexPath(forRow: 0, inSection: textView.tag)
        self.tableView.scrollToRowAtIndexPath(scrollIndexPath, atScrollPosition: UITableViewScrollPosition.Top, animated: false)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView == self.tableView {
            
            for indexPath in self.tableView.indexPathsForVisibleRows! {
                if indexPath.section == self.textViewIsFirstResponderTag {
                    
                    let cell : ListDetailTableViewCell = self.tableView.cellForRowAtIndexPath(indexPath) as! ListDetailTableViewCell
                    if cell.textView.isFirstResponder() && !self.changeTableViewContentOffset {
                        cell.textView.resignFirstResponder()
                    }
                }
                
            }
        }
    }
    
    func scrollViewDidEndScrollingAnimation(scrollView: UIScrollView) {
        
        self.changeTableViewContentOffset = false
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
