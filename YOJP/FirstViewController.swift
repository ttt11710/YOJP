//
//  FirstViewController.swift
//  YOJP
//
//  Created by PayBay on 15/11/23.
//  Copyright © 2015年 PayBay. All rights reserved.
//

import UIKit
import TBIconTransitionKit
import MMDrawerController



var defaultFirstViewController : FirstViewController!
class FirstViewController: AMScrollingNavbarViewController,UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout  {

    
    var showLeftViewBtn : TBAnimationButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        defaultFirstViewController = self

        self.creatCollectionView()
        self.setupLeftMenuButton()
        // Do any additional setup after loading the view.
    }

    class func shareFirstViewController() -> FirstViewController {
        return defaultFirstViewController
    }
    
    func creatCollectionView() {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .Vertical
        flowLayout.headerReferenceSize = CGSizeMake(screenWidth, 0)
        flowLayout.sectionInset = UIEdgeInsetsMake(2, 0, 0, 0)
        flowLayout.minimumInteritemSpacing = 2
        flowLayout.minimumInteritemSpacing = 2
        
        self.view.backgroundColor = UIColor.whiteColor()
        
        let collectionView = UICollectionView(frame: CGRectMake(0, 64, screenWidth, screenHeight), collectionViewLayout: flowLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = yojpTableViewColor
        
        collectionView.registerNib(UINib(nibName: "myCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "myCollectionViewCellId")
        collectionView.registerClass(myCollectionReusableView.classForCoder(), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "myCollectionReusableViewId")
        
        self.view.addSubview(collectionView)
        
        self.followScrollView(collectionView)
    }
    
    func setupLeftMenuButton() {
        
        
        self.showLeftViewBtn = TBAnimationButton(type: .Custom)
        self.showLeftViewBtn.frame = CGRectMake(20, screenHeight-60, 40, 40)
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


    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 9
    }
    
    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        return 2
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
