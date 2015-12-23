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
import SDWebImage


var defaultMainViewController : MainViewController!

class MainViewController: AMScrollingNavbarViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout,UITableViewDelegate,UITableViewDataSource,StoreDetailViewControllerDelegate,UIViewControllerTransitioningDelegate,UIScrollViewDelegate,UISearchBarDelegate {

    var showLeftViewBtn : TBAnimationButton!
    var escapeBtn : UIButton!
    
    var tabBarView : UIImageView!
    var previousBtn : NTButton!
    var tabBarScrollView : UIView!
    
    var tabBarViewWithOneTitle : UILabel!
    
    
    
    var scrollView : UIScrollView!
    var collectionBackView : UIView!
    var collectionView : UICollectionView!
    
    var mysearchController : UISearchController!
    
    var tableViewBackView : UIView!
    var tableView : UITableView!
    
    var tableViewDataArray : NSMutableArray = ["    在这个冬天的早晨，静静的看看柏林老宅里的暖心咖啡馆","    曾经再美，不过一回空谈。脚下艰难，却是直指明天。","    学会了适应，就会让你的环境变得明亮；学会了宽容，就会让你的生活没有烦恼。","    当你能飞的时候，就不要放弃飞;当你能梦的时候，就不要放弃梦。世界没有尽头，只要心中还有追求。人生真正的终点是希望的终结。苍鹰的骄傲是飞翔的双翼，人生的意义是不断的追求。","    最闹心的烦躁是你根本不知道自己究竟在烦什么，无缘无故就全身负能量爆棚 。巴拉拉巴拉拉巴拉拉巴","    所谓的贵人：就是开拓你的眼界，带你进入新的世界。 明天是否辉煌，取决于你今天的选择和行动！","    男人穷不要紧，就怕又穷又有脾气。女人丑也不要紧，就怕又丑又懒惰。","    无论你此刻是否迷茫，在阳光升起的时候，请相信，努力的人最终都有回报 。"]
    

    var awesometransition : HYAwesomeTransition!
    var transitionCell : UIView!
    
    var scrollViewHeight : CGFloat!
    
    var scrollViewChangeHeight : CGFloat = -64
    
    var titleArray : NSMutableArray = ["全部","免费券","打折券","抵扣券","福袋"]
    
    
    var startContentOffsetX : CGFloat = 0
    
    
    var canRecognizer : Bool = false
    var recognizer : UISwipeGestureRecognizer!
    
    
    var showSelectTypeTabelView : Bool = false
    var selectTypeTableViewBackView : UIView!
    var selectTypeTableView : UITableView!
    var selectTypeTableViewDataArray : NSMutableArray = ["清洁类","维护类","保湿类"]

    override func viewDidLoad() {
        super.viewDidLoad()

        
        let leftDrawerButton : MMDrawerBarButtonItem = MMDrawerBarButtonItem(target: self, action: Selector("leftDrawerButtonPress:"))
        self.navigationItem.setLeftBarButtonItem(leftDrawerButton, animated: true)
        
        let rightButtonItem : UIBarButtonItem = UIBarButtonItem(image: UIImage(named: "购物车"), style: .Done, target: self, action: Selector("rightButtonPress"))
        self.navigationItem.setRightBarButtonItem(rightButtonItem, animated: true)
        
        
        NSThread.sleepForTimeInterval(0.0)
        
        self.restorationIdentifier = "MMExampleCenterControllerRestorationKey"
        
        defaultMainViewController = self
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.automaticallyAdjustsScrollViewInsets = false
        
        self.scrollView = UIScrollView(frame: CGRectMake(0,-64,screenWidth,screenHeight))
        self.scrollView.contentSize = CGSizeMake(screenWidth*2, 0)
        self.scrollView.contentOffset = CGPointMake(0, 0)
        self.scrollView.pagingEnabled = true
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.showsVerticalScrollIndicator = false
        self.scrollView.delegate = self
        self.scrollView.bounces = false
        self.scrollView.canCancelContentTouches = false
        self.view.addSubview(self.scrollView)
        
        self.followScrollView(self.view)
        
        self.collectionBackView = UIView(frame: CGRectMake(0,0,screenWidth,screenHeight))
        self.scrollView.addSubview(self.collectionBackView)
        
        
        self.tableViewBackView = UIView(frame: CGRectMake(screenWidth,0,screenWidth,screenHeight))
        self.scrollView.addSubview(self.tableViewBackView)
        
        self.creatCollectionView()
        self.creatTableView()
        self.setupLeftMenuButton()
        self.creatEscapeBtn()
        self.creatNavTitleView()
        self.creatRecognizer()
        
        self.createSelectTypeTableView()
        
        self.navigationController?.navigationBar.barTintColor = yojpBlue
        
        
        self.awesometransition = HYAwesomeTransition()
        self.awesometransition.duration = 1.5
        
        let backView = UIView(frame: CGRectMake(0,0,screenWidth,screenHeight))
        self.awesometransition.containerBackgroundView = backView
    }
    
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        
        
        UIApplication.sharedApplication().statusBarStyle = .LightContent
        
        
        let leftViewController : LeftViewController = LeftViewController()
        let navC : MyNavigationController = MyNavigationController(rootViewController: leftViewController)
        self.mm_drawerController.leftDrawerViewController = navC
        
        
        self.scrollViewChangeHeight = -64
        self.scrollView.contentOffset = CGPointMake(self.scrollView.contentOffset.x, self.scrollViewChangeHeight)
        
        self.showLeftViewBtn.frame = CGRectMake(20, screenHeight-60-64, 40, 40)
        self.escapeBtn.frame = CGRectMake(10, screenHeight-60-64-118, 120, 108)

    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        
        self.mm_drawerController.closeDrawerAnimated(true, completion: { (finished : Bool) -> Void in
            self.mm_drawerController.leftDrawerViewController = nil
        })
    }
    
    
    func creatNavTitleView() {
        
        self.tabBarView = UIImageView(frame: CGRectMake(0, 50, screenWidth-16-100, 44))
        self.tabBarView.backgroundColor = yojpBlue
        self.tabBarView.userInteractionEnabled = true
        self.navigationItem.titleView = self.tabBarView
        
        self.tabBarViewWithOneTitle = UILabel(frame: CGRectMake(0,0,screenWidth-16,44))
        self.tabBarViewWithOneTitle.textColor = UIColor.whiteColor()
        self.tabBarViewWithOneTitle.textAlignment = .Center
        
        
        self.tabBarScrollView = UIView(frame: CGRectMake(0,self.tabBarView.frame.size.height-3,self.tabBarView.frame.size.width/2,4))
        self.tabBarScrollView.backgroundColor = UIColor.whiteColor()
        self.tabBarView.addSubview(self.tabBarScrollView)
        
        self.navigationController?.navigationBar.translucent = false
        
        self.creatButtonWithNormalName("店铺", SelectName: "未评价高亮", Index: 0)
        self.creatButtonWithNormalName("品牌", SelectName: "已评价高亮", Index: 1)

        self.previousBtn = NTButton()
        let button : NTButton = self.tabBarView.subviews[1] as! NTButton
        self.changeViewController(button)
    }
    
    func creatRecognizer() {
        self.recognizer = UISwipeGestureRecognizer(target: self, action: Selector("handleSwipeFrom:"))
        self.recognizer.direction = .Left
        self.collectionBackView.addGestureRecognizer(self.recognizer)
    }
    
    
    func createSelectTypeTableView() {
        
        self.selectTypeTableViewBackView = UIView(frame: CGRectMake(0, 64, screenWidth, screenHeight))
        self.selectTypeTableViewBackView.hidden = true
        //self.selectTypeTableViewBackView.userInteractionEnabled = false
        
        self.selectTypeTableView = UITableView(frame: CGRectMake(screenWidth/2, 64 , screenWidth/2, 44*CGFloat(self.selectTypeTableViewDataArray.count)))
        self.selectTypeTableView.tableFooterView = UIView()
        self.selectTypeTableView.dataSource = self
        self.selectTypeTableView.delegate = self
        self.selectTypeTableView.backgroundColor = UIColor.clearColor()
        self.selectTypeTableView.scrollEnabled = false
    
        self.selectTypeTableView.hidden = true
        //self.collectionBackView.addSubview(self.selectTypeTableViewBackView)
        
       // self.view.insertSubview(self.selectTypeTableViewBackView, aboveSubview: self.view)
        self.view.insertSubview(self.selectTypeTableView, aboveSubview: self.view)
    }

    
    func handleSwipeFrom(recognizer : UISwipeGestureRecognizer) {
        print("1111111111111")
    }
    

    
    func creatCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .Vertical
        flowLayout.headerReferenceSize = CGSizeMake(screenWidth, 37)
        flowLayout.sectionInset = UIEdgeInsetsMake(2, 0, 0, 0)
        flowLayout.minimumInteritemSpacing = 2
        flowLayout.minimumInteritemSpacing = 2
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.collectionView = UICollectionView(frame: CGRectMake(0, 0, screenWidth, screenHeight-20), collectionViewLayout: flowLayout)
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.backgroundColor = yojpTableViewColor
        
        self.collectionBackView.addSubview(self.collectionView)
        
      //  self.collectionView.registerClass(SearchCollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "searchCollectionReusableViewId")
        self.collectionView.registerNib(UINib(nibName: "SearchCollectionReusableView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "SearchCollectionReusableViewId")
        
      //  self.collectionView.registerClass(SearchCollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "SearchCollectionReusableViewId")
        
    }
    
    func creatTableView() {
        self.tableView = UITableView(frame: CGRectMake(0, 0, screenWidth, screenHeight-20), style: .Plain)
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.separatorStyle = .None
        self.tableViewBackView.addSubview(self.tableView)
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
        self.showLeftViewBtn.hidden = true
        self.showLeftViewBtn.currentState = TBAnimationButtonState.Menu
        self.showLeftViewBtn.backgroundColor = UIColor(white: 0, alpha: 0.8)
        self.showLeftViewBtn.layer.cornerRadius = 20
        self.showLeftViewBtn.layer.masksToBounds = true
        self.showLeftViewBtn.lineHeight = 3
        self.showLeftViewBtn.lineWidth = 20
        self.showLeftViewBtn.lineSpacing = 3
        self.showLeftViewBtn.addTarget(self, action: Selector("leftDrawerButtonPress:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.insertSubview(self.showLeftViewBtn, aboveSubview: self.view)
    }
    
    func creatEscapeBtn() {
        
        self.escapeBtn = UIButton(type: .Custom)
        self.escapeBtn.frame = CGRectMake(10, screenHeight-60-64-118, 120, 108)
        self.escapeBtn.setBackgroundImage(UIImage(named: "escape"), forState: .Normal)
        self.escapeBtn.addTarget(self, action: Selector("showEscapeView"), forControlEvents: .TouchUpInside)
        self.escapeBtn.setBackgroundImage(UIImage(named: "escape"), forState: .Highlighted)
        
        self.view.insertSubview(self.escapeBtn, aboveSubview: self.view)
    }
    
    func leftDrawerButtonPress(sender : TBAnimationButton) {
        self.mm_drawerController.toggleDrawerSide(MMDrawerSide.Left, animated: true) { (finished : Bool) -> Void in
            
            self.changeShowLeftBtnType()
        }
    }
    
    func changeShowLeftBtnType() {
        if self.showLeftViewBtn.currentState == TBAnimationButtonState.Menu {
            self.showLeftViewBtn.hidden = false
            self.showLeftViewBtn.animationTransformToState(TBAnimationButtonState.Arrow)
        }
        else {
            self.showLeftViewBtn.hidden = true
            self.showLeftViewBtn.animationTransformToState(TBAnimationButtonState.Menu)
        }
    }
    
    func changeShowLeftBtnTypeWithInt( num : Int) {
        if num == 0 {
            self.showLeftViewBtn.hidden = true
            self.showLeftViewBtn.animationTransformToState(TBAnimationButtonState.Menu)
        }
        else {
            self.showLeftViewBtn.hidden = false
            self.showLeftViewBtn.animationTransformToState(TBAnimationButtonState.Arrow)
        }
    }

    func showEscapeView() {
        
        SVProgressShow.showInfoWithStatus("此操作会进入逃生页面!")
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
        
        if indexPath.row == 0 {
            
            self.collectionView.registerNib(UINib(nibName: "ScrollViewCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ScrollViewCollectionViewCellId")
          //  self.collectionView.registerClass(ScrollViewCollectionViewCell.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "ScrollViewCollectionViewCellId")
            
            let cellIdentifier : String = "ScrollViewCollectionViewCellId"
            let cell : ScrollViewCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! ScrollViewCollectionViewCell
            
            cell.layoutIfNeeded()
            
            return cell
        }
        else {
            
            self.collectionView.registerNib(UINib(nibName: "myCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "myCollectionViewCellId")
            
          //  self.collectionView.registerClass(myCollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "myCollectionReusableViewId")
            
            let cellIdentifier : String = "myCollectionViewCellId"
            let cell : myCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier(cellIdentifier, forIndexPath: indexPath) as! myCollectionViewCell
            
            cell.backgroundColor = UIColor.whiteColor()
            cell.backImageView.image = UIImage(named: String(format: "image%d", indexPath.row))
            cell.desLabel.text = "在这个冬天的早晨，静静的看看柏林老宅里的暖心咖啡馆"
            cell.desLabel.textColor = yojpText
            cell.desLabel.font = font15
            cell.dateLabel.text = "1小时前"
            cell.dateLabel.textColor = yojpLightText
            cell.dateLabel.font = font14
            
            cell.layoutIfNeeded()
            
            return cell
            
        }
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        if indexPath.row == 0 {
            return CGSizeMake(screenWidth, 200)
        }
        return CGSizeMake(screenWidth/2-2, (screenWidth-10)/8*3+100)
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSizeMake(screenWidth,0)
    }
    
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        
        let resueIdentifier : String!
        if kind == UICollectionElementKindSectionHeader {
            resueIdentifier = "SearchCollectionReusableViewId"
        }
        
        let sectionHeader : SearchCollectionReusableView = collectionView.dequeueReusableSupplementaryViewOfKind(UICollectionElementKindSectionHeader, withReuseIdentifier: "SearchCollectionReusableViewId", forIndexPath: indexPath) as! SearchCollectionReusableView
        
        print(sectionHeader.viewWithTag(1))
        
        if kind == UICollectionElementKindSectionHeader {
            
            
//            let searchImageView : UIImageView = UIImageView(image: UIImage(named: "搜索条"))
//            searchImageView.frame = CGRectMake(0, 0, screenWidth, 37)
//            sectionHeader.addSubview(searchImageView)
//            let showSearchViewTap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("presentSearchView"))
//            searchImageView.addGestureRecognizer(showSearchViewTap)
//            searchImageView.userInteractionEnabled = true
//            
//            let allLabel : UILabel = UILabel(frame: CGRectMake(screenWidth-60,3,55,32))
//            allLabel.text = "全部"
//            allLabel.backgroundColor = yojpBlue
//            allLabel.textColor = UIColor.whiteColor()
//            searchImageView.addSubview(allLabel)
//            let allLabelTap : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: Selector("selectType"))
//            allLabel.addGestureRecognizer(allLabelTap)
//            allLabel.userInteractionEnabled = true
            
        }
        return sectionHeader
    }
    
    
    func selectType() {
        
        self.showSelectTypeTabelView = !self.showSelectTypeTabelView
        if self.showSelectTypeTabelView {
            
            self.scrollView.scrollEnabled = false
            self.collectionView.scrollEnabled = false
           // self.collectionView.userInteractionEnabled = false
            self.selectTypeTableViewBackView.hidden = false
            self.selectTypeTableView.hidden = false
            
//            UIView.animateWithDuration(0.8, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
//                
//                self.selectTypeTableView.layer.transform = CATransform3DMakeTranslation(-screenWidth/2, 0, 0)
//                
//                }, completion: { (finished : Bool) -> Void in
//                    
//            })
//            
//            UIView.animateWithDuration(0.3, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
//                
//                self.selectTypeTableViewBackView.backgroundColor = UIColor(white: 0, alpha: 0.5)
//                
//                }, completion: { (finished : Bool) -> Void in
//                    
//            })
        }
        else {
            
            self.selectTypeTableView.hidden = true
//            UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
//                self.selectTypeTableView.layer.transform = CATransform3DIdentity
//                self.selectTypeTableViewBackView.backgroundColor = UIColor.clearColor()
//                
//                }) { (finished : Bool) -> Void in
//                    
//                    self.selectTypeTableViewBackView.hidden = true
//                    
//            }
        }
    }

    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        self.showNavbar()
        //self.navigationController?.pushViewController(TranslateViewController(), animated: true)
        
//        let cell : myCollectionViewCell = collectionView.cellForItemAtIndexPath(indexPath) as! myCollectionViewCell
//        
//        let vc : StoreDetailViewController = StoreDetailViewController()
//        vc.transitioningDelegate = self
//        vc.initView()
//        vc.delegate = self
//        vc.imageView.hidden = true
//        
//        
//        var bounds : CGRect = cell.backImageView.bounds
//        bounds.origin.y = bounds.origin.y+64
//        let startFrame : CGRect = cell.backImageView.convertRect(bounds, toView: self.view)
//        let finalFrame : CGRect = vc.imageView.frame
//        
//        self.awesometransition.registerStartFrame(startFrame, finalFrame: finalFrame, transitionView: cell.backImageView)
//        cell.backImageView.hidden = true
//        
//        self.transitionCell = cell.backImageView
//        let weakVC : StoreDetailViewController = vc
        
//        self.presentViewController(vc, animated: true) { () -> Void in
//           
//            
//            weakVC.imageView.image = UIImage(named: String(format: "image%d", indexPath.row))
//            weakVC.imageView.hidden = false
//            
//        }
        
        self.navigationController?.pushViewController(StoreDetailViewController(), animated: true)
    
    }
    
    func modalViewControllerDidClickedDismissButton(viewController: StoreDetailViewController , height : CGFloat) {
        
        self.scrollViewHeight = height
        
        self.dismissViewControllerAnimated(true) { () -> Void in
            
            self.transitionCell.hidden = false
            
        }
    }
       
    func animationControllerForPresentedController(presented: UIViewController, presentingController presenting: UIViewController, sourceController source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.awesometransition.present = true
        return self.awesometransition
    }
    
    func animationControllerForDismissedController(dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        self.awesometransition.present = false
        
        self.awesometransition.finalFrame = CGRectMake(self.awesometransition.finalFrame.origin.x, self.awesometransition.finalFrame.origin.y-self.scrollViewHeight, self.awesometransition.finalFrame.size.width, self.awesometransition.finalFrame.size.height)
        
        return self.awesometransition
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        if tableView == self.tableView {
            return 1
        }
        else {
            return self.selectTypeTableViewDataArray.count
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == self.tableView {
            return 7
        }
        else {
            return 1
        }
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        
        if tableView == self.tableView {
            let label : UILabel = UILabel(frame: CGRectMake(0,0,screenWidth-16,30))
            label.font = font15
            label.textColor = yojpText
            label.text = self.tableViewDataArray[indexPath.row] as? String
            label.numberOfLines = 0
            label.sizeToFit()
            return screenWidth/5*3+8+label.frame.size.height+8
        }
        else {
            return 44
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if tableView == self.tableView {
            tableView.registerNib(UINib(nibName: "BrandTableViewCell", bundle: nil), forCellReuseIdentifier: "BrandTableViewCellId")
            let cell = tableView.dequeueReusableCellWithIdentifier("BrandTableViewCellId", forIndexPath: indexPath) as! BrandTableViewCell
            
            cell.selectionStyle = .None
            
            cell.backImageView.image = UIImage(named: String(format: "image%d", indexPath.row))
            cell.desLabel.text = self.tableViewDataArray[indexPath.row] as? String
            cell.desLabel.textColor = yojpText
            
            
            return cell
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
            self.showNavbar()
            
            // self.tableView.removeFromSuperview()
            self.navigationController?.pushViewController(StoreDetailViewController(), animated: true)
        }
        else {
            self.showSelectTypeTabelView = !self.showSelectTypeTabelView
            self.scrollView.scrollEnabled = true
            self.collectionView.scrollEnabled = true
            
            
            self.selectTypeTableView.hidden = true
            
//            UIView.animateWithDuration(0.5, delay: 0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
//                self.selectTypeTableView.layer.transform = CATransform3DIdentity
//                self.selectTypeTableViewBackView.backgroundColor = UIColor.clearColor()
//                
//                }) { (finished : Bool) -> Void in
//                    
//                    self.selectTypeTableViewBackView.hidden = true
//                    
//                    let myPath : NSIndexPath = NSIndexPath(forRow: 0, inSection: indexPath.section)
//                    self.tableView.selectRowAtIndexPath(myPath, animated: true, scrollPosition: UITableViewScrollPosition.Top)
//            }
        }
    }
    
    func showORhideShowLeftViewBtn(flag : Bool) {
        self.showLeftViewBtn.hidden = flag
        
        if self.showLeftViewBtn.currentState == TBAnimationButtonState.Menu {
            self.showLeftViewBtn.hidden = true
        }
        else {
            self.showLeftViewBtn.hidden = false
        }

        
        self.escapeBtn.hidden = flag
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
            
           // self.navigationItem.titleView?.userInteractionEnabled = false
            
            self.previousBtn.enabled = true
            self.previousBtn = sender
            
            
            sender.enabled = false
            
            UIView.animateWithDuration(0.8, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0, options: UIViewAnimationOptions.CurveLinear, animations: { () -> Void in
                
                if sender.tag == 1 {
                    
                    self.startContentOffsetX = screenWidth
                    
                    self.scrollView.contentOffset = CGPointMake(screenWidth, self.scrollViewChangeHeight)
                    
                    self.tabBarScrollView.layer.transform = CATransform3DMakeTranslation(self.tabBarView.frame.size.width/2, 0, 0)
                    
                }
                else {

                    self.startContentOffsetX = 0
                    
                    self.scrollView.contentOffset = CGPointMake(0, self.scrollViewChangeHeight)
                    self.tabBarScrollView.layer.transform = CATransform3DIdentity
                }
                
                }, completion: { (finished : Bool) -> Void in
                    
                    self.navigationItem.titleView?.userInteractionEnabled = true
                    
            })
        }
        else {
            sender.enabled = false
        }
    }
    
    func setTabBarViewAlpha(alpha : CGFloat) {
        self.tabBarView.alpha = alpha
        self.tabBarViewWithOneTitle.alpha = alpha
        self.scrollViewChangeHeight = 0
        
        self.showLeftViewBtn.frame = CGRectMake(20, screenHeight-60-64-alpha*44-20, 40, 40)
        self.escapeBtn.frame = CGRectMake(10, screenHeight-60-64-118-alpha*44-20, 120, 108)
        
        if alpha == 1 {
            self.showLeftViewBtn.frame = CGRectMake(20, screenHeight-60-64-64, 40, 40)
            self.escapeBtn.frame = CGRectMake(10, screenHeight-60-64-118-64, 120, 108)
        }

        print(alpha,alpha*64,self.escapeBtn.frame)
    }
    
    func presentSearchView() {
        
        self.navigationController?.presentViewController(SearchViewController(), animated: true, completion: { () -> Void in
            
        })
        
    }
    
    
    func changeNavigationItemTitleView(row : Int) {
        
        switch row {
        case 1:
            self.navigationItem.titleView = self.tabBarView
            self.scrollView.contentSize = CGSizeMake(screenWidth*2, 0)
        case 2,3,4,5:
            self.tabBarViewWithOneTitle.text = titleArray.objectAtIndex(row-1) as? String
            self.navigationItem.titleView = self.tabBarViewWithOneTitle
            self.scrollView.contentSize = CGSizeMake(screenWidth, 0)
        default :
            break
        }
        let button : NTButton = self.tabBarView.subviews[1] as! NTButton
        self.changeViewController(button)
        self.changeShowLeftBtnType()
        
    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        
        print( "scrollViewDidEndDecelerating scrollView.contentOffset.x " , scrollView.contentOffset.x)
        
        if scrollView == self.scrollView {
           // print( "scrollViewDidEndDecelerating scrollView.contentOffset.x " , scrollView.contentOffset.x)
            let page = Int(scrollView.contentOffset.x / screenWidth)
            let button : NTButton = self.tabBarView.subviews[page+1] as! NTButton
            self.changeViewController(button)
            self.startContentOffsetX = scrollView.contentOffset.x
            
        }
    }
    
    func scrollViewWillBeginDecelerating(scrollView: UIScrollView) {
        print("scrollViewWillBeginDecelerating")
    }
    
    
    func scrollViewWillBeginZooming(scrollView: UIScrollView, withView view: UIView?) {
        print("scrollViewWillBeginZooming")
    }
    
    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
        print("scrollViewWillBeginDragging",scrollView)
        if scrollView == self.scrollView {
            if scrollView.contentOffset.x == 0 {
                self.canRecognizer = true
            }
            else {
                self.canRecognizer = false
            }
        }
        
    }
    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        print("scrollViewWillEndDragging",velocity,scrollView)
        if scrollView == self.scrollView {
            if velocity.x <= 0 && self.canRecognizer {
                
                self.showORhideShowLeftViewBtn(false)
                self.mm_drawerController.toggleDrawerSide(MMDrawerSide.Left, animated: true) { (finished : Bool) -> Void in
                    
                    self.changeShowLeftBtnType()
                    self.canRecognizer = false
                    
                }
            }
            
        }
    }
    
    func rightButtonPress() {
        self.navigationController?.pushViewController(ShopCarListViewController(), animated: true)
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
