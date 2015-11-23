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


extension UIColor {
    
    convenience init(red: Int, green: Int, blue: Int, al: CGFloat) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: al)
    }

    convenience init(netHex:Int, alpha:CGFloat) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff, al: alpha)
    }
}

class MainViewController: AMScrollingNavbarViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout {

    var showLeftViewBtn : TBAnimationButton!
    
    // 按钮选中时的颜色
    let selectedColor = UIColor.whiteColor()
    
    // 按钮未选中时的颜色
    let unSelectedColor = UIColor.grayColor()
    
    // 按钮之间的距离
    let distanceBetweenButton:CGFloat = 6.0
    
    // 当前选中的UIButton
    var currentTag:Int!
    // 当前选中的ViewController
    var currentVC:UIViewController!
    
    let firstVC : FirstViewController = FirstViewController()
    let secondVC : SecondViewController = SecondViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.restorationIdentifier = "MMExampleCenterControllerRestorationKey"
        
        defaultMainViewController = self
        
        self.title = "YO! Japan"
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.creatCollectionView()
        self.setupLeftMenuButton()
        
        self.navigationController?.navigationBar.barTintColor = yojpBlue
        self.navigationController?.navigationBar.translucent = false
        
    }
    
    
    func creatCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .Vertical
        flowLayout.headerReferenceSize = CGSizeMake(screenWidth, 0)
        flowLayout.sectionInset = UIEdgeInsetsMake(2, 0, 0, 0)
        flowLayout.minimumInteritemSpacing = 2
        flowLayout.minimumInteritemSpacing = 2
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        let collectionView = UICollectionView(frame: CGRectMake(0, 0, screenWidth, screenHeight-64), collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = yojpTableViewColor
        
        collectionView.registerNib(UINib(nibName: "myCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "myCollectionViewCellId")
        collectionView.registerClass(myCollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "myCollectionReusableViewId")
        
        self.view.addSubview(collectionView)
        
        self.followScrollView(collectionView)
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
        self.showLeftViewBtn.backgroundColor = UIColor(white: 0, alpha: 0.6)
        self.showLeftViewBtn.layer.cornerRadius = 20
        self.showLeftViewBtn.layer.masksToBounds = true
        self.showLeftViewBtn.lineHeight = 3
        self.showLeftViewBtn.lineWidth = 20
        self.showLeftViewBtn.lineSpacing = 3
        self.showLeftViewBtn.addTarget(self, action: Selector("leftDrawerButtonPress:"), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(self.showLeftViewBtn)
        self.view.insertSubview(self.showLeftViewBtn, aboveSubview: self.view)
        
        // var leftDrawerButton : MMDrawerBarButtonItem = MMDrawerBarButtonItem(image: UIImage(named: "navigation_backView"), style: UIBarButtonItemStyle.Done, target: self, action: Selector("leftDrawerButtonPress"))
        //        var leftDrawerButton : MMDrawerBarButtonItem = MMDrawerBarButtonItem(target: self, action: Selector("leftDrawerButtonPress"))
        //        self.navigationItem.setLeftBarButtonItem(leftDrawerButton, animated: true)
        
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
    
    func showORhideShowLeftViewBtn(flag : Bool) {
        self.showLeftViewBtn.hidden = flag
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
