//
//  FeatureSecondViewController.swift
//  YOJP
//
//  Created by PayBay on 16/1/13.
//  Copyright © 2016年 PayBay. All rights reserved.
//

import UIKit

var oldOffsetY : CGFloat = 0

class FeatureSecondViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

    
    var tableView : UITableView!
    
    var tableViewDataArray : NSMutableArray = ["    在这个冬天的早晨，静静的看看柏林老宅里的暖心咖啡馆","    曾经再美，不过一回空谈。脚下艰难，却是直指明天。","    学会了适应，就会让你的环境变得明亮；学会了宽容，就会让你的生活没有烦恼。","    当你能飞的时候，就不要放弃飞;当你能梦的时候，就不要放弃梦。世界没有尽头，只要心中还有追求。人生真正的终点是希望的终结。苍鹰的骄傲是飞翔的双翼，人生的意义是不断的追求。","    最闹心的烦躁是你根本不知道自己究竟在烦什么，无缘无故就全身负能量爆棚 。巴拉拉巴拉拉巴拉拉巴","    所谓的贵人：就是开拓你的眼界，带你进入新的世界。 明天是否辉煌，取决于你今天的选择和行动！","    男人穷不要紧，就怕又穷又有脾气。女人丑也不要紧，就怕又丑又懒惰。","    无论你此刻是否迷茫，在阳光升起的时候，请相信，努力的人最终都有回报 。"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.whiteColor()
        
        self.creatTableView()
        // Do any additional setup after loading the view.
    }

    func creatTableView() {
        self.tableView = UITableView(frame: CGRectMake(0, 0, screenWidth, screenHeight-navBarH-titleH), style: .Plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .None
        self.view.addSubview(self.tableView)
    }

    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            return 7
        }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
            let label : UILabel = UILabel(frame: CGRectMake(0,0,screenWidth-16,30))
            label.font = font15
            label.textColor = yojpText
            label.text = self.tableViewDataArray[indexPath.row] as? String
            label.numberOfLines = 0
            label.sizeToFit()
            return screenWidth/5*3+8+label.frame.size.height+8
    }
    
    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
            tableView.registerNib(UINib(nibName: "BrandTableViewCell", bundle: nil), forCellReuseIdentifier: "BrandTableViewCellId")
            let cell = tableView.dequeueReusableCellWithIdentifier("BrandTableViewCellId", forIndexPath: indexPath) as! BrandTableViewCell
            
            cell.selectionStyle = .None
            
            cell.backImageView.image = UIImage(named: String(format: "image%d", arc4random() % 14))
            cell.desLabel.text = self.tableViewDataArray[indexPath.row] as? String
            cell.desLabel.textColor = yojpText
            
            return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
            let storeDetailViewController = StoreDetailViewController()
            storeDetailViewController.storeNameSrting = indexPath.row % 2 == 0 ? "品牌介绍":"软文推荐"
            self.navigationController?.pushViewController(storeDetailViewController, animated: true)
    }
    
    func scrollViewDidScroll(scrollView: UIScrollView) {
        if scrollView.contentOffset.y > oldOffsetY {
            FirstViewController.shareFirstViewController().escapeBtn.hidden = true
        }
        else {
            FirstViewController.shareFirstViewController().escapeBtn.hidden = false
        }
        
        oldOffsetY = scrollView.contentOffset.y
        
        if scrollView.contentOffset.y == 0 {
           FirstViewController.shareFirstViewController().escapeBtn.hidden = false
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
