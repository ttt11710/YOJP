//
//  NewCollectionViewController.swift
//  YOJP
//
//  Created by PayBay on 16/1/12.
//  Copyright © 2016年 PayBay. All rights reserved.
//

import UIKit

class NewCollectionViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    
    var customNavigationBar : UIView!
    
    var tableView : UITableView!
    
    var tableViewRowArray : NSMutableArray = []
    //    [
    //        [["产品图片":"image6","产品名称":"产品名称","价格":"150","数量":"3"],
    //            ["产品图片":"image2","产品名称":"产品名称","价格":"10","数量":"2"],
    //            ["产品图片":"image3","产品名称":"产品名称","价格":"5","数量":"1"]],
    //        [["产品图片":"image9","产品名称":"产品名称","价格":"1500","数量":"30"],
    //            ["产品图片":"image4","产品名称":"产品名称","价格":"60","数量":"12"],
    //            ["产品图片":"image5","产品名称":"产品名称","价格":"50","数量":"4"],
    //            ["产品图片":"image7","产品名称":"产品名称","价格":"20","数量":"335"]]]
    
    var tableViewSectionArray : NSMutableArray = ["0","0"]
    
    
    var sumLabel : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = yojpTableViewColor
        
        var dic : NSMutableDictionary = ["产品图片":"image6","产品名称":"产品名称","价格":"150","数量":"3"]
        let array : NSMutableArray = []
        array.addObject(dic.mutableCopy())
        dic.removeAllObjects()
        dic = ["产品图片":"image2","产品名称":"产品名称","价格":"10","数量":"2"]
        array.addObject(dic.mutableCopy())
        dic.removeAllObjects()
        dic = ["产品图片":"image3","产品名称":"产品名称","价格":"5","数量":"1"]
        array.addObject(dic.mutableCopy())
        dic.removeAllObjects()
        
        self.tableViewRowArray.addObject(array.mutableCopy())
        array.removeAllObjects()
        dic = ["产品图片":"image9","产品名称":"产品名称","价格":"1500","数量":"30"]
        array.addObject(dic.mutableCopy())
        dic.removeAllObjects()
        dic = ["产品图片":"image4","产品名称":"产品名称","价格":"60","数量":"12"]
        array.addObject(dic.mutableCopy())
        dic.removeAllObjects()
        dic = ["产品图片":"image5","产品名称":"产品名称","价格":"50","数量":"4"]
        array.addObject(dic.mutableCopy())
        dic.removeAllObjects()
        dic = ["产品图片":"image7","产品名称":"产品名称","价格":"20","数量":"335"]
        array.addObject(dic.mutableCopy())
        dic.removeAllObjects()
        self.tableViewRowArray.addObject(array.mutableCopy())
        
        print(self.tableViewRowArray)
        
        self.creatCustomNavigationBar()
        self.creatTableView()
        self.creatSettlementView()
        
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
    
    
    
    class func shareShopCarListViewController() -> ShopCarListViewController {
        return defaultShopCarListViewController
    }
    
    func removeAllShopCarList() {
        self.tableViewSectionArray.removeAllObjects()
        self.tableViewRowArray.removeAllObjects()
        self.tableView.reloadData()
        
        self.sumLabel.text = "总计:￥0"
        self.tableView.hidden = true
        
        let imageView : UIImageView = UIImageView(image: UIImage(named: "空页面"))
        imageView.center = CGPointMake(screenWidth/2, (screenHeight-88)/2-40)
        imageView.bounds = CGRectMake(0, 0, 80, 75)
        imageView.opaque = true
        self.view.addSubview(imageView)
        
        
        let label : UILabel = UILabel()
        label.text = "赶快去逛逛吧!"
        label.textColor = yojpText
        label.textAlignment = .Center
        label.font = font15
        label.center = CGPointMake(screenWidth/2, (screenHeight-88)/2 + 20)
        label.bounds = CGRectMake(0, 0, 200, 21)
        label.opaque = true
        self.view.addSubview(label)
    }
    
    
    func creatCustomNavigationBar() {
        self.customNavigationBar = UIView(frame: CGRectMake(0,screenHeight-44,screenWidth,44))
        self.customNavigationBar.backgroundColor = yojpBlue
        
        
        let backBtn = UIButton(type: .Custom)
        backBtn.frame = CGRectMake(20, 7, 30, 30)
        backBtn.setBackgroundImage(UIImage(named: "箭头"), forState: UIControlState.Normal)
        backBtn.addTarget(self, action: #selector(NewCollectionViewController.backClicked), forControlEvents: UIControlEvents.TouchUpInside)
        backBtn.opaque = true
        self.customNavigationBar.addSubview(backBtn)
        self.view.addSubview(self.customNavigationBar)
        
    }
    
    func creatTableView() {
        self.tableView = UITableView(frame: CGRectMake(0, 20, screenWidth, screenHeight-108), style: .Plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = yojpTableViewColor
        self.tableView.tableFooterView = UIView()
        self.view.addSubview(self.tableView)
        
    }
    
    func creatSettlementView() {
        let settlementView : UIView = UIView(frame: CGRectMake(0,screenHeight-88,screenWidth,44))
        settlementView.backgroundColor = yojpSectionColor
        self.view.addSubview(settlementView)
        
        
        self.sumLabel = UILabel(frame: CGRectMake(0,0,screenWidth,44))
        self.sumLabel.text = "总计:￥900"
        self.sumLabel.textColor = yojpText
        self.sumLabel.textAlignment = .Center
        self.sumLabel.font = font16
        self.sumLabel.opaque = true
        settlementView.addSubview(self.sumLabel)
        
//        let sumBtn : UIButton = UIButton(frame: CGRectMake(screenWidth-100,4,90,36))
//        sumBtn.setTitle("结算", forState: .Normal)
//        sumBtn.setTitleColor(UIColor.whiteColor(), forState: .Normal)
//        sumBtn.backgroundColor = UIColor(red: 234.0/255.0, green: 103/255.0, blue: 16/255.0, alpha: 1)
//        sumBtn.addTarget(self, action: Selector("sumBtnPressed"), forControlEvents: .TouchUpInside)
//        settlementView.addSubview(sumBtn)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return self.tableViewRowArray.count
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.tableViewRowArray[section].count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        return 120
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view : UIView = UIView(frame: CGRectMake(0,0,screenWidth,30))
        view.backgroundColor = yojpSectionColor
        
        let chooseBtn : CallBackButton = CallBackButton(frame: CGRectMake(10,6,20,20))
        chooseBtn.setBackgroundImage(UIImage(named: "圆圈不选"), forState: .Normal)
        chooseBtn.setBackgroundImage(UIImage(named: "圆圈选中"), forState: .Selected)
        view.addSubview(chooseBtn)
        chooseBtn.setupBlock()
        chooseBtn.opaque = true
        chooseBtn.callBack = { tag in
            
            chooseBtn.selected = !chooseBtn.selected
            
        }
        let storeName : UILabel = UILabel(frame: CGRectMake(30+4,4,100,21))
        storeName.text = "商家名称"
        storeName.textColor = yojpText
        storeName.opaque = true
        view.addSubview(storeName)
        
        let editCallBtn : CallBackButton = CallBackButton(frame: CGRectMake(screenWidth-70,4,60,21))
        let string : String = self.tableViewSectionArray[section] as! String == "0" ? "编辑":"完成"
        editCallBtn.setTitle(string, forState: .Normal)
        editCallBtn.setTitleColor(yojpText, forState: .Normal)
        editCallBtn.titleLabel!.font = font15
        editCallBtn.tag = section
        editCallBtn.setupBlock()
        editCallBtn.opaque = true
        editCallBtn.callBack = { tag in
            
            self.tableViewSectionArray[tag] = self.tableViewSectionArray[tag] as! String == "0" ? "1" : "0"
            self.tableView.reloadData()
        }
        view.addSubview(editCallBtn)
        
        return view
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        tableView.registerNib(UINib(nibName: "NewCollectTableViewCell", bundle: nil), forCellReuseIdentifier: "NewCollectTableViewCellId")
        let cell = tableView.dequeueReusableCellWithIdentifier("NewCollectTableViewCellId", forIndexPath: indexPath) as! NewCollectTableViewCell
        
        cell.selectionStyle = .None
        cell.backgroundColor = UIColor.whiteColor()
        cell.productImageView.image = UIImage(named: self.tableViewRowArray[indexPath.section][indexPath.row]["产品图片"] as! String)
        cell.productName.text = self.tableViewRowArray[indexPath.section][indexPath.row]["产品名称"] as? String
        cell.productPriceLabel.text = String(format: "￥%@", self.tableViewRowArray[indexPath.section][indexPath.row]["价格"] as! String)
        cell.editView.hidden = (self.tableViewSectionArray[indexPath.section] as! String) == "0" ? true : false
        
        cell.editProductImageView.image = UIImage(named: self.tableViewRowArray[indexPath.section][indexPath.row]["产品图片"] as! String)
        cell.editProductName.text = self.tableViewRowArray[indexPath.section][indexPath.row]["产品名称"] as? String
        cell.editProductPriceLabel.text = String(format: "￥%@", self.tableViewRowArray[indexPath.section][indexPath.row]["价格"] as! String)

        cell.editDeleteCallBtn.tag = indexPath.row
                cell.editDeleteCallBtn.callBack = { tag in
            
            self.tableView.reloadData()
            if self.tableViewRowArray[indexPath.section].count != 1 {
                self.tableViewRowArray[indexPath.section].removeObjectAtIndex(tag)
                let deleteIndexPath : NSIndexPath = NSIndexPath(forRow: tag, inSection: indexPath.section)
                self.tableView.deleteRowsAtIndexPaths([deleteIndexPath], withRowAnimation: UITableViewRowAnimation.Top)
            }
            else {
                print(self.tableViewRowArray)
                print(self.tableViewSectionArray)
                self.tableViewRowArray.removeObjectAtIndex(indexPath.section)
                self.tableViewSectionArray.removeObjectAtIndex(indexPath.section)
                self.tableView.deleteSections(NSIndexSet(index: indexPath.section), withRowAnimation: UITableViewRowAnimation.Top)
                
                self.tableView.reloadData()
                print(self.tableViewRowArray)
                print(self.tableViewSectionArray)
                
                if self.tableViewSectionArray.count == 0 {
                    
                    self.sumLabel.text = "总计:￥0"
                    self.tableView.hidden = true
                    
                    let imageView : UIImageView = UIImageView(image: UIImage(named: "空页面"))
                    imageView.center = CGPointMake(screenWidth/2, (screenHeight-88)/2-40)
                    imageView.bounds = CGRectMake(0, 0, 80, 75)
                    self.view.addSubview(imageView)
                    
                    
                    let label : UILabel = UILabel()
                    label.text = "赶快去逛逛吧!"
                    label.textColor = yojpText
                    label.textAlignment = .Center
                    label.font = font15
                    label.center = CGPointMake(screenWidth/2, (screenHeight-88)/2 + 20)
                    label.bounds = CGRectMake(0, 0, 200, 21)
                    self.view.addSubview(label)
                    
                }
            }
            
            
        }
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
    }
    
    func sumBtnPressed() {
        
        if self.tableViewSectionArray.count == 0 {
            SVProgressShow.showInfoWithStatus("没有选中商品,不能结算!")
            return
        }
        self.navigationController?.pushViewController(PayViewController(), animated: true)
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
