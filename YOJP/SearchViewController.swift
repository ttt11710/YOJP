//
//  SearchViewController.swift
//  YOJP
//
//  Created by PayBay on 15/12/1.
//  Copyright © 2015年 PayBay. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource {

    
    var search : UISearchBar!
    
    var tableView : UITableView!
    var tableViewDataArray : NSMutableArray = ["    在这个冬天的早晨，静静的看看柏林老宅里的暖心咖啡馆","    曾经再美，不过一回空谈。脚下艰难，却是直指明天。","    学会了适应，就会让你的环境变得明亮；学会了宽容，就会让你的生活没有烦恼。","    当你能飞的时候，就不要放弃飞;当你能梦的时候，就不要放弃梦。世界没有尽头，只要心中还有追求。人生真正的终点是希望的终结。苍鹰的骄傲是飞翔的双翼，人生的意义是不断的追求。","    最闹心的烦躁是你根本不知道自己究竟在烦什么，无缘无故就全身负能量爆棚 。巴拉拉巴拉拉巴拉拉巴","    所谓的贵人：就是开拓你的眼界，带你进入新的世界。 明天是否辉煌，取决于你今天的选择和行动！","    男人穷不要紧，就怕又穷又有脾气。女人丑也不要紧，就怕又丑又懒惰。","    无论你此刻是否迷茫，在阳光升起的时候，请相信，努力的人最终都有回报 。"]
    
    var emptyTableViewDataArray : NSMutableArray = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        
        
        let searchBackView = UIView(frame: CGRectMake(0,0,screenWidth,20+44))
        searchBackView.backgroundColor = UIColor.blackColor()
        self.view.addSubview(searchBackView)
        
        self.search = UISearchBar(frame: CGRectMake(16,20+7,screenWidth-32-50,30))
        self.search.barTintColor = UIColor.clearColor()
        self.search.delegate = self
        self.search.placeholder = "搜索"
        
        searchBackView.addSubview(self.search)
        
        let cancelBtn : UIButton = UIButton(frame: CGRectMake(screenWidth-50-8,20+7,50,30))
        cancelBtn.setTitle("取消", forState: .Normal)
        cancelBtn.titleLabel?.textAlignment = .Center
        cancelBtn.setTitleColor(UIColor(white: 1, alpha: 0.8), forState: .Normal)
        cancelBtn.backgroundColor = UIColor.clearColor()
        cancelBtn.addTarget(self, action: Selector("cancelSearchBtnPressed"), forControlEvents: .TouchUpInside)
        searchBackView.addSubview(cancelBtn)
        
        
        
        self.tableView = UITableView(frame: CGRectMake(0, 20+44, screenWidth, screenHeight-64))
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .None
        self.view.addSubview(self.tableView)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let delayInSeconds : Double = 0.5
        let popTime : dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds * Double(NSEC_PER_SEC)))
        dispatch_after(popTime, dispatch_get_main_queue(), { () -> Void in                self.search.becomeFirstResponder()
        })

        
        
    }
    
    func cancelSearchBtnPressed() {
        
        self.search.resignFirstResponder()
        
        let delayInSeconds : Double = 0.5
        let popTime : dispatch_time_t = dispatch_time(DISPATCH_TIME_NOW, Int64(delayInSeconds * Double(NSEC_PER_SEC)))
        dispatch_after(popTime, dispatch_get_main_queue(), { () -> Void in                self.dismissViewControllerAnimated(true) { () -> Void in
            
            }

        })
    }
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        self.search.resignFirstResponder()
        
        self.emptyTableViewDataArray = self.tableViewDataArray
        self.tableView.reloadData()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emptyTableViewDataArray.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        let label : UILabel = UILabel(frame: CGRectMake(0,0,screenWidth-16,30))
        label.font = font15
        label.textColor = yojpText
        label.text = self.emptyTableViewDataArray[indexPath.row] as? String
        label.numberOfLines = 0
        label.sizeToFit()
        return screenWidth/5*3+8+label.frame.size.height+8
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        tableView.registerNib(UINib(nibName: "BrandTableViewCell", bundle: nil), forCellReuseIdentifier: "BrandTableViewCellId")
        let cell = tableView.dequeueReusableCellWithIdentifier("BrandTableViewCellId", forIndexPath: indexPath) as! BrandTableViewCell
        
        cell.selectionStyle = .None
        
        cell.backImageView.image = UIImage(named: String(format: "image%d", indexPath.row))
        cell.desLabel.text = self.emptyTableViewDataArray[indexPath.row] as? String
        cell.desLabel.textColor = yojpText
        
        
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
