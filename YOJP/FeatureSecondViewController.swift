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
        self.tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = yojpTableViewColor
        self.tableView.separatorStyle = .None
        self.view.addSubview(self.tableView)
    }

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
            return section == 0 ? 2 : 3
        }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if indexPath.section == 0 {
            return indexPath.row == 0 ? 200 : 44
        }
        else {
            return 180
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
                
                let imageView : UIImageView = UIImageView(frame: CGRectMake(0,0,screenWidth,200))
                imageView.image = UIImage(named: "优惠推荐")
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
                
                let label : UILabel = UILabel(frame: CGRectMake(8,7,100,30))
                label.text = "热门头条"
                label.textColor = UIColor(red: 232/255.0, green: 7/255.0, blue: 74/255.0, alpha: 1)
                label.font = font15
                cell.contentView.addSubview(label)
                
                let messageLabel : UILabel = UILabel(frame: CGRectMake(label.frame.size.width,7,screenWidth-label.frame.size.width-50,30))
                messageLabel.text = "紧急通知，东京发生5.2级地震"
                messageLabel.textColor = yojpText
                messageLabel.font = font14
                cell.contentView.addSubview(messageLabel)
                
                return cell
            }
        }
        else {
            tableView.registerNib(UINib(nibName: "FeatureTableViewCell", bundle: nil), forCellReuseIdentifier: "FeatureTableViewCellId")
            let cell = tableView.dequeueReusableCellWithIdentifier("FeatureTableViewCellId", forIndexPath: indexPath) as! FeatureTableViewCell
            
            cell.selectionStyle = .None
            cell.storeLogoImageView.image = UIImage(named: String(format: "u7%d", indexPath.row))
            cell.storeName.text = "堂吉诃德"
            let item1 : ChooseView = ChooseView(frame: CGRectMake(0,0,screenWidth-100,20))
            item1.chooseImageSelectString("免", imageNormalString: "免")
            item1.label.text = "消费满100元可获赠兰蔻气垫bb霜小样"
            item1.label.font = font13
            cell.item1View.addSubview(item1)
            let item2 : ChooseView = ChooseView(frame: CGRectMake(0,0,screenWidth-100,20))
            item2.chooseImageSelectString("折", imageNormalString: "折")
            item2.label.text = "一次性消费288元可享8折"
            item2.label.font = font13
            cell.item2View.addSubview(item2)
            return cell
        }
        
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
