//
//  MainViewController.swift
//  YOJP
//
//  Created by PayBay on 15/11/9.
//  Copyright © 2015年 PayBay. All rights reserved.
//

import UIKit
import TBIconTransitionKit
import MMDrawerController


var defaultMainViewController : MainViewController!

class MainViewController: AMScrollingNavbarViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource {

    var showLeftViewBtn : TBAnimationButton!
    
    
    var tabBarView : UIImageView!
    var previousBtn : NTButton!
    var scorllView : UIView!
    
    var tableView : UITableView!
    var collectionView : UICollectionView!

    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.restorationIdentifier = "MMExampleCenterControllerRestorationKey"
        
        defaultMainViewController = self
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.creatCollectionView()
        self.creatTableView()
        self.setupLeftMenuButton()
        self.creatNavTitleView()
        
        self.navigationController?.navigationBar.barTintColor = yojpBlue
        
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
    }

    
    func creatNavTitleView() {
        
        self.tabBarView = UIImageView(frame: CGRectMake(0, 0, screenWidth-16, 44))
        self.tabBarView.backgroundColor = yojpBlue
        self.tabBarView.userInteractionEnabled = true
        self.navigationItem.titleView = self.tabBarView
        
        self.scorllView = UIView(frame: CGRectMake(0,self.tabBarView.frame.size.height-2,self.tabBarView.frame.size.width/2,2))
        self.scorllView.backgroundColor = UIColor.whiteColor()
        self.tabBarView.addSubview(self.scorllView)
        
        self.navigationController?.navigationBar.translucent = false
        
        self.creatButtonWithNormalName("店铺", SelectName: "未评价高亮", Index: 0)
        self.creatButtonWithNormalName("品牌", SelectName: "已评价高亮", Index: 1)

        self.previousBtn = NTButton()
        let button : NTButton = self.tabBarView.subviews[1] as! NTButton
        self.changeViewController(button)
    }
    
    func creatCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .Vertical
        flowLayout.headerReferenceSize = CGSizeMake(screenWidth, 0)
        flowLayout.sectionInset = UIEdgeInsetsMake(2, 0, 0, 0)
        flowLayout.minimumInteritemSpacing = 2
        flowLayout.minimumInteritemSpacing = 2
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.collectionView = UICollectionView(frame: CGRectMake(0, 0, screenWidth, screenHeight-20), collectionViewLayout: flowLayout)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.backgroundColor = yojpTableViewColor
        
        self.collectionView.registerNib(UINib(nibName: "myCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "myCollectionViewCellId")
        self.collectionView.registerClass(myCollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "myCollectionReusableViewId")
        
        self.view.addSubview(self.collectionView)
        
        self.followScrollView(self.collectionView)
        
    }
    
    func creatTableView() {
        self.tableView = UITableView(frame: CGRectMake(screenWidth, 0, screenWidth, screenHeight-64), style: .Plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        self.followScrollView(self.tableView)
    }
    
    func creatBtn() {
       
        let mapViewBtn : UIButton = UIButton(type: .Custom)
        mapViewBtn.frame = CGRectMake(screenWidth/2-40, 100, 80, 40)
        mapViewBtn.setTitle("地图", forState: UIControlState.Normal)
        mapViewBtn.setTitleColor(yojpBlue, forState: UIControlState.Normal)
        mapViewBtn.addTarget(self, action: Selector("gotoMapView"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(mapViewBtn)
        
        let translateViewBtn : UIButton = UIButton(type: .Custom)
        translateViewBtn.frame = CGRectMake(screenWidth/2-40, 160, 80, 40)
        translateViewBtn.setTitle("翻译", forState: UIControlState.Normal)
        translateViewBtn.setTitleColor(yojpBlue, forState: UIControlState.Normal)
        translateViewBtn.addTarget(self, action: Selector("gotoTranslateView"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(translateViewBtn)
        
        
        let weatherViewBtn : UIButton = UIButton(type: .Custom)
        weatherViewBtn.frame = CGRectMake(screenWidth/2-40, 220, 80, 40)
        weatherViewBtn.setTitle("天气", forState: UIControlState.Normal)
        weatherViewBtn.setTitleColor(yojpBlue, forState: UIControlState.Normal)
        weatherViewBtn.addTarget(self, action: Selector("gotoWeatherView"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(weatherViewBtn)
        
    }
    
    
    
    class func shareMainViewController() -> MainViewController {
        return defaultMainViewController
    }
    
    
    func setupLeftMenuButton() {
        
        
        self.showLeftViewBtn = TBAnimationButton(type: .Custom)
        self.showLeftViewBtn.frame = CGRectMake(20, screenHeight-60-64, 40, 40)
        self.showLeftViewBtn.currentState = TBAnimationButtonState.Menu
        self.showLeftViewBtn.backgroundColor = UIColor(white: 0, alpha: 0.8)
        self.showLeftViewBtn.layer.cornerRadius = 20
        self.showLeftViewBtn.layer.masksToBounds = true
        self.showLeftViewBtn.lineHeight = 3
        self.showLeftViewBtn.lineWidth = 20
        self.showLeftViewBtn.lineSpacing = 3
        self.showLeftViewBtn.addTarget(self, action: Selector("leftDrawerButtonPress:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.showLeftViewBtn)
        self.view.insertSubview(self.showLeftViewBtn, aboveSubview: self.view)
    }
    
    func leftDrawerButtonPress(sender : TBAnimationButton) {
        self.mm_drawerController.toggleDrawerSide(MMDrawerSide.Left, animated: true) { (finished : Bool) -> Void in
            
            self.changeShowLeftBtnType()
        }
    }
    
    func changeShowLeftBtnType() {
        if self.showLeftViewBtn.currentState == TBAnimationButtonState.Menu {
            self.showLeftViewBtn.animationTransformToState(TBAnimationButtonState.Arrow)
        }
        else {
            self.showLeftViewBtn.animationTransformToState(TBAnimationButtonState.Menu)
        }
    }
    
    func changeShowLeftBtnTypeWithInt( num : Int) {
        if num == 0 {
            self.showLeftViewBtn.animationTransformToState(TBAnimationButtonState.Menu)
        }
        else {
            self.showLeftViewBtn.animationTransformToState(TBAnimationButtonState.Arrow)
        }
    }

    
    func gotoMapView() {
        
        self.navigationController?.pushViewController(MapViewController(), animated: true)
        
    }
    
    func gotoTranslateView() {
        self.navigationController?.pushViewController(TranslateViewController(), animated: true)
    }
    
    func gotoWeatherView() {
        self.navigationController?.pushViewController(WeatherViewController(), animated: true)
    }
    
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cellIdentifier : String = "myCollectionViewCellId"
        let cell : myCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! myCollectionViewCell
        
        cell.backgroundColor = UIColor.whiteColor()
        cell.backImageView.image = UIImage(named: String(format: "image%d", indexPath.row))
        cell.desLabel.text = "在这个冬天的早晨，静静的看看柏林老宅里的暖心咖啡馆"
        cell.desLabel.textColor = yojpText
        cell.desLabel.font = font15
        
        if indexPath.row != 0 {
            cell.dateLabel.hidden = false
            cell.dateLabel.text = "1小时前"
            cell.dateLabel.textColor = yojpLightText
            cell.dateLabel.font = font14
 
        }
        else {
            cell.dateLabel.hidden = true
        }
                return cell
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if indexPath.row == 0 {
            return CGSizeMake(screenWidth, 150)
        }
        return CGSizeMake(screenWidth/2-2, (screenWidth-10)/8*3+100)
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSizeMake(screenWidth, 0)
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        var sectionHeader : myCollectionReusableView! = myCollectionReusableView()
        if kind == UICollectionElementKindSectionHeader {
            sectionHeader = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "myCollectionReusableViewId", forIndexPath: indexPath) as! myCollectionReusableView
            
           sectionHeader.backgroundColor = UIColor.redColor()
            
        }
        return sectionHeader
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.showNavbar()
        self.navigationController?.pushViewController(TranslateViewController(), animated: true)
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 300
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        tableView.registerNib(UINib(nibName: "myTableViewCell", bundle: nil), forCellReuseIdentifier: "myTableViewCellId")
        let cell = tableView.dequeueReusableCellWithIdentifier("myTableViewCellId", forIndexPath: indexPath) as! myTableViewCell
        cell.myImageView.image = UIImage(named: String(format: "image%d", indexPath.row))
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        self.showNavbar()
        
        self.navigationController?.pushViewController(WeatherViewController(), animated: true)
    }
    
    func showORhideShowLeftViewBtn(flag : Bool) {
        self.showLeftViewBtn.hidden = flag
    }
    
    
    func creatButtonWithNormalName(normal : String, SelectName : String, Index : Int) {
        
        let customButton = NTButton(type: .Custom)
        customButton.tag = Index
        let buttonW = self.tabBarView.frame.size.width/2
        let buttonH = self.tabBarView.frame.size.height
        
        customButton.frame = CGRectMake(buttonW * CGFloat(Index), 0, buttonW, buttonH)
        
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
            self.previousBtn.enabled = true
            
            self.tableView.setContentOffset(CGPointMake(0, 0), animated: false)
            
            UIView.animateWithDuration(0.25, delay: 0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
                
                if sender.tag == 1 {
                    self.scorllView.layer.transform = CATransform3DMakeTranslation(self.tabBarView.frame.size.width/2, 0, 0)
                    self.collectionView.layer.transform = CATransform3DMakeTranslation(-screenWidth, 0, 0)
                    self.tableView.layer.transform = CATransform3DMakeTranslation(-screenWidth, 0, 0)
                }
                else {
                    self.scorllView.layer.transform = CATransform3DIdentity
                    self.tableView.layer.transform = CATransform3DIdentity
                    self.collectionView.layer.transform = CATransform3DIdentity

                }
                
                }, completion: { (finished : Bool) -> Void in
                
                    sender.enabled = false

                    self.previousBtn = sender
                    
            })
        }
        else {
            sender.enabled = false
        }
    }
    
    func setTabBarViewAlpha(alpha : CGFloat) {
        self.tabBarView.alpha = alpha
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
