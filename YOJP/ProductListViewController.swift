//
//  ProductListViewController.swift
//  YOJP
//
//  Created by PayBay on 15/11/30.
//  Copyright © 2015年 PayBay. All rights reserved.
//

import UIKit

class ProductListViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    var ticketType : String!
    
    var customNavigationBar : UIView!
    var typeBtn : UIButton!
    
    var tableView : UITableView!
    var tableViewDataArray : NSMutableArray = ["    在这个冬天的早晨，静静的看看柏林老宅里的暖心咖啡馆","    曾经再美，不过一回空谈。脚下艰难，却是直指明天。","    学会了适应，就会让你的环境变得明亮；学会了宽容，就会让你的生活没有烦恼。","    当你能飞的时候，就不要放弃飞;当你能梦的时候，就不要放弃梦。世界没有尽头，只要心中还有追求。人生真正的终点是希望的终结。苍鹰的骄傲是飞翔的双翼，人生的意义是不断的追求。","    最闹心的烦躁是你根本不知道自己究竟在烦什么，无缘无故就全身负能量爆棚 。巴拉拉巴拉拉巴拉拉巴","    所谓的贵人：就是开拓你的眼界，带你进入新的世界。 明天是否辉煌，取决于你今天的选择和行动！","    男人穷不要紧，就怕又穷又有脾气。女人丑也不要紧，就怕又丑又懒惰。","    无论你此刻是否迷茫，在阳光升起的时候，请相信，努力的人最终都有回报 。"]
    
    var showSelectTypeTabelView : Bool = false
    
    
    var selectTypeTableViewBackView : UIView!
    var selectTypeTableView : UITableView!
    var selectTypeTableViewDataArray : NSMutableArray = ["清洁类","维护类","保湿类"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        
        self.creatTableView()
        self.createSelectTypeTableView()
        self.creatCustomNavigationBar()
        
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


    func creatTableView() {
        self.tableView = UITableView(frame: CGRectMake(0, 0, screenWidth, screenHeight-44+8), style: .Plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .None
        self.view.addSubview(self.tableView)
    }
    
    func createSelectTypeTableView() {
        
        self.selectTypeTableViewBackView = UIView(frame: CGRectMake(0, 0, screenWidth, screenHeight))
        self.selectTypeTableViewBackView.hidden = true
        
        self.selectTypeTableView = UITableView(frame: CGRectMake(screenWidth, screenHeight - 44*CGFloat(self.selectTypeTableViewDataArray.count)-40 , screenWidth/2, 44*CGFloat(self.selectTypeTableViewDataArray.count)))
        self.selectTypeTableView.tableFooterView = UIView()
        self.selectTypeTableView.dataSource = self
        self.selectTypeTableView.delegate = self
        self.selectTypeTableView.backgroundColor = UIColor.clearColor()
        self.selectTypeTableView.scrollEnabled = false
        
        self.view.addSubview(self.selectTypeTableViewBackView)
        self.view.addSubview(self.selectTypeTableView)
    }

    

    func creatCustomNavigationBar() {
        self.customNavigationBar = UIView(frame: CGRectMake(0,screenHeight-44,screenWidth,44))
        self.customNavigationBar.backgroundColor = yojpBlue
        
        
        let backBtn = UIButton(type: .Custom)
        backBtn.frame = CGRectMake(20, 7, 30, 30)
        backBtn.setBackgroundImage(UIImage(named: "箭头"), forState: UIControlState.Normal)
        backBtn.addTarget(self, action: Selector("backClicked"), forControlEvents: UIControlEvents.TouchUpInside)
        self.customNavigationBar.addSubview(backBtn)
        
        
        self.typeBtn = UIButton(type: .Custom)
        self.typeBtn.frame = CGRectMake(screenWidth-55, 7, 50, 25)
        self.typeBtn.setTitle("分类", forState: .Normal)
        self.typeBtn.addTarget(self, action: Selector("selectType"), forControlEvents: UIControlEvents.TouchUpInside)
        self.customNavigationBar.addSubview(self.typeBtn)
        
        self.view.addSubview(self.customNavigationBar)
    }

    func changeType() {
        
    }
    
    func backClicked() {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if tableView == self.tableView {
           return self.tableViewDataArray.count + 2
        }
        else {
            return self.selectTypeTableViewDataArray.count
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if tableView == self.tableView {
            
            if indexPath.section <= 1 {
                return 44
            }
            else {
                let label : UILabel = UILabel(frame: CGRectMake(0,0,screenWidth-48,30))
                label.font = font16
                label.textColor = yojpText
                label.text = self.tableViewDataArray[indexPath.section-2] as? String
                label.numberOfLines = 0
                label.sizeToFit()
                return 14+21+2+label.frame.size.height+8+screenWidth/5*3+16+25+16
            }
        }
        else {
            return 44
        }
        
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        if tableView == self.tableView {
            return 8
        }
        else {
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if tableView == self.tableView {
            if indexPath.section == 0 {
                
                tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cellId")
                let cell : UITableViewCell = UITableViewCell(style: .Default, reuseIdentifier: "cellId")
                cell.selectionStyle = UITableViewCellSelectionStyle.None
                cell.accessoryType = .DisclosureIndicator
                
                cell.imageView?.image = UIImage(named: "定位")
                cell.textLabel?.text = "当前商家:某某街某某路某某号某某店"
                cell.textLabel?.textColor = yojpText
                cell.textLabel?.font = font14
                
                return cell

            }
            else if indexPath.section == 1 {
                
                tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cellId")
                let cell : UITableViewCell = UITableViewCell(style: .Value1, reuseIdentifier: "cellId")
                cell.selectionStyle = UITableViewCellSelectionStyle.None
                cell.accessoryType = .DisclosureIndicator
                
                cell.textLabel?.text = ticketType
                cell.detailTextLabel?.text = "已有200人领取"
                cell.textLabel?.textColor = yojpText
                cell.detailTextLabel?.textColor = yojpLightText
                cell.detailTextLabel?.font = font14
                
                return cell
            }
            else {
                tableView.registerNib(UINib(nibName: "DetailTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailTableViewCellId")
                let cell = tableView.dequeueReusableCellWithIdentifier("DetailTableViewCellId", forIndexPath: indexPath) as! DetailTableViewCell
                
                cell.selectionStyle = .None
                
                cell.productNameLabel.text = "商品名称"
                cell.productDicLabel.text = self.tableViewDataArray[indexPath.section-2] as? String
                cell.ProductImageView.image =  UIImage(named: String(format: "image%d", indexPath.section))
                cell.moneyLabel.text = "￥300"
                cell.stockLabel.text = "库存量:123件"
                
                return cell
                
            }
        }
        else {
            tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cellId")
            let cell = tableView.dequeueReusableCellWithIdentifier("cellId", forIndexPath: indexPath) as UITableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            
            cell.textLabel?.text = self.selectTypeTableViewDataArray[indexPath.section] as? String
            
            cell.textLabel?.textColor = yojpText
            
            return cell
        }
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if tableView == self.tableView {
            
            if indexPath.section == 1 {
                let takeTicketViewController = TakeTicketViewController()
                takeTicketViewController.ticketType = self.ticketType
                self.navigationController?.pushViewController(takeTicketViewController, animated: true)
            }
        }
        else {
            self.showSelectTypeTabelView = !self.showSelectTypeTabelView
            UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                self.selectTypeTableView.layer.transform = CATransform3DIdentity
                self.selectTypeTableViewBackView.backgroundColor = UIColor.clearColor()
                
                }) { (finished : Bool) -> Void in
                    
                    self.selectTypeTableViewBackView.hidden = true
                    
                    let myPath : NSIndexPath = NSIndexPath(forRow: 0, inSection: indexPath.section)
                    self.tableView.selectRowAtIndexPath(myPath, animated: true, scrollPosition: UITableViewScrollPosition.Top)
            }

        }
    }

    func selectType() {
        
        self.showSelectTypeTabelView = !self.showSelectTypeTabelView
        if self.showSelectTypeTabelView {
            self.selectTypeTableViewBackView.hidden = false
            
            UIView.animateWithDuration(0.8, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                
                self.selectTypeTableView.layer.transform = CATransform3DMakeTranslation(-screenWidth/2, 0, 0)
                
                }, completion: { (finished : Bool) -> Void in
                    
            })
            
            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                
                self.selectTypeTableViewBackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
                
                }, completion: { (finished : Bool) -> Void in
                    
            })
        }
        else {
            
            UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                self.selectTypeTableView.layer.transform = CATransform3DIdentity
                self.selectTypeTableViewBackView.backgroundColor = UIColor.clearColor()
                
                }) { (finished : Bool) -> Void in
                    
                    self.selectTypeTableViewBackView.hidden = true
            }

            
//            UIView.animateWithDuration(0.8, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
//                
//                self.selectTypeTableView.layer.transform = CATransform3DMakeTranslation(screenWidth/2, 0, 0)
//                
//                }, completion: { (finished : Bool) -> Void in
//                    
//            })
//            
//            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
//                
//                self.selectTypeTableViewBackView.backgroundColor = UIColor.clearColor()
//                }, completion: { (finished : Bool) -> Void in
//                    
//            })
//            
//            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
//                
//                }, completion: { (finished : Bool) -> Void in
//                    self.selectTypeTableViewBackView.hidden = true
//            })
            
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
