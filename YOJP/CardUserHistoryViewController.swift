//
//  CardUserHistoryViewController.swift
//  YOJP
//
//  Created by PayBay on 15/12/4.
//  Copyright © 2015年 PayBay. All rights reserved.
//

import UIKit

class CardUserHistoryViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate {

    
    var tableViewDataArray1 : NSMutableArray = ["免费券","八五折-打折券","100元-抵扣券","888元-福袋","九折-打折券","500元-抵扣券","免费券","八五折-打折券","100元-抵扣券","888元-福袋","九折-打折券","500元-抵扣券"]
    
    var customNavigationBar : UIView!
    
    var previousBtn : NTButton!
    var tabBarView : UIView!
    var tabBarScrollView : UIView!
    
    var scrollView : UIScrollView!
    var useTableView : UITableView!
    var overdueTbaleView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.creatCustomNavigationBar()
        self.creatScrollView()
        self.creatUseTableView()
        self.creatOverdueTableView()
        self.creatTabBarView()
        
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

    
    func creatTabBarView() {
        
        self.tabBarView = UIView(frame: CGRectMake(0,0,screenWidth,64))
        self.tabBarView.userInteractionEnabled = true
        self.tabBarView.backgroundColor = yojpBlue
        self.view.addSubview(self.tabBarView)
        
        self.tabBarScrollView = UIView(frame: CGRectMake(50,self.tabBarView.frame.size.height-3,self.tabBarView.frame.size.width/2-100,4))
        self.tabBarScrollView.backgroundColor = UIColor.whiteColor()
        self.tabBarView.addSubview(self.tabBarScrollView)
        
        
        self.creatButtonWithNormalName("已使用", SelectName: "未评价高亮", Index: 0)
        self.creatButtonWithNormalName("已过期", SelectName: "已评价高亮", Index: 1)
        
        self.previousBtn = NTButton()
        let button : NTButton = self.tabBarView.subviews[1] as! NTButton
        self.changeViewController(button)
    }
    
    func creatScrollView() {
        self.scrollView = UIScrollView(frame: CGRectMake(0,64,screenWidth,screenHeight-64-44))
        self.scrollView.contentSize = CGSizeMake(screenWidth*2, 0)
        self.scrollView.contentOffset = CGPointMake(0, 0)
        self.scrollView.backgroundColor = yojpTableViewColor
        self.scrollView.pagingEnabled = true
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.delegate = self
        self.scrollView.bounces = false
        self.view.addSubview(self.scrollView)
    }
    
    func creatUseTableView() {
        self.useTableView = UITableView(frame: CGRectMake(0, 0, screenWidth, self.scrollView.frame.size.height), style: .Plain)
        self.useTableView.backgroundColor = yojpTableViewColor
        self.useTableView.delegate = self
        self.useTableView.dataSource = self
        self.useTableView.separatorStyle = .None
        self.scrollView.addSubview(self.useTableView)
    }
    
    func creatOverdueTableView() {
        self.overdueTbaleView = UITableView(frame: CGRectMake(screenWidth, 0, screenWidth, self.scrollView.frame.size.height), style: .Plain)
        self.overdueTbaleView.backgroundColor = yojpTableViewColor
        self.overdueTbaleView.delegate = self
        self.overdueTbaleView.dataSource = self
        self.overdueTbaleView.separatorStyle = .None
        self.scrollView.addSubview(self.overdueTbaleView)
    }
    
    
    func creatButtonWithNormalName(normal : String, SelectName : String, Index : Int) {
        
        let customButton = NTButton(type: .Custom)
        customButton.tag = Index
        let buttonW = self.tabBarView.frame.size.width/2
        let buttonH = self.tabBarView.frame.size.height-20
        
        customButton.frame = CGRectMake(buttonW * CGFloat(Index), 20, buttonW, buttonH)
        
        customButton.setBackgroundImage(UIImage(named: "未评价选中选中高亮"), forState: UIControlState.Disabled)
        customButton.setTitle(normal, forState: UIControlState.Normal)
        customButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Disabled)
        customButton.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        customButton.titleLabel?.font = font18
        customButton.addTarget(self, action: Selector("changeViewController:"), forControlEvents: UIControlEvents.TouchDown)
        customButton.imageView?.contentMode = .Center
        self.tabBarView.addSubview(customButton)
        
        let imageView : UIImageView = UIImageView(frame: CGRectMake(self.tabBarView.frame.size.width/2-3, 0, 6, self.tabBarView.frame.size.height-2.5))
        imageView.backgroundColor = UIColor.whiteColor()
        
    }

    
    func changeViewController(sender : NTButton) {
        
        if self.previousBtn != sender {
            
            // self.navigationItem.titleView?.userInteractionEnabled = false
            
            self.previousBtn.enabled = true
            self.previousBtn = sender
            
            
            sender.enabled = false
            
            UIView.animateWithDuration(0.8, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
                
                if sender.tag == 1 {
                    
                   
                    self.scrollView.contentOffset = CGPointMake(screenWidth, 0)
                    
                    self.tabBarScrollView.layer.transform = CATransform3DMakeTranslation(self.tabBarView.frame.size.width/2, 0, 0)
                    
                }
                else {
                    
                    
                    self.scrollView.contentOffset = CGPointMake(0, 0)
                    self.tabBarScrollView.layer.transform = CATransform3DIdentity
                }
                
                }, completion: { (finished : Bool) -> Void in
                    
            })
        }
        else {
            sender.enabled = false
        }
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.useTableView {
            return 10
        }
        else {
          return 2
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 90 + 20
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        tableView.registerNib(UINib(nibName: "CardListTableViewWithTimeCell", bundle: nil), forCellReuseIdentifier: "CardListTableViewWithTimeCellId")
        let cell = tableView.dequeueReusableCellWithIdentifier("CardListTableViewWithTimeCellId", forIndexPath: indexPath) as! CardListTableViewWithTimeCell
        
        cell.selectionStyle = .None
        cell.backgroundColor = yojpTableViewColor
        
        cell.barcodeImagwView.image = UIImage(named: "2DBarcode")
        cell.ticketTypeLabel.text = self.tableViewDataArray1[indexPath.row] as? String
        cell.validityLabel.text = "2015.11.11-2016.11.10"
        cell.useTimeLabel.text = tableView == self.useTableView ? "使用时间:2015.12.12 18:55" : "失效时间:2015.10.12 16：45"
        
        return cell
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        if scrollView == self.scrollView {
            let page = Int(scrollView.contentOffset.x / screenWidth)
            let button : NTButton = self.tabBarView.subviews[page+1] as! NTButton
            self.changeViewController(button)
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
